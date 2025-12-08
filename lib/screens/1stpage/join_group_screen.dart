import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pregnancy_mode_app/services/api_service.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

class JoinGroupScreen extends StatefulWidget {
  final PregnancyController controller;

  const JoinGroupScreen({
    super.key,
    required this.controller,
  });

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF0F0), // 홈 화면과 동일한 배경

      appBar: AppBar(
        title: const Text(
          "그룹 참여하기",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION TITLE
            const Text(
              "가족과 함께 아기 정보를 공유해보세요",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // ★ INVITE CODE CARD
            _buildInputCard(
              title: "초대 코드 입력",
              child: TextField(
                controller: _codeController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "6자리 초대 코드를 입력해주세요",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ★ RELATION CARD
            _buildInputCard(
              title: "어떤 관계인가요?",
              child: TextField(
                controller: _relationController,
                decoration: InputDecoration(
                  hintText: "예: 남편 / 친구 / 아내 가족",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      // ★ BOTTOM BUTTON
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7A8A), // 임산부톤 포인트컬러
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: _onSubmit,
              child: const Text(
                "그룹 참여하기",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================================
  // 🔥 스타일 카드 위젯 (홈 화면 스타일 적용)
  // ================================
  Widget _buildInputCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // ================================
  // 🔥 제출/검증 로직
  // ================================
  Future<void> _onSubmit() async {
    final code = _codeController.text.trim();
    final relation = _relationController.text.trim();

    if (code.length != 6) {
      _showToast("초대 코드를 정확히 입력해주세요.");
      return;
    }
    if (relation.isEmpty) {
      _showToast("관계를 입력해주세요.");
      return;
    }

    final api = ApiService();
    final result = await api.joinGroup(key: code, relation: relation);

    if (result["success"] == true) {
      final box = Hive.box("pregnancyBox");

      box.put("unique_key", code);
      box.put("relation", relation);
      box.put("memberId", result["data"]["memberId"]);
      box.put("memberIndex", result["data"]["memberIndex"]);

      final info = await api.getPregnancyInfoByKey(code);

      if (info != null) {
        box.put("nickname", info["babyNickname"]);
        box.put("startDate", info["startDate"]);

        // controller에도 반영 → 주차 계산 가능
        widget.controller.saveInfo(
          nickname: info["babyNickname"],
          start: DateTime.parse(info["startDate"]),
          uniqueKey: code,
        );
      }

      Navigator.pop(context, true);
    } else {
      _showToast(result["message"]);
    }
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
