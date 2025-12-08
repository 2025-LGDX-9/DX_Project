import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  String inviteCode = "";

  @override
  void initState() {
    super.initState();
    _loadInviteCode();
  }

  Future<void> _loadInviteCode() async {
    final box = Hive.box('pregnancyBox');
    setState(() {
      inviteCode = box.get('unique_key', defaultValue: "------");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF0F0), // 🔥 핑크톤 배경

      appBar: AppBar(
        backgroundColor: const Color(0xffFAF0F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "초대 코드",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            // ===============================
            // 🔥 초대 코드 박스 (화면 맨 위)
            // ===============================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  inviteCode.isNotEmpty
                      ? inviteCode.split("").join("  ")
                      : "------",
                  style: const TextStyle(
                    fontSize: 28,   // 🔥 글자 크기 살짝 줄임
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "가족에게 초대 코드를 공유해주세요.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff7A7A7A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
