import 'package:flutter/material.dart';

class TutorialPage3 extends StatelessWidget {
  const TutorialPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,   // ★ 튜토리얼2와 동일
        children: [

          const Text(
            "내 삶에 더욱 딱 맞게",
            style: TextStyle(
              fontSize: 18,         // ★ 튜토리얼2와 동일한 크기(18)
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            "수정하고 싶은 부분을 터치하면\n"
                "나만을 위한 환경을 더욱 정교하게 설정할 수 있어요",
            style: TextStyle(
              fontSize: 13,         // ★ 튜토리얼2와 동일
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Image.asset(
            "assets/images/smart_routine_detail.png",
            height: 420,           // ★ 튜토리얼2와 동일한 높이
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
