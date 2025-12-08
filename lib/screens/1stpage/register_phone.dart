import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/1stpage/home_screen.dart';


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

  // ① 초대 버튼 눌렀을 때 실행되는 함수
  Future<void> _onInvitePressed() async {
    String inputCode = _inputController.text.trim();

    if (inputCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("초대 코드를 입력해주세요.")),
      );
      return;
    }

    try {
      final url = Uri.parse("http://192.168.219.43:8001/invite");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"invite_code": inputCode}),
      );

      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("서버 오류가 발생했습니다.")),
        );
        return;
      }

      final data = jsonDecode(response.body);

      if (data["success"] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("유효하지 않은 초대 코드입니다.")),
        );
        return;
      }

      // FastAPI가 반환한 데이터
      String uniqueKey = data["unique_Key"];
      String babyNickname = data["babyNickname"];
      String startDate = data["startDate"];


      // 로컬에도 저장 (남편 정보 동기화)
      final box = Hive.box('pregnancyBox');
      box.put('unique_key', uniqueKey);
      box.put('baby_nickname', babyNickname);
      box.put('start_date', startDate);

      // 성공 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("초대 성공! 임산부 정보를 불러왔어요.")),
      );

      // 다음 화면 이동

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(controller: PregnancyController(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("네트워크 오류: $e")),
      );
    }
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
          "계정으로 초대",
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
              "초대 코드 입력",
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
                  hintText: "초대 코드를 입력해주세요",
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
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4D4D4D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _onInvitePressed,
            child: const Text(
              "초대",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

    );
  }
}
