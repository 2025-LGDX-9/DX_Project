import 'package:flutter/material.dart';

class SmartRoutineAircon extends StatelessWidget {
  const SmartRoutineAircon({super.key});

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

            /// 🔵 클릭 가능한 시작 조건 카드
            _ClickableCard(
              onTap: () {
                print("에어컨 시작 조건 클릭됨");
              },
              child: _ConditionCard(
                icon: Icons.thermostat,
                title: "실내 온도",
                subtitle: "24~26°C를 벗어나면",
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

            /// 🔵 클릭 가능한 동작 카드
            _ClickableCard(
              onTap: () {
                print("에어컨 동작 카드 클릭됨");
              },
              child: _ActionCard(
                imagePath: "assets/images/aircon.png",
                title: "에어컨",
                subtitle: "온도 조절 : 24~26°C 유지",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🔥 공통 클릭 Wrapper — Material + InkWell + Ink
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
/// 🔵 시작 조건 카드
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
                subtitle,
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
/// 🔵 에어컨 동작 카드
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
                subtitle,
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
