import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_air_cleaner_control.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/timer.dart';

class SmartRoutineAirCleaner extends StatefulWidget {
  const SmartRoutineAirCleaner({super.key});

  @override
  State<SmartRoutineAirCleaner> createState() =>
      _SmartRoutineAirCleanerState();
}

class _SmartRoutineAirCleanerState extends State<SmartRoutineAirCleaner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f9),

      appBar: AppBar(
        backgroundColor: const Color(0xfff3f5f9),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "공기청정기",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "언제 할까요?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              _ClickableCard(
                child: _TimeConditionCard(),
                onTap: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Timer()),
                  );

                  if (changed == true) setState(() {}); // 즉시 반영
                },
              ),

              const SizedBox(height: 24),
              const Text(
                "그리고",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7b8ba0),
                ),
              ),

              const SizedBox(height: 14),

              _ClickableCard(
                child: const _StoveConditionCard(),
                onTap: () {},
              ),

              const SizedBox(height: 40),

              const Text(
                "무엇을 할까요?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              _ClickableCard(
                child: _AirCleanerActionCard(),
                onTap: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SmartAirCleanerControl()),
                  );

                  if (changed == true) setState(() {}); // 즉시 반영
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// --------------------------------------------------------------
// 🔵 요약 문자열
// --------------------------------------------------------------
//

String getTimerSummary() {
  final box = Hive.box("routine_settings");

  String detail = box.get("timer_detail_type", defaultValue: "~시");
  int hour = box.get("timer_hour", defaultValue: 10);
  int minute = box.get("timer_minute", defaultValue: 0);
  List days = box.get("timer_days",
      defaultValue: [false, false, false, false, false, false, false]);

  final dayLabels = ["일", "월", "화", "수", "목", "금", "토"];
  List<String> selectedDayLabels = [];

  for (int i = 0; i < 7; i++) {
    if (days[i] == true) selectedDayLabels.add(dayLabels[i]);
  }

  String dayString =
  selectedDayLabels.isEmpty ? "반복 없음" : selectedDayLabels.join("·");

  String timeString =
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";

  return "$dayString $timeString $detail";
}

String getAirCleanerSummary() {
  final box = Hive.box("routine_settings");

  String power = box.get("aircleaner_power", defaultValue: "끄기");
  String clean =
  box.get("aircleaner_clean_level", defaultValue: "보통");
  String booster =
  box.get("aircleaner_booster_level", defaultValue: "약");

  return "$power · 청정 $clean · 부스터 $booster";
}

//
// --------------------------------------------------------------
// 🔵 클릭 카드 Wrapper
// --------------------------------------------------------------
//

class _ClickableCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ClickableCard({
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}

//
// --------------------------------------------------------------
// 🔵 정해진 시간 카드 — **즉시 반영형**
// --------------------------------------------------------------
//

class _TimeConditionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String summary = getTimerSummary(); // ← build마다 최신값 읽기

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xffffefe5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.access_time,
              color: Color(0xffff8b3d),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "정해진 시간",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                summary,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff80a4c2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
// --------------------------------------------------------------
// 🔵 전기레인지 카드
// --------------------------------------------------------------
//

class _StoveConditionCard extends StatelessWidget {
  const _StoveConditionCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Image.asset(
            "assets/images/stove.png",
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "전기레인지",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "작동하면",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff80a4c2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
// --------------------------------------------------------------
// 🔵 공기청정기 행동 요약 카드 — **즉시 반영형**
// --------------------------------------------------------------
//

class _AirCleanerActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String summary = getAirCleanerSummary(); // ← build 시마다 최신 Hive 값 읽음

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Image.asset(
            "assets/images/air_cleaner.png",
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "공기청정기",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                summary,  // 최신 데이터 출력
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff80a4c2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
