import 'package:flutter/material.dart';

class TutorialPage2 extends StatelessWidget {
  const TutorialPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "임산부를 위한 스마트홈",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "임산부가 쾌적하다고 느끼는\n온도, 습도에 맞춘 가전 제어 루틴",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          Image.asset(
            "assets/images/smart_routine_screen.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
