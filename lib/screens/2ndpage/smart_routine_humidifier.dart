import 'package:flutter/material.dart';

class SmartRoutineHumidifier extends StatelessWidget {
  const SmartRoutineHumidifier({super.key});

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
              /// 🔵 제목
              const Text(
                "언제 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 🔵 시작 조건 카드 (클릭 가능)
              _ClickableCard(
                onTap: () {
                  print("가습기 시작 조건 클릭됨");
                },
                child: const _ConditionCard(),
              ),

              const SizedBox(height: 40),

              /// 🔵 제목
              const Text(
                "무엇을 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 🔵 동작 카드 (클릭 가능)
              _ClickableCard(
                onTap: () {
                  print("가습기 동작 카드 클릭됨");
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

/// --------------------------------------------------------------
/// 🔥 공통 클릭 Wrapper: Material + Ink + InkWell
/// --------------------------------------------------------------
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

////////////////////////////////////////
/// 🔵 시작 조건 카드
////////////////////////////////////////
class _ConditionCard extends StatelessWidget {
  const _ConditionCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          /// 아이콘
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

          /// 텍스트
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "실내 습도",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4),
              Text(
                "40~60%를 벗어나면",
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

////////////////////////////////////////
/// 🔵 가습기 행동 카드
////////////////////////////////////////
class _ActionCard extends StatelessWidget {
  const _ActionCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          /// 가습기 이미지
          Image.asset(
            "assets/images/humidifier.png",
            width: 48,
            height: 48,
          ),

          const SizedBox(width: 16),

          /// 텍스트
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "가습기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4),
              Text(
                "습도 조절 : 40~60% 유지",
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
