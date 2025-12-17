import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  // 세부 타입
  final List<String> detailTypes = ["~시", "일출", "일몰"];
  int selectedDetailIndex = 0;

  // 시간 선택 (휠)
  int selectedHour = 10;
  int selectedMinute = 0;

  // 요일 반복 선택
  final List<String> days = ["일", "월", "화", "수", "목", "금", "토"];
  List<bool> selectedDays = [false, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _loadSavedTimer();
  }

  /// --------------------------------------------------------
  /// 🔥 Hive에 저장된 Timer 설정값 불러오기
  /// --------------------------------------------------------
  void _loadSavedTimer() {
    final box = Hive.box("routine_settings");

    // 세부 타입
    String? detail = box.get("timer_detail_type");
    if (detail != null) {
      selectedDetailIndex = detailTypes.indexOf(detail);
      if (selectedDetailIndex == -1) selectedDetailIndex = 0;
    }

    // 시간
    selectedHour = box.get("timer_hour", defaultValue: 10);
    selectedMinute = box.get("timer_minute", defaultValue: 0);

    // 요일 배열
    List? daysSaved = box.get("timer_days");
    if (daysSaved != null && daysSaved.length == 7) {
      selectedDays = List<bool>.from(daysSaved);
    }

    setState(() {});
  }

  /// --------------------------------------------------------
  /// 🔥 Hive에 설정 저장
  /// --------------------------------------------------------
  Future<void> _saveTimerSettings() async {
    final box = Hive.box("routine_settings");

    await box.put("timer_detail_type", detailTypes[selectedDetailIndex]);
    await box.put("timer_hour", selectedHour);
    await box.put("timer_minute", selectedMinute);
    await box.put("timer_days", selectedDays);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECEEF1),
      appBar: AppBar(
        backgroundColor: const Color(0xffECEEF1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "정해진 시간",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),
            const Text("세부 타입",
                style: TextStyle(fontSize: 15, color: Colors.black54)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: List.generate(detailTypes.length, (index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => selectedDetailIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(detailTypes[index],
                                  style: const TextStyle(fontSize: 17)),
                              Icon(
                                Icons.check,
                                color: selectedDetailIndex == index
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index != detailTypes.length - 1)
                        Divider(color: Colors.grey.shade300, height: 1),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 26),
            const Text("시작 시간",
                style: TextStyle(fontSize: 15, color: Colors.black54)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// ----------------- 시간 휠 -----------------
                  SizedBox(
                    height: 150,
                    width: 80,
                    child: CupertinoPicker(
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedHour),
                      itemExtent: 40,
                      onSelectedItemChanged: (idx) =>
                          setState(() => selectedHour = idx),
                      children: List.generate(
                        24,
                            (i) => Center(
                          child: Text(
                            i.toString().padLeft(2, "0"),
                            style: TextStyle(
                              fontSize: selectedHour == i ? 28 : 20,
                              fontWeight: FontWeight.w600,
                              color: selectedHour == i
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  /// ----------------- 분 휠 -----------------
                  SizedBox(
                    height: 150,
                    width: 80,
                    child: CupertinoPicker(
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedMinute),
                      itemExtent: 40,
                      onSelectedItemChanged: (idx) =>
                          setState(() => selectedMinute = idx),
                      children: List.generate(
                        60,
                            (i) => Center(
                          child: Text(
                            i.toString().padLeft(2, "0"),
                            style: TextStyle(
                              fontSize: selectedMinute == i ? 28 : 20,
                              fontWeight: FontWeight.w600,
                              color: selectedMinute == i
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),
            const Text("반복 설정",
                style: TextStyle(fontSize: 15, color: Colors.black54)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Wrap(
                spacing: 12,
                children: List.generate(days.length, (index) {
                  final bool selected = selectedDays[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedDays[index] = !selected);
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xff5667FF) : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: selected
                                ? const Color(0xff5667FF)
                                : Colors.grey.shade400),
                      ),
                      child: Text(
                        days[index],
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.only(right: 6),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          color: Color(0xff4667FF),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5667FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      /// 🔥 저장 버튼 → Hive 저장
                      onPressed: _saveTimerSettings,

                      child: const Text(
                        "저장",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
