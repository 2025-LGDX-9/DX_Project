import 'package:flutter/material.dart';

class SmartRoutineRobotCleaner extends StatelessWidget {
  const SmartRoutineRobotCleaner({super.key});

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
              /// 제목
              const Text(
                "언제 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 시작 조건 클릭 카드
              _ClickableCard(
                onTap: () {
                  print("정해진 시간 클릭됨");
                },
                child: const _ConditionCard(),
              ),

              const SizedBox(height: 40),

              /// 제목
              const Text(
                "무엇을 할까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),

              /// 로봇청소기 동작 클릭 카드
              _ClickableCard(
                onTap: () {
                  print("로봇청소기 실행 클릭됨");
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
/// 🔥 공통 클릭 가능 Wrapper — Material + Ink + InkWell
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

////////////////////////////////////////////////////
/// 🔵 시작 조건 카드 (정해진 시간)
////////////////////////////////////////////////////
class _ConditionCard extends StatelessWidget {
  const _ConditionCard();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                "정해진 시간",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4),
              Text(
                "매일, 10:00, 17:00",
                style: TextStyle(fontSize: 14, color: Color(0xff80a4c2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////
/// 🔵 로봇청소기 동작 카드
////////////////////////////////////////////////////
class _ActionCard extends StatelessWidget {
  const _ActionCard();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                "로봇청소기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4),
              Text(
                "청소 시작",
                style: TextStyle(fontSize: 14, color: Color(0xff80a4c2)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
