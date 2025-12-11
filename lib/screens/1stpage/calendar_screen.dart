import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

const sectionTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class _CalendarScreenState extends State<CalendarScreen> {
  final api = ApiService();

  bool isEditingStory = false; // 🔥 이야기 편집 전용 변수
  bool isEditingTodo = false; // 🔥 오늘의 해야할 일 편집 전용 변수

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
    final day = _selectedDay!;
    final key = DateFormat("yyyy-MM-dd").format(day);

    final diary = diaryBox.get(key, defaultValue: {});
    todoCtrl.text = diary["todo"] ?? "";

    final diaryTextLocal = diary["stories"] ?? "";
    stories = diaryTextLocal
        .toString()
        .split("\n")
        .where((e) => e.trim().isNotEmpty)
        .toList();

    setState(() {});

    final uniqueKey =
        Hive.box('pregnancyBox').get('uniqueKey') ??
            Hive.box('pregnancyBox').get('unique_key');

    final serverData = await api.loadCalendarData(
      uniqueKey: uniqueKey,
      writeDate: key,
    );

    final serverTodo = (serverData["todo"] as String?) ?? "";
    final serverStories =
        (serverData["stories"] as List?)?.cast<String>() ?? [];

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
    final uniqueKey =
        Hive.box('pregnancyBox').get('uniqueKey') ??
            Hive.box('pregnancyBox').get('unique_key');

    final monthly = await api.loadMonthlyCalendar(
      uniqueKey: uniqueKey,
      year: now.year,
      month: now.month,
    );

    Map todoMap = monthly["todo"] ?? {};
    Map storyMap = monthly["stories"] ?? {};

    todoMap.forEach((date, todo) {
      diaryBox.put(date, {
        "todo": todo,
        "stories": (storyMap[date] ?? []).join("\n"),
      });
    });

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

    final uniqueKey =
        Hive.box('pregnancyBox').get('uniqueKey') ??
            Hive.box('pregnancyBox').get('unique_key');

    await api.saveCalendarData(
      uniqueKey: uniqueKey,
      writeDate: key,
      todo: todoCtrl.text,
      stories: stories,
    );

    setState(() {
      isEditingTodo = false;
      isEditingStory = false;
    });
  }

  // ---------------------------
  // UI - 날짜 아래 라벨용 todo 요약
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
          isEditingStory = false;
          isEditingTodo = false;
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
              decoration:
              BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Text("${day.day}",
                  style: TextStyle(color: textColor)),
            ),
            if (todoLabel.isNotEmpty)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(todoLabel,
                    style: const TextStyle(fontSize: 10)),
              )
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // Calendar UI
  // ---------------------------
  Widget _buildCalendar() {
    DateTime firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    int firstWeekday = firstDay.weekday % 7;
    int daysInMonth =
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;

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
      child:
      Column(children: [_buildWeekHeader(), const SizedBox(height: 12), ...rows]),
    );
  }

  Widget _buildWeekHeader() {
    const days = ["일", "월", "화", "수", "목", "금", "토"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((d) => Text(d,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14)))
          .toList(),
    );
  }

  // ---------------------------
  // BUILD UI
  // ---------------------------
  @override
  Widget build(BuildContext context) {
    final safeDay = _selectedDay ?? DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xfffaefef),
      appBar: AppBar(
        backgroundColor: const Color(0xfffaefef),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedDay = DateTime(
                        _focusedDay.year, _focusedDay.month - 1, 1);
                  });
                  _loadMonthlyData();
                },
                child: const Icon(Icons.chevron_left)),
            const SizedBox(width: 8),
            Text("${_focusedDay.year}년 ${_focusedDay.month}월",
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedDay = DateTime(
                        _focusedDay.year, _focusedDay.month + 1, 1);
                  });
                  _loadMonthlyData();
                },
                child: const Icon(Icons.chevron_right)),
          ],
        ),
        actions: const [SizedBox(width: 50)],
      ),

      body: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 12),

          // 날짜 표시 + 편집버튼
          _buildDateHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  _buildTodoCard(),
                  const SizedBox(height: 20),
                  _buildStoryHeader(),
                  const SizedBox(height: 10),
                  ...List.generate(stories.length, _buildStoryItem),
                  _buildAddStoryButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // 날짜 아래 줄 UI (날짜 + 편집/저장)
  // ---------------------------
  Widget _buildDateHeader() {
    const double sideWidth = 80;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SizedBox(
              width: sideWidth,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay =
                          _selectedDay!.subtract(const Duration(days: 1));
                      _loadDiary();
                    });
                  },
                  child: const Icon(Icons.chevron_left, size: 24)),
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat("yyyy년 MM월 dd일 E요일", "ko_KR")
                      .format(_selectedDay!),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: sideWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isEditingStory || isEditingTodo)
                    GestureDetector(
                      onTap: () => _saveDiary(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFD7E8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "저장",
                          style: TextStyle(
                              color: Color(0xffC8558A),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  if (!isEditingStory && !isEditingTodo)
                    GestureDetector(
                      onTap: () => setState(() {
                        isEditingStory = true;
                        isEditingTodo = true;
                      }),
                      child: const Icon(Icons.edit, size: 20),
                    ),

                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay =
                            _selectedDay!.add(const Duration(days: 1));
                        _loadDiary();
                      });
                    },
                    child: const Icon(Icons.chevron_right, size: 24),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // Todo UI
  // ---------------------------
  Widget _buildTodoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("오늘 해야 할 일", style: sectionTitleStyle),
              const Spacer(),

              // 삭제 버튼
              if (isEditingTodo)
                GestureDetector(
                    onTap: () => setState(() => todoCtrl.clear()),
                    child: const Icon(Icons.delete, color: Colors.red)),

            ],
          ),

          const SizedBox(height: 10),

          // 🔥 핵심: 편집 전에는 Text, 편집 중에는 TextField
          if (!isEditingTodo)
            Text(
              todoCtrl.text.isEmpty ? "기록 없음" : todoCtrl.text,
              style: TextStyle(
                color: Colors.black87,   // ← 진하게 변경!
                fontSize: 14,),
            )
          else
            TextField(
              controller: todoCtrl,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
        ],
      ),
    );
  }


  // ---------------------------
  // Story header
  // ---------------------------
  Widget _buildStoryHeader() {
    return Row(
      children: [
        const Icon(Icons.chat_bubble_outline),
        const SizedBox(width: 6),
        const Text("오늘의 이야기", style: sectionTitleStyle),
        const Spacer(),
      ],
    );

  }

  // ---------------------------
  // Story Item
  // ---------------------------
  Widget _buildStoryItem(int index) {
    final text = stories[index].trim();

    // 🔥 읽기 모드일 때만 내용 없으면 숨김
    if (!isEditingStory && text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: (!isEditingStory)
            // 📌 읽기 모드 → 흰 박스에 텍스트 표시
                ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                stories[index],
                style: const TextStyle(fontSize: 14),
              ),
            )
            // 📌 편집 모드 → 무조건 TextField 표시 (내용 없어도!)
                : TextField(
              controller: TextEditingController(text: stories[index])
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: stories[index].length),
                ),
              minLines: 2,       // 🔥 최소 2줄로 지정
              maxLines: 3,       // 🔥 입력이 많아도 3줄까지만 늘어남
              onChanged: (v) => stories[index] = v,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,   // 🔥 padding 줄여서 박스 높이 감소
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          ),

          const SizedBox(width: 8),

          // 삭제 버튼 (편집모드에서만)
          if (isEditingStory)
            GestureDetector(
              onTap: () {
                setState(() => stories.removeAt(index));
              },
              child: const Icon(Icons.delete, color: Colors.red, size: 22),
            ),
        ],
      ),
    );
  }





  // ---------------------------
  // 이야기 추가 버튼
  // ---------------------------
  Widget _buildAddStoryButton() {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          // stories에 빈 문자열 추가 → 즉시 TextField가 생김
          stories.add("");
          isEditingStory = true;  // 자동으로 편집모드 진입
        });
      },
      icon: const Icon(Icons.add),
      label: const Text("이야기 추가하기"),
    );
  }

}
