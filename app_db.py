from fastapi import APIRouter, HTTPException
import oracledb
import random

# Oracle Instant Client 경로
oracledb.init_oracle_client(lib_dir=r"C:\oraclexe\instantclient_23_0")

router = APIRouter()

print("🔥 app_db.py 로딩 시작됨")

# ============================
#       ORACLE POOL
# ============================
pool = None

def get_pool():
    global pool
    if pool is None:
        pool = oracledb.create_pool(
            user="campus_24K_LG3_DX9_p3_5",
            password="smhrd5",
            dsn="project-db-campus.smhrd.com:1524/xe",
            min=1,
            max=5,
            increment=1
        )
    return pool


# ============================
#     6자리 고유키 생성
# ============================
def generate_unique_key():
    return ''.join(random.choices("0123456789", k=6))


# ============================
#   중복 없는 고유키 생성
# ============================
def create_unique_key(cur):
    while True:
        key = generate_unique_key()
        cur.execute("SELECT COUNT(*) FROM PREGNANCY_USER WHERE UNIQUE_KEY = :1", [key])
        count = cur.fetchone()[0]

        if count == 0:
            return key


# ============================
#        임신정보 등록
# ============================
@router.post("/register_pregnancy")
async def register_pregnancy(data: dict):
    baby_nickname = data.get("babyNickname")
    start_date = data.get("startDate")  # yyyy-mm-dd

    if not baby_nickname or not start_date:
        raise HTTPException(status_code=400, detail="babyNickname, startDate 모두 필요합니다.")

    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        unique_key = create_unique_key(cur)

        cur.execute("""
            INSERT INTO PREGNANCY_USER (UNIQUE_KEY, BABY_NICKNAME, START_DATE)
            VALUES (:1, :2, TO_DATE(:3, 'YYYY-MM-DD'))
        """, [unique_key, baby_nickname, start_date])

        cur.execute("""
            INSERT INTO USER_GROUP (UNIQUE_KEY, MEMBER_INDEX, RELATION)
            VALUES (:1, 1, '임산부')
        """, [unique_key])

        conn.commit()
            
        return {
            "success": True,
            "uniqueKey": unique_key
        }

    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        cur.close()
        conn.close()


# ============================
#      고유키로 정보 조회
# ============================
@router.get("/pregnancy/{unique_key}")
async def get_pregnancy_info(unique_key: str):
    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        cur.execute("""
            SELECT BABY_NICKNAME, START_DATE
            FROM PREGNANCY_USER
            WHERE UNIQUE_KEY = :1
        """, [unique_key])

        row = cur.fetchone()

        if not row:
            return {"exists": False}

        # 날짜를 yyyy-mm-dd 형태로 변환
        start_date_str = row[1].strftime("%Y-%m-%d")

        return {
            "exists": True,
            "uniqueKey": unique_key,
            "babyNickname": row[0],
            "startDate": start_date_str
        }

    finally:
        cur.close()
        conn.close()


# ============================
#   임신 정보 수정 (UPDATE)
# ============================
@router.put("/pregnancy/update")
async def update_pregnancy_info(data: dict):
    unique_key = data.get("uniqueKey")
    new_nickname = data.get("babyNickname")
    new_start_date = data.get("startDate")  # yyyy-mm-dd

    if not unique_key or not new_nickname or not new_start_date:
        raise HTTPException(status_code=400, detail="모든 데이터가 필요합니다.")

    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        cur.execute("""
            UPDATE PREGNANCY_USER
            SET BABY_NICKNAME = :1,
                START_DATE = TO_DATE(:2, 'YYYY-MM-DD')
            WHERE UNIQUE_KEY = :3
        """, [new_nickname, new_start_date, unique_key])

        conn.commit()

        if cur.rowcount == 0:
            raise HTTPException(status_code=404, detail="해당 사용자가 없습니다.")

        return {"success": True}

    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        cur.close()
        conn.close()


# ============================
#   그룹 멤버 조회 (UNIQUE_KEY 기준)
# ============================
@router.get("/group/{unique_key}/members")
async def get_group_members(unique_key: str):
    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        cur.execute(
            """
            SELECT MEMBER_ID, UNIQUE_KEY, MEMBER_INDEX, RELATION
            FROM USER_GROUP
            WHERE UNIQUE_KEY = :1
            ORDER BY MEMBER_INDEX
            """,
            [unique_key],
        )

        rows = cur.fetchall()

        members = [
            {
                "memberId": row[0],
                "uniqueKey": row[1],
                "memberIndex": row[2],
                "relation": row[3],   # ★ 추가됨
            }
            for row in rows
        ]

        return {"members": members}

    finally:
        cur.close()
        conn.close()


# ================================
#   초대코드로 그룹 합류 (게스트)
# ================================
print("🔥 join_group 함수 바로 위까지 실행됨")

@router.post("/group/join")
async def join_group(data: dict):
    unique_key = data.get("uniqueKey")
    relation = data.get("relation")  # ★ 새로 추가됨

    if not unique_key or not relation:
        raise HTTPException(status_code=400, detail="uniqueKey와 relation은 필수입니다.")

    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        # 1) 해당 그룹이 존재하는지 확인 (임산부가 이미 그룹 생성했는지)
        cur.execute("""
            SELECT COUNT(*) FROM USER_GROUP
            WHERE UNIQUE_KEY = :1
        """, [unique_key])

        exists = cur.fetchone()[0]

        if exists == 0:
            raise HTTPException(status_code=404, detail="해당 그룹이 존재하지 않습니다.")

        # 2) 현재 그룹의 가장 높은 MEMBER_INDEX 찾기
        cur.execute("""
            SELECT NVL(MAX(MEMBER_INDEX), 0)
            FROM USER_GROUP
            WHERE UNIQUE_KEY = :1
        """, [unique_key])

        max_index = cur.fetchone()[0]
        new_index = max_index + 1  # 새 사용자 index

        # 3) USER_GROUP에 새 멤버 INSERT (RELATION 포함)
        cur.execute("""
            INSERT INTO USER_GROUP (UNIQUE_KEY, MEMBER_INDEX, RELATION)
            VALUES (:1, :2, :3)
        """, [unique_key, new_index, relation])

        conn.commit()

        # 4) 새로 생성된 MEMBER_ID 조회
        cur.execute("""
            SELECT MEMBER_ID 
            FROM USER_GROUP
            WHERE UNIQUE_KEY = :1 AND MEMBER_INDEX = :2
        """, [unique_key, new_index])

        new_member_id = cur.fetchone()[0]

        return {
            "success": True,
            "memberId": new_member_id,
            "uniqueKey": unique_key,
            "relation": relation,
            "memberIndex": new_index
        }

    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        cur.close()
        conn.close()

@router.get("/getLogs")
async def get_logs():
    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()
 
    try:
        cur.execute("SELECT DEVICE_ID, EVENT_TIME, SOURCE_TYPE, EXTRA_INFO, POWER_STATE FROM DEVICE_USAGE_LOG")
        rows = cur.fetchall()
 
        # Oracle은 기본적으로 tuple 반환 → dict로 변환 필요
        result = []
        for r in rows:
            result.append({
                "DEVICE_ID": r[0],
                "EVENT_TIME": r[1].strftime("%Y-%m-%d %H:%M:%S"),
                "SOURCE_TYPE": r[2],
                "EXTRA_INFO": r[3],
                "POWER_STATE": r[4]
            })
 
        return result
 
    finally:
        cur.close()
        conn.close()

# ================================
#   캘린더 작성 내용 저장
# ================================
from fastapi import HTTPException  # 이미 있으면 생략

@router.post("/calendar_data")
async def save_calendar(data: dict):
    # Flutter에서 오는 값
    write_date  = data.get("writeDate")      # "yyyy-MM-dd"
    todo_list   = data.get("todoList", "")   # 오늘 해야 할 일
    today_diary = data.get("todayDiary", "") # 오늘의 이야기(여러 줄 합친 것)

    if not write_date:
        raise HTTPException(status_code=400, detail="writeDate는 필수입니다.")

    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        cur.execute("""
            INSERT INTO SCHEDULE (TODO_LIST, TODAY_DIARY, WRITE_DATE)
            VALUES (:1, :2, TO_DATE(:3, 'YYYY-MM-DD'))
        """, [todo_list, today_diary, write_date])

        conn.commit()
        return {"success": True}

    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        cur.close()
        conn.close()

@router.get("/calendar_data/{write_date}")
async def get_calendar(write_date: str):

    pool = get_pool()
    conn = pool.acquire()
    cur = conn.cursor()

    try:
        cur.execute("""
            SELECT TODO_LIST, TODAY_DIARY
            FROM SCHEDULE
            WHERE WRITE_DATE = TO_DATE(:1, 'YYYY-MM-DD')
        """, [write_date])

        row = cur.fetchone()

        if not row:
            return {
                "todo": "",
                "stories": []
            }

        todo = row[0] or ""
        diary_text = row[1] or ""

        # 문자열을 줄바꿈 기준으로 분리 → List로 반환
        stories = [line for line in diary_text.split("\n") if line.strip()]

        return {
            "todo": todo,
            "stories": stories
        }

    finally:
        cur.close()
        conn.close()




