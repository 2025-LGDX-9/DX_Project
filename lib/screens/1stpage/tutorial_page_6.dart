import 'package:flutter/material.dart';

class TutorialPage6 extends StatelessWidget {
  const TutorialPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "스케줄 관리부터 가족 일기까지",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "스케줄만 체크하는 걸 넘어,\n가족 모두가 함께 채워가는\n공유 일기도 한 곳에서 볼 수 있어요.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          /// 스마트폰 이미지
          Image.asset(
            "assets/images/home_calendar.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
