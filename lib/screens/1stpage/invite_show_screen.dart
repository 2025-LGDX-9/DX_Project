import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InviteShowScreen extends StatelessWidget {
  const InviteShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('pregnancyBox');
    final inviteCode = box.get('unique_key', defaultValue: "------");

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "초대 코드",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "가족에게 공유하세요!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                inviteCode.split("").join(" "),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "이 코드를 입력하면 같은 임신 정보와 홈을 공유할 수 있어요.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
