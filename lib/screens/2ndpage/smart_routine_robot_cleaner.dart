import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_robot_cleaner_control.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/timer.dart';

class SmartRoutineRobotCleaner extends StatefulWidget {
  const SmartRoutineRobotCleaner({super.key});

  @override
  State<SmartRoutineRobotCleaner> createState() =>
      _SmartRoutineRobotCleanerState();
}

class _SmartRoutineRobotCleanerState extends State<SmartRoutineRobotCleaner> {
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
          "로봇청소기",
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 🔵 Timer 페이지 이동 + 즉시 반영
              _ClickableCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Timer()),
                  ).then((value) {
                    if (value == true) setState(() {});
                  });
                },
                child: _ConditionCard(),
              ),

              const SizedBox(height: 40),

              const Text(
                "무엇을 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 🔵 로봇청소기 제어 페이지 + 즉시 반영
              _ClickableCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SmartRobotCleanerControl()),
                  ).then((value) {
                    if (value == true) setState(() {});
                  });
                },
                child: _ActionCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🔵 Timer 요약 계산 함수
////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////
/// 🔵 로봇청소기 동작 요약 함수
////////////////////////////////////////////////////////////
String getRobotActionSummary() {
  final box = Hive.box("routine_settings");

  String action = box.get("robot_action", defaultValue: "clean");

  return action == "clean" ? "청소 시작" : "충전 시작";
}

////////////////////////////////////////////////////////////
/// 🔵 공통 클릭 카드 Wrapper
////////////////////////////////////////////////////////////
class _ClickableCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ClickableCard({required this.child, required this.onTap});

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

////////////////////////////////////////////////////////////
/// 🔵 Timer 요약 카드 — 즉시 반영됨
////////////////////////////////////////////////////////////
class _ConditionCard extends StatelessWidget {
  const _ConditionCard();

  @override
  Widget build(BuildContext context) {
    final summary = getTimerSummary();

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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                summary,
                style:
                const TextStyle(fontSize: 14, color: Color(0xff80a4c2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🔵 로봇청소기 행동 요약 카드 — 즉시 반영됨
////////////////////////////////////////////////////////////
class _ActionCard extends StatelessWidget {
  const _ActionCard();

  @override
  Widget build(BuildContext context) {
    final summary = getRobotActionSummary();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Image.asset(
            "assets/images/robot_cleaner.png",
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "로봇청소기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                summary,
                style:
                const TextStyle(fontSize: 14, color: Color(0xff80a4c2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
