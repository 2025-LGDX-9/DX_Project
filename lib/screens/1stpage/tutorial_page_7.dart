import 'package:flutter/material.dart';

class TutorialPage7 extends StatelessWidget {
  const TutorialPage7({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // -------------------------------
          // 🔵 상단 제목
          // -------------------------------
          const Text(
            "스케줄 관리부터 가족 일기까지",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // -------------------------------
          // 🔵 설명 텍스트(두줄)
          // -------------------------------
          const Text(
            "메인화면 캘린더 아이콘을 클릭하면.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // -------------------------------
          // 🔵 중앙 이미지
          // -------------------------------
          Image.asset(
            "assets/images/calendar_button.png",
            height: 420,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
