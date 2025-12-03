import 'package:flutter/material.dart';

class SmartRoutineAirCleaner extends StatelessWidget {
  const SmartRoutineAirCleaner({super.key});

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
                child: const _TimeConditionCard(),
                onTap: () {
                  print("정해진 시간 클릭됨");
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
                onTap: () {
                  print("전기레인지 클릭됨");
                },
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
                child: const _AirCleanerActionCard(),
                onTap: () {
                  print("공기청정기 오토모드 클릭됨");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------
/// 🔥 카드 전체를 클릭 가능하게 만드는 공통 Wrapper
/// --------------------------------------------------------------
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

/// --------------------------------------------------------------
/// 🔵 시작 조건 1 — 정해진 시간
/// --------------------------------------------------------------
class _TimeConditionCard extends StatelessWidget {
  const _TimeConditionCard();

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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "매일, 24시간",
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

/// --------------------------------------------------------------
/// 🔵 시작 조건 2 — 전기레인지 작동
/// --------------------------------------------------------------
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

/// --------------------------------------------------------------
/// 🔵 행동 카드 — 공기청정기 오토모드
/// --------------------------------------------------------------
class _AirCleanerActionCard extends StatelessWidget {
  const _AirCleanerActionCard();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                "공기청정기",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "오토모드",
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
