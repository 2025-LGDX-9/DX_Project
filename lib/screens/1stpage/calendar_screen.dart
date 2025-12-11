import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final api = ApiService();

  bool isEditing = false;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool isEditingTodo = false;

  final todoCtrl = TextEditingController();
  final storyInputCtrl = TextEditingController();

  Box get diaryBox => Hive.box("diary");

  List<String> stories = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadDiary();
    _loadMonthlyData();
  }

  // ---------------------------
  // LOAD
  // ---------------------------
  void _loadDiary() async {
    final day = _selectedDay!;   // null 아님 보증
    final key = DateFormat("yyyy-MM-dd").format(day);

    // 1) 로컬 먼저 로딩 (빠른 표시)
    final diary = diaryBox.get(key, defaultValue: {});
    todoCtrl.text = diary["todo"] ?? "";

    final diaryTextLocal = diary["stories"] ?? "";
    stories = diaryTextLocal
        .toString()
        .split("\n")
        .where((e) => e.trim().isNotEmpty)
        .toList();

    setState(() {});   // 로컬 내용 먼저 보여주기

    // 2) 서버에서 최신 데이터 가져오기
    final uniqueKey = Hive.box('pregnancyBox').get('uniqueKey')
        ?? Hive.box('pregnancyBox').get('unique_key');

    final serverData = await api.loadCalendarData(
      uniqueKey: uniqueKey,
      writeDate: key,
    );

    // 서버에서 넘어온 값 정리
    final serverTodo = (serverData["todo"] as String?) ?? "";
    final serverStories =
        (serverData["stories"] as List?)?.cast<String>() ?? [];

    // ❗ 서버에 실제 데이터가 있을 때만 로컬을 덮어쓴다
    if (serverTodo.isNotEmpty || serverStories.isNotEmpty) {
      todoCtrl.text = serverTodo;
      stories = serverStories;

      diaryBox.put(key, {
        "todo": todoCtrl.text,
        "stories": stories.join("\n"),
      });

      setState(() {});
    }
  }

  void _loadMonthlyData() async {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;

    final uniqueKey = Hive.box('pregnancyBox').get('uniqueKey')
        ?? Hive.box('pregnancyBox').get('unique_key');

    final monthly = await api.loadMonthlyCalendar(
      uniqueKey: uniqueKey,
      year: year,
      month: month,
    );

    Map todoMap = monthly["todo"] ?? {};
    Map storyMap = monthly["stories"] ?? {};

    // Hive에 저장
    todoMap.forEach((date, todo) {
      diaryBox.put(date, {
        "todo": todo,
        "stories": (storyMap[date] ?? []).join("\n"),
      });
    });

    // 🚀 이 부분이 **초 핵심**
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    });
  }




  // SAVE
  void _saveDiary() async {
    final day = _selectedDay!;
    final key = DateFormat("yyyy-MM-dd").format(day);

    diaryBox.put(key, {
      "todo": todoCtrl.text,
      "stories": stories.join("\n"),
    });


    final uniqueKey = Hive.box('pregnancyBox').get('uniqueKey')
        ?? Hive.box('pregnancyBox').get('unique_key');

    // 2) 서버 저장
    await api.saveCalendarData(

      uniqueKey: uniqueKey,
      writeDate: key,
      todo: todoCtrl.text,
      stories: stories,
    );

    setState(() {
      isEditingTodo = false;
    });
  }

  // ---------------------------
  // 날짜 아래 라벨용 todo 요약
  // ---------------------------
  String getTodoLabel(DateTime day) {
    String key = DateFormat("yyyy-MM-dd").format(day);
    final diary = diaryBox.get(key);
    String todo = diary?["todo"] ?? "";

    if (todo.isEmpty) return "";
    if (todo.length <= 4) return todo;
    return todo.substring(0, 4);
  }

  // ---------------------------
  // Day Item UI
  // ---------------------------
  Widget _buildDayItem(DateTime day) {
    bool isToday = DateUtils.isSameDay(day, DateTime.now());
    bool isSelected = DateUtils.isSameDay(day, _selectedDay);

    String todoLabel = getTodoLabel(day);

    Color bg = Colors.transparent;
    Color textColor = Colors.black;

    if (isToday) {
      bg = Colors.red.shade300;
      textColor = Colors.white;
    }

    if (isSelected && !isToday) {
      bg = Colors.pink.shade400;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = day;
          _loadDiary();
        });
      },
      child: SizedBox(
        width: 46,
        height: 60,
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bg,
                shape: BoxShape.circle,
              ),
              child: Text("${day.day}", style: TextStyle(color: textColor)),
            ),

            // --- todo 라벨 표시 ---
            if (todoLabel.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  todoLabel,
                  style: const TextStyle(fontSize: 10),
                ),
              )
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // 요일 헤더
  // ---------------------------
  Widget _buildWeekHeader() {
    const days = ["일", "월", "화", "수", "목", "금", "토"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((d) => Text(d,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))
          .toList(),
    );
  }

  // ---------------------------
  // 캘린더 전체
  // ---------------------------
  Widget _buildCalendar() {
    DateTime firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    int firstWeekday = firstDay.weekday % 7;
    int daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;

    List<Widget> rows = [];
    List<Widget> row = [];

    for (int i = 0; i < firstWeekday; i++) {
      row.add(SizedBox(width: 46, height: 60));
    }

    for (int d = 1; d <= daysInMonth; d++) {
      row.add(_buildDayItem(DateTime(_focusedDay.year, _focusedDay.month, d)));

      if (row.length == 7) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row,
        ));
        row = [];
      }
    }

    while (row.length < 7) {
      row.add(SizedBox(width: 46, height: 60));
    }
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: row,
    ));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(top: 10, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: [_buildWeekHeader(), const SizedBox(height: 12), ...rows]),
    );
  }

  // ---------------------------
  // 화면 전체 UI
  // ---------------------------
  @override
  Widget build(BuildContext context) {
    final safeDay = _selectedDay ?? DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xfffaefef),
      appBar: AppBar(
        backgroundColor: const Color(0xfffaefef),
        elevation: 0,
        centerTitle: true,  // 🔥 중앙 정렬 활성화
        automaticallyImplyLeading: false, // 기본 leading 처리하지 않게
        leadingWidth: 56,  // 왼쪽 공간 확보

        // 🔙 뒤로가기 버튼 직접 구성
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),

        // 🔥 title: 중앙에 오도록 구성
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                });
                _loadMonthlyData();
              },
              child: const Icon(Icons.chevron_left),
            ),
            const SizedBox(width: 8),
            Text(
              "${_focusedDay.year}년 ${_focusedDay.month}월",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                });
                _loadMonthlyData();  // ★ 추가
              },
              child: const Icon(Icons.chevron_right),
            ),

          ],
        ),

        // 🔥 오른쪽에도 동일한 폭 확보 (leadingWidth 만큼)
        actions: const [
          SizedBox(width: 56),
        ],
      ),


      body: Column(
        children: [
          _buildCalendar(),

          const SizedBox(height: 12),

          // ⭐ 날짜 가운데 정렬
          Center(
            child: Text(
              DateFormat("yyyy년 MM월 dd일 E요일", "ko_KR").format(safeDay),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  // -------------------------
                  // 오늘 해야 할 일
                  // -------------------------
                  _buildTodoCard(),

                  const SizedBox(height: 18),

                  // -------------------------
                  // 오늘의 이야기 — 여러개
                  // -------------------------
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 20),
                      const SizedBox(width: 6),
                      const Text("오늘의 이야기",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),

                      // ✏ 수정 버튼
                      if (!isEditing)
                        GestureDetector(
                          onTap: () => setState(() => isEditing = true),
                          child: const Icon(Icons.edit, size: 18),
                        ),

                      // ✔ 저장 버튼
                      if (isEditing)
                        GestureDetector(
                          onTap: () {
                            _saveDiary();
                            setState(() => isEditing = false);
                          },
                          child: const Icon(Icons.check, size: 20, color: Colors.green),
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ...List.generate(stories.length, (index) {
                    return _buildStoryItem(index);
                  }),

                  // 이야기 추가 버튼
                  TextButton.icon(
                    onPressed: () {
                      storyInputCtrl.clear();

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("새 이야기 추가"),
                          content: TextField(
                            controller: storyInputCtrl,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "이야기를 입력해주세요",
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("취소")),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    stories.add(storyInputCtrl.text.trim());
                                  });

                                  _saveDiary();
                                  Navigator.pop(context);
                                },
                                child: const Text("추가")),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("이야기 추가하기"),
                  ),

                  const SizedBox(height: 20),

                  if (isEditingTodo)
                    ElevatedButton(
                      onPressed: _saveDiary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("저장하기"),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // Todo card
  // ---------------------------
  Widget _buildTodoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const Icon(Icons.check_box, size: 20),
            const SizedBox(width: 6),
            const Text("오늘 해야 할 일",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            if (!isEditingTodo)
              GestureDetector(
                onTap: () => setState(() => isEditingTodo = true),
                child: const Icon(Icons.edit, size: 18),
              )
          ],
        ),
        const SizedBox(height: 10),
        isEditingTodo
            ? TextField(
          controller: todoCtrl,
          maxLines: 2,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        )
            : Text(
          todoCtrl.text.isEmpty ? "기록 없음" : todoCtrl.text,
          style: TextStyle(color: Colors.grey.shade700),
        )
      ]),
    );
  }

  // ---------------------------
  // Story item with delete button
  // ---------------------------
  Widget _buildStoryItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.chat, size: 20, color: Colors.pink),
          const SizedBox(width: 10),

          // -----------------------
          // READ MODE
          // -----------------------
          if (!isEditing)
            Expanded(
              child: Text(
                stories[index],
                style: const TextStyle(fontSize: 14),
              ),
            ),

          // -----------------------
          // EDIT MODE → TextField
          // -----------------------
          if (isEditing)
            Expanded(
              child: TextField(
                controller: TextEditingController(text: stories[index])
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: stories[index].length),
                  ),
                maxLines: 3,
                onChanged: (v) {
                  stories[index] = v;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          const SizedBox(width: 10),

          // -----------------------
          // 삭제 버튼
          // -----------------------
          GestureDetector(
            onTap: () {
              setState(() {
                stories.removeAt(index);
              });
              _saveDiary();
            },
            child: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }

}
