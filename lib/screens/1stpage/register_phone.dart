import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  String inviteCode = "";
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInviteCode();
  }

  Future<void> _loadInviteCode() async {
    final box = Hive.box('pregnancyBox');

    setState(() {
      inviteCode = box.get('unique_key', defaultValue: "------");
      // 저장 안돼있으면 빈값 대신 ------ 표시
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EBF1),

      appBar: AppBar(
        backgroundColor: const Color(0xffE8EBF1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "계정/전화번호로 초대",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "초대 코드",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B6B6B),
              ),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Text(
                  inviteCode.isNotEmpty
                      ? inviteCode.split("").join("  ")
                      : "------",
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            const Text(
              "LG ThinQ 계정 또는 전화번호",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  hintText: "계정 또는 전화번호를 입력해주세요",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xffB0A9A9),
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "LG ThinQ 계정은 ‘홈 설정 > 홈 멤버’에서 확인할 수 있어요.",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff9D9D9D),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        color: const Color(0xffE8EBF1),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xffE1DADA),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "초대",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff4D4D4D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
