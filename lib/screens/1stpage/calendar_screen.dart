import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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

    return Scaffold(
      backgroundColor: const Color(0xffF8EDEE),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8EDEE),
        elevation: 0,
        title: Text("${now.year}년 ${now.month}월",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------------
            // 캘린더 UI
            //---------------------------------
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final day = index + 1;
                final date = DateTime(now.year, now.month, day);
                final key = dateKey(date);

                final data = diaryBox.get(key);
                final weightLabel = (data != null && data["weight"] != null)
                    ? "${data["weight"]}kg"
                    : "";

                final isSelected =
                    selectedDate.year == date.year &&
                        selectedDate.month == date.month &&
                        selectedDate.day == date.day;

                return GestureDetector(
                  onTap: () {
                    selectedDate = date;
                    _loadSelectedDate();
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.redAccent : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "$day",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (weightLabel.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            weightLabel,
                            style:
                            const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
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
    final note = noteCtrl.text.isNotEmpty ? noteCtrl.text : "작성된 내용이 없습니다.";

    final moodEmoji = ["😄", "😊", "😐", "😡", "😢"];
    final moodIcon = selectedMood != null ? moodEmoji[selectedMood!] : "🙂";

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일",
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),

          const SizedBox(height: 16),
          Text("$weight kg",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              Text(moodIcon, style: const TextStyle(fontSize: 36)),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            note,
            style: const TextStyle(fontSize: 16, height: 1.4),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text("오늘 체중을 기록해보아요!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          Row(
            children: [
              SizedBox(
                width: 90,
                child: TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text("kg", style: TextStyle(fontSize: 18)),
            ],
          ),

          const SizedBox(height: 24),
          const Text("오늘은 어떤 기분이셨나요?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (i) {
              return GestureDetector(
                onTap: () {
                  setState(() => selectedMood = i);
                },
                child: Opacity(
                  opacity: selectedMood == i ? 1 : 0.3,
                  child: Text(["😄", "😊", "😐", "😡", "😢"][i],
                      style: const TextStyle(fontSize: 38)),
                ),
              );
            }),
          ),

          const SizedBox(height: 24),
          const Text("오늘 하루는 어떠셨나요?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          TextField(
            controller: noteCtrl,
            maxLines: 6,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("저장",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
