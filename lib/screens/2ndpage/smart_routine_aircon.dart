import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'inner_temper.dart';
import 'smart_aircon_control.dart';

class SmartRoutineAircon extends StatefulWidget {
  const SmartRoutineAircon({super.key});

  @override
  State<SmartRoutineAircon> createState() => _SmartRoutineAirconState();
}

class _SmartRoutineAirconState extends State<SmartRoutineAircon> {
  /// 시작 조건 요약 (InnerTemper)
  String conditionSubtitle = "조건을 설정하세요";

  /// 에어컨 동작 요약 (SmartAirconControl)
  String actionSubtitle = "설정 없음";

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  /// ✅ Hive에서 시작 조건 + 에어컨 동작 설정 모두 불러와서 요약 문구로 만든다
  void _loadSummary() {
    final box = Hive.box("routine_settings");

    // ---------- 시작 조건 (실내 온도) ----------
    int? innerTemp = box.get("innerTempValue");
    String? innerCond = box.get("innerTempCondition");

    if (innerTemp != null && innerCond != null) {
      // 예: "26°C 이상이면" / "24°C 이하면"
      conditionSubtitle = "$innerTemp°C $innerCond";
    } else {
      conditionSubtitle = "조건을 설정하세요";
    }

    // ---------- 에어컨 동작 ----------
    int? temp = box.get("aircon_target_temp");
    String? strength = box.get("aircon_wind_strength");
    String? direction = box.get("aircon_wind_direction");
    String? power = box.get("aircon_power");

    if (temp != null && strength != null && direction != null && power != null) {
      // 예: "24°C · 약 · 집중 · 켜기"
      actionSubtitle = "$temp°C · $strength · $direction · $power";
    } else {
      actionSubtitle = "설정 없음";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F7),

      appBar: AppBar(
        backgroundColor: const Color(0xffF2F4F7),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 4),
            const Text(
              "에어컨",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),
            const Text(
              "언제 할까요?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            /// 🔵 시작 조건 카드 (→ InnerTemper에서 설정한 값 표시)
            _ClickableCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InnerTemper()),
                ).then((_) => _loadSummary());  // 돌아오면 요약 다시 로드
              },
              child: _ConditionCard(
                icon: Icons.thermostat,
                title: "실내 온도",
                subtitle: conditionSubtitle,    // ← 여기
              ),
            ),

            const SizedBox(height: 38),
            const Text(
              "무엇을 할까요?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            /// 🔵 에어컨 동작 카드 (→ SmartAirconControl에서 설정한 값 표시)
            _ClickableCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SmartAirconControl()),
                ).then((_) => _loadSummary());  // 돌아오면 요약 다시 로드
              },
              child: _ActionCard(
                imagePath: "assets/images/aircon.png",
                title: "에어컨",
                subtitle: actionSubtitle,       // ← 여기
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///   공통 클릭 Wrapper — Material + InkWell + Ink
///////////////////////////////////////////////////////////////////////////////

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
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///   시작 조건 카드
///////////////////////////////////////////////////////////////////////////////

class _ConditionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ConditionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent, size: 32),
          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "시작 조건",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff7B8BA0),
                ),
              ),
              const SizedBox(height: 4),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,  // ← Hive 값 요약 표시
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4A90E2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///   에어컨 동작 카드
///////////////////////////////////////////////////////////////////////////////

class _ActionCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const _ActionCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,  // ← "24°C · 약 · 집중 · 켜기" 같은 문구
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4A90E2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
