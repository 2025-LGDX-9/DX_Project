import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class _WeekdayText extends StatelessWidget {
  final String text;
  const _WeekdayText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  InputDecoration softInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink.shade100),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink.shade300, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  late Box diaryBox;

  DateTime selectedDate = DateTime.now();

  TextEditingController weightCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();

  int? selectedMood;

  bool isEditing = false; // 🔥 읽기모드 / 편집모드 전환

  @override
  void initState() {
    super.initState();
    diaryBox = Hive.box('diary');
    _loadSelectedDate();
  }

  String dateKey(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  void _loadSelectedDate() {
    final key = dateKey(selectedDate);
    final entry = diaryBox.get(key);

    if (entry != null) {
      weightCtrl.text = entry["weight"]?.toString() ?? "";
      noteCtrl.text = entry["note"] ?? "";
      selectedMood = entry["mood"];
    } else {
      weightCtrl.text = "";
      noteCtrl.text = "";
      selectedMood = null;
    }

    setState(() {});
  }

  void _save() {
    final key = dateKey(selectedDate);

    diaryBox.put(key, {
      "weight": double.tryParse(weightCtrl.text) ?? 0,
      "note": noteCtrl.text,
      "mood": selectedMood,
    });

    setState(() => isEditing = false);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("저장되었습니다.")));
  }

  @override
  Widget build(BuildContext context) {
    final now = selectedDate;
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final firstWeekday = DateTime(now.year, now.month, 1).weekday % 7;
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xffF8EDEE),

      // ---------------------
      // 월 이동 가능한 AppBar
      // ---------------------
      appBar: AppBar(
        backgroundColor: const Color(0xffF8EDEE),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  selectedDate =
                      DateTime(selectedDate.year, selectedDate.month - 1, 1);
                });
                _loadSelectedDate();
              },
            ),
            Text(
              "${now.year}년 ${now.month}월",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  selectedDate =
                      DateTime(selectedDate.year, selectedDate.month + 1, 1);
                });
                _loadSelectedDate();
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
          )
        ],
      ),

      // ---------------------
      // BODY
      // ---------------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // -------------------------
            // 🔥 요일 헤더
            // -------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _WeekdayText("일"),
                  _WeekdayText("월"),
                  _WeekdayText("화"),
                  _WeekdayText("수"),
                  _WeekdayText("목"),
                  _WeekdayText("금"),
                  _WeekdayText("토"),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // -------------------------
            // 🔥 캘린더 GridView
            // -------------------------
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),

              itemCount: firstWeekday + daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.85,
              ),

              itemBuilder: (context, index) {
                if (index < firstWeekday) return Container();

                final day = index - firstWeekday + 1;
                final date = DateTime(now.year, now.month, day);
                final key = dateKey(date);

                final data = diaryBox.get(key);
                final weightLabel = (data != null && data["weight"] != null)
                    ? "${data["weight"]}kg"
                    : "";
                final moodList = ["😄", "😊", "😐", "😡", "😢"];
                final mood = data != null && data["mood"] != null
                    ? moodList[data["mood"]]
                    : null;

                final isSelected =
                    selectedDate.year == date.year &&
                        selectedDate.month == date.month &&
                        selectedDate.day == date.day;

                final isToday =
                    today.year == date.year &&
                        today.month == date.month &&
                        today.day == date.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                    _loadSelectedDate();
                  },

                  // -------------------------
                  // 날짜 셀
                  // -------------------------
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,

                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? Colors.redAccent
                              : isToday
                              ? Colors.redAccent.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        child: Text(
                          "$day",
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),

                      // -------------------------
                      // 몸무게 표시
                      // -------------------------
                      if (weightLabel.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            weightLabel,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            _buildContentSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }


  // -------------------------------------------------------------------
  // 읽기모드 & 편집모드 분리 렌더링
  // -------------------------------------------------------------------
  Widget _buildContentSection() {
    return isEditing ? _buildEditorUI() : _buildReadUI();
  }

  // -------------------------------------------------------------------
  // 읽기 UI (네가 올린 첫 번째 이미지)
  // -------------------------------------------------------------------
  Widget _buildReadUI() {
    final weight = weightCtrl.text.isNotEmpty ? weightCtrl.text : "-";
    final note = noteCtrl.text.isNotEmpty ? noteCtrl.text : "아직 기록이 없어요 :)";
    final moodEmoji = ["😄", "😊", "😐", "😡", "😢"];
    final moodIcon = selectedMood != null ? moodEmoji[selectedMood!] : "🙂";

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          Text("$weight kg",
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),
          Center(
            child: Text(
              moodIcon,
              style: const TextStyle(fontSize: 50),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            note,
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),
        ],
      ),
    );
  }


  // -------------------------------------------------------------------
  // 편집 UI (두 번째 이미지 스타일)
  // -------------------------------------------------------------------
  Widget _buildEditorUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // ------------------------------
          // 체중 입력
          // ------------------------------
          const Text(
            "오늘 체중을 기록해볼까요?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff5b4a4a),
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              SizedBox(
                width: 110,
                child: TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: softInputDecoration("예: 52"),
                ),
              ),
              const SizedBox(width: 10),
              const Text("kg",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),

          const SizedBox(height: 28),

          // ------------------------------
          // 기분 선택
          // ------------------------------
          const Text(
            "오늘은 어떤 기분이셨나요?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff5b4a4a),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (i) {
              bool selected = selectedMood == i;
              final emojiList = ["😄", "😊", "😐", "😡", "😢"];

              return GestureDetector(
                onTap: () => setState(() => selectedMood = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selected ? Colors.pink.shade100 : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: selected
                        ? [
                      BoxShadow(
                        color: Colors.pink.shade200.withOpacity(0.5),
                        blurRadius: 10,
                      )
                    ]
                        : [],
                  ),
                  child: Text(
                    emojiList[i],
                    style: TextStyle(
                      fontSize: selected ? 40 : 34,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 28),

          // ------------------------------
          // 하루 기록
          // ------------------------------
          const Text(
            "오늘 하루는 어떠셨나요?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff5b4a4a),
            ),
          ),
          const SizedBox(height: 10),

          TextField(
            controller: noteCtrl,
            maxLines: 6,
            style: const TextStyle(fontSize: 16, height: 1.5),
            decoration: softInputDecoration("오늘 있었던 일을 적어보세요 :)"),
          ),

          const SizedBox(height: 32),

          // ------------------------------
          // 저장 버튼 (말랑버전)
          // ------------------------------
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 2,
                shadowColor: Colors.pink.shade200,
              ),
              child: const Text(
                "저장하기 💗",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

}
