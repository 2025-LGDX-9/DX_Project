import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/inner_humidity.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_humidifier_control.dart';

class SmartRoutineHumidifier extends StatefulWidget {
  const SmartRoutineHumidifier({super.key});

  @override
  State<SmartRoutineHumidifier> createState() =>
      _SmartRoutineHumidifierState();
}

class _SmartRoutineHumidifierState extends State<SmartRoutineHumidifier> {
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
          "가습기",
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

              /// 🔵 조건 카드
              _ClickableCard(
                onTap: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InnerHumidity()),
                  );
                  if (changed == true) setState(() {});
                },
                child: const _ConditionCard(),
              ),

              const SizedBox(height: 40),

              const Text(
                "무엇을 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 🔵 행동 카드
              _ClickableCard(
                onTap: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SmartHumidifierControl()),
                  );
                  if (changed == true) setState(() {});
                },
                child: const _ActionCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ================================================================
// 🔵 요약 함수 (Hive 값 읽기)
// ================================================================
//

String getHumidityConditionSummary() {
  final box = Hive.box("routine_settings");

  int value = box.get("humidity_value", defaultValue: 60);
  String cond = box.get("humidity_condition", defaultValue: "이하면");

  return "$value% $cond";
}

String getHumidifierActionSummary() {
  final box = Hive.box("routine_settings");

  bool power = box.get("humid_power", defaultValue: true);
  int level = box.get("humid_level", defaultValue: 1);
  int target = box.get("humid_target", defaultValue: 50);
  bool silent = box.get("humid_silent", defaultValue: false);

  final levels = ["-", "약", "중", "강"];

  return "${power ? '켜기' : '끄기'} · 세기 ${levels[level]} · 목표 $target% · ${silent ? "조용모드" : "일반"}";
}

//
// ================================================================
// 🔵 클릭 카드 공통 Wrapper
// ================================================================
//

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

//
// ================================================================
// 🔵 조건 카드 — 즉시 반영 (Stateless)
// ================================================================
//

class _ConditionCard extends StatelessWidget {
  const _ConditionCard();

  @override
  Widget build(BuildContext context) {
    final summary = getHumidityConditionSummary();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xffe5f3ff),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Color(0xff49a4ff),
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "실내 습도",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
// ================================================================
// 🔵 행동 카드 — 즉시 반영 (Stateless)
// ================================================================
//

class _ActionCard extends StatelessWidget {
  const _ActionCard();

  @override
  Widget build(BuildContext context) {
    final summary = getHumidifierActionSummary();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Image.asset(
            "assets/images/humidifier.png",
            width: 48,
            height: 48,
          ),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "가습기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
