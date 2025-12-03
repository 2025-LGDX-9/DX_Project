import 'package:flutter/material.dart';

class TutorialPage3 extends StatelessWidget {
  const TutorialPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "내 삶에 더욱 딱 맞게",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "편집 기능을 통해\n나만을 위한 맞춤 환경을 더욱 섬세하게 설정할 수 있어요",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          Image.asset(
            "assets/images/smart_routine_detail.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
