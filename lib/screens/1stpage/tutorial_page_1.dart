import 'package:flutter/material.dart';

class TutorialPage1 extends StatelessWidget {
  const TutorialPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "내 아이와 가전을 한 눈에",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "내 아이의 성장부터 주차별 꿀팁, 가전 제어까지\n한눈에 확인할 수 있어요",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          /// 스마트폰 이미지
          Image.asset(
            "assets/images/home_screen.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
