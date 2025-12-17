import 'package:flutter/material.dart';

class TutorialPage4 extends StatelessWidget {
  const TutorialPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "터치 한 번으로",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "여기저기 찾을 필요 없어요\n원하는 카테고리를 찾아 터치하면 끝!",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          Image.asset(
            "assets/images/info_screen.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
