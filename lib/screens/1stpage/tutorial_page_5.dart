import 'package:flutter/material.dart';

class TutorialPage5 extends StatelessWidget {
  const TutorialPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "온 가족 함께",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "멤버 초대 기능을 통해\n온 가족이 손쉽게 공유할 수 있어요",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          Image.asset(
            "assets/images/invite_screen.png",
            height: 420,
          ),
        ],
      ),
    );
  }
}
