from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import os
from app_db import router as db_router  # ✔ app_db로 바뀜

app = FastAPI()

# router 연결
app.include_router(db_router)


# 서버에서 이미지를 받은 후 저장할 dir 생성
UPLOAD_DIR = "upload_images" #저장 될 폴더명
os.makedirs(UPLOAD_DIR,exist_ok=True)

class PregnancyUser(BaseModel):
    babyNickname: str
    startDate: str      # yyyy-mm-dd 형태
    phone: str

# 이미지 받는 코드
@app.post("/image-data")
async def single_image(file : UploadFile = File(...)): 
    #File(...) ->  multipart/form-data 이미지를 받기 위한 형식 맞추는 코드
    #file 이름으로 데이터가 들어오고 file name, path 정보를 가지고 있다

    #저장 할 경로 설정
    file_path = os.path.join(UPLOAD_DIR, file.filename)

    #파일 저장 wb : write binary
    with open(file_path, "wb") as f:
        f.write(await file.read())

    print(file.filename)


    return JSONResponse(content={"status": "success", "filename": file.filename})



@app.get("/")
async def index():
    #get mapping으로 url 주소를 /로 하겠다
    #결과값은 String or Json/html
    #return에 작성되는 코드는 보여질 페이지
    return "hello"

@app.get("/get-data")
async def getData(data : str): #get방식에서 받을 데이터가 있는 경우 매개변수 작성
    # 작성방식 변수명 : 타입
    print(data)
    
    return {"보내준 데이터" : data}
#dict 구조 -> json 변환


#fastAPI에서 post 데이터 받는 법
#BaseModel -> 클래스 만들어 타입검증, 문서화

class DataModel(BaseModel):
    data : str

@app.post("/post-data")
async def postData(dataModel : DataModel):
    print(dataModel.data)
    return {"보내준 데이터는 : " : dataModel.data}





# fast api 서버 실행 코드
# python -m uvicorn app:app --host 192.168.219.97 --port 8001 --reload
# python -m uvicorn 파일명:app --host 서버ip주소 --port 포트번호(기본포트는 8000) --reload


