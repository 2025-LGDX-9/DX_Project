import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

class JoinGroupScreen extends StatefulWidget {
  final PregnancyController controller;      // ★ 추가

  const JoinGroupScreen({
    super.key,
    required this.controller,               // ★ 추가
  });

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? selectedRelation;

  final List<String> relations = [
    "남편",
    "아내 가족",
    "남편 가족",
    "친구",
    "기타"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EBF1),
      appBar: AppBar(
        title: const Text("그룹 참여하기"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "초대 코드 입력",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _codeController,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: "6자리 초대코드를 입력하세요",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            const Text(
              "당신은 어떤 관계인가요?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            ...relations.map((r) {
              return ListTile(
                title: Text(r),
                leading: Radio<String>(
                  value: r,
                  groupValue: selectedRelation,
                  onChanged: (value) {
                    setState(() {
                      selectedRelation = value;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
        child: ElevatedButton(
          onPressed: () async {
            if (_codeController.text.length != 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("초대코드를 정확히 입력해주세요.")),
              );
              return;
            }

            if (selectedRelation == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("관계를 선택해주세요.")),
              );
              return;
            }

            // FastAPI 호출
            final api = ApiService();
            final result = await api.joinGroup(
              key: _codeController.text,
              relation: selectedRelation!,
            );

            if (result["success"] == true) {

              final box = Hive.box("pregnancyBox");

              // 1) uniqueKey 저장
              box.put("unique_key", _codeController.text.trim());

              // 2) 관계 저장
              box.put("relation", selectedRelation!);
              box.put("memberId", result["memberId"]);
              box.put("memberIndex", result["memberIndex"]);

              Hive.box('onboarding').put('pregnancyMode', true);

              final api = ApiService();
              final info = await api.getPregnancyInfoByKey(_codeController.text.trim());

              if (info != null) {
                widget.controller.saveInfo(
                  nickname: info["babyNickname"],
                  start: DateTime.parse(info["startDate"]),
                  uniqueKey: _codeController.text.trim(),
                );
              }

              final onboardBox = Hive.box('onboarding');
              onboardBox.put('pregnancyMode', true);

              // 3) 성공 메시지
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result["message"])),
              );


              Navigator.pop(context, true);

            } else {
              // 실패 메시지
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result["message"])),
              );
            }

          },

          child: const Text("그룹 참여하기"),
        ),
      ),
    );
  }
}
