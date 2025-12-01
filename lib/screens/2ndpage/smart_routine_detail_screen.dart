import 'package:flutter/material.dart';
import '../../pregnancy_controller.dart';

class SmartRoutineDetailScreen extends StatelessWidget {
  final PregnancyController controller;

  const SmartRoutineDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final babyName = controller.babyNickname ?? '우리 아기';

    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("맞춤 루틴 상세 설정"),
      ),

      body: Stack(
        children: [
          /// ---------------------------------------------
          /// 🔵 1. 맨 뒤 배경 이미지 (사진)
          /// ---------------------------------------------
          Positioned.fill(
            child: Image.asset(
              'assets/images/routine_header.png',
              fit: BoxFit.cover,
            ),
          ),

          /// ---------------------------------------------
          /// 🔵 2. 사진 아래로 갈수록 더 하얗게 → 완전 흰색
          ///     사진의 아래 55% 영역을 덮는 페이드
          /// ---------------------------------------------
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.45, 0.65, 0.90, 1.0],
                  colors: [
                    Colors.transparent,          // 사진 그대로
                    Color(0xAAFFFFFF),           // 연한 흰색
                    Color(0xF2FFFFFF),           // 거의 흰색
                    Colors.white,                // 완전 흰색
                  ],
                ),
              ),
            ),
          ),

          /// ---------------------------------------------
          /// 🔵 3. 스크롤되는 내용
          ///     (사진 아래에 카드가 겹쳐져 보이도록)
          /// ---------------------------------------------
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 380, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✔ 배경 사진 위에 흰 글자
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 16),
                  child: Text(
                    '$babyName 를 위한 가전별 맞춤 루틴',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                ),

                /// ✔ 가전 리스트 카드 (하얗게)
                _DeviceListCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🔥 사진과 동일한 카드
///////////////////////////////////////////////////////////////////////////////
class _DeviceListCard extends StatelessWidget {
  const _DeviceListCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: const [
          _DeviceRow(
            icon: "assets/images/aircon.png",
            title: "에어컨",
            description: "온도 조절 : 24~26℃ 유지",
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/air_cleaner.png",
            title: "공기청정기",
            description: "오토 모드로 작동",
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/humidifier.png",
            title: "가습기",
            description: "습도 조절 : 40~60% 유지",
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/robot_cleaner.png",
            title: "로봇청소기",
            description: "오전 10시, 오후 5시 작동",
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🔥 단일 항목 (아이콘 + 텍스트)
///////////////////////////////////////////////////////////////////////////////
class _DeviceRow extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const _DeviceRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Image.asset(icon, width: 32, height: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff7b8ba0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
