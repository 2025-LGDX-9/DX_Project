import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/4thpage/update_mypage.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key, required this.controller});

  final PregnancyController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6EDED), // 연핑크 배경
      appBar: AppBar(
        backgroundColor: const Color(0xffF6EDED),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            const SizedBox(width: 10),
            const Text(
              "마이페이지",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            // ==============================
            //   프로필 박스
            // ==============================
            Row(
              children: [
                // 프로필 이미지
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/baby.png",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.edit, size: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "새싹맘",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.edit, size: 20),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // ============================
                    //   내 정보 수정 버튼 (수정됨)
                    // ============================
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateMyPageScreen(
                                controller: controller,
                              ),
                            ),
                          );
                        },

                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          child: const Text(
                            "내 정보 수정",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==============================
            // 멤버십 / Q리워드 박스
            // ==============================
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text("멤버십", style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4),
                      Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black26,
                  ),
                  Column(
                    children: const [
                      Text("Q리워드", style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4),
                      Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // 1:1 문의
            const Text(
              "1:1 문의",
              style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            _infoCard(
              content: "지금은 진행 중인 문의가 없어요.",
              bottomText: "전체 문의 보기",
            ),

            const SizedBox(height: 30),

            // 제품 정보와 보증
            const Text(
              "제품 정보와 보증",
              style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            _infoCard(
              content: "보증 기간 내의 제품이 없어요.",
              bottomText: "전체 제품 보기",
            ),

            const SizedBox(height: 30),

            // 서비스 예약
            const Text(
              "서비스 예약",
              style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            _infoCard(
              content: "",
              bottomText: "전체 예약 보기",
              onlyButton: true,
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // ==============================
  // 재사용 가능한 카드 UI
  // ==============================
  Widget _infoCard({
    required String content,
    required String bottomText,
    bool onlyButton = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          if (!onlyButton) ...[
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            Divider(height: 1),
            const SizedBox(height: 16),
          ],

          // 하단 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bottomText,
                style: const TextStyle(
                  color: Color(0xff4F6CFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff4F6CFF),
              ),
            ],
          )
        ],
      ),
    );
  }
}
