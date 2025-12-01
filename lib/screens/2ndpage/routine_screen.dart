import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/air_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/aircon_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/humidifier_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/robot_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/appbar/nofification_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_detail_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/edit_screen.dart';

/// 가전 루틴 화면
class RoutineScreen extends StatefulWidget {
  final PregnancyController controller;

  const RoutineScreen({
    super.key,
    required this.controller, // ← main.dart 에서 넘겨주는 컨트롤러
  });

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    final double screenWidth = MediaQuery.of(context).size.width;
    const double horizontalPadding = 16;
    const double betweenCard = 12;
    final double cardWidth =
        (screenWidth - horizontalPadding * 2 - betweenCard) / 2;

    return Scaffold(
      backgroundColor: Color(0xffFAF0F0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "홈",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      // 홈 변경 버튼
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          "assets/images/keyboard_arrow_down.png",
                          width: 10,
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // 추가 등록 버튼
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // ★ 패널 높이 직접 제어 가능
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xffEFF1F4),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24), // ★ 위쪽만 둥글게
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 12),
                                    Container(
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    // ★ 내부 내용
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          //제품 추가 버튼
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>EditScreen()));},
                                              child: Ink(
                                                width: MediaQuery.of(
                                                  context,
                                                ).size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add_circle,
                                                        color: Color(
                                                          0xff43BA84,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "제품 추가",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            "LG와 다양한 브랜드의 제품",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          //씽큐 플레이
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Ink(
                                                width: MediaQuery.of(
                                                  context,
                                                ).size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_home_work_rounded,
                                                        color: Color(
                                                          0xffDB4F4F,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "우리 단지 연결",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Ink(
                                                width: MediaQuery.of(
                                                  context,
                                                ).size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add_circle,
                                                        color: Color(
                                                          0xff43BA84,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "방 만들기",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          "assets/images/pregnant_register.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // 알림 버튼
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => notification()),
                        ),
                      },
                      child: Image.asset(
                        "assets/images/notification.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                    SizedBox(width: 10),
                    // 메뉴 버튼
                    PopupMenuButton(
                      offset: Offset(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xff2E2E2E),
                      itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "방 설정",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.settings, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                      child: Image.asset(
                        "assets/images/menu.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const _EnergyReportCard(),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '스마트 루틴',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                _SmartRoutineHeaderCard(controller: controller),
                const SizedBox(height: 24),

                Row(
                  children: [
                    const Text(
                      '내 가전',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(child: Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xff8F8E8E),), onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>EditScreen()));},),
                  ],
                ),
                const SizedBox(height: 12),

                // 🔹 에어컨
                Wrap(
                  spacing: betweenCard,
                  runSpacing: betweenCard,
                  children: [
                    _DeviceTile(
                      width: cardWidth,
                      name: '에어컨',
                      status: '온도 조절: 24–26℃ 유지',
                      icon: Image.asset("assets/images/aircon.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AirconControlScreen(controller: controller),
                          ),
                        ).then((_) {
                          // 제어 화면에서 값 바뀌어도, 돌아오면 다시 그리기
                          setState(() {});
                        });
                      },
                    ),

                    // ───────── 공기청정기 ─────────
                    _DeviceTile(
                      width: cardWidth,
                      name: '공기청정기',
                      status: '냄새 제거 모드로 켜짐',
                      icon: Image.asset("assets/images/air_cleaner.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AirCleanerControlScreen(controller: controller),
                          ),
                        ).then((_) {
                          // 제어화면에서 뭔가 바뀌었다고 가정하고 다시 그리기
                          setState(() {});
                        });
                      },
                    ),

                    // 🔹 가습기 (컨트롤러와 완전히 연동되는 부분!)
                    _DeviceTile(
                      width: cardWidth,
                      name: '가습기',
                      status:
                          '습도 조절: ${controller.humidifierTargetHumidity.toStringAsFixed(0)}% 유지',
                      icon: Image.asset("assets/images/humidifier.png"),
                      onTap: () async {
                        // 가습기 제어 화면으로 이동
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HumidifierControlScreen(controller: controller),
                          ),
                        );
                        // 돌아오면 설정값 반영해서 다시 그리기
                        setState(() {});
                      },
                    ),

                    // 🔹 로봇청소기
                    _DeviceTile(
                      width: cardWidth,
                      name: '로봇청소기',
                      status: '오전 10시, 오후 5시 작동',
                      icon: Image.asset("assets/images/robot_cleaner.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RobotCleanerControlScreen(
                              controller: controller,
                            ),
                          ),
                        ).then((_) {
                          // 제어 화면에서 돌아왔을 때 상태 갱신하고 싶으면 여기서 setState 호출
                          setState(() {});
                        });
                      },
                    ),
                    _DeviceTile(
                      width: cardWidth,
                      name: '워시타워',
                      status: """세탁    |     건조\n꺼짐    |     00:09 남음
                                """,
                      icon: Image.asset("assets/images/wash_tower.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RobotCleanerControlScreen(
                              controller: controller,
                            ),
                          ),
                        ).then((_) {
                          // 제어 화면에서 돌아왔을 때 상태 갱신하고 싶으면 여기서 setState 호출
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyReportCard extends StatelessWidget {
  const _EnergyReportCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목 + 자세히 보기
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '12월 리포트',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('에너지 리포트는 준비 중입니다.')),
                  );
                },
                child: const Text(
                  '자세히 보기',
                  style: TextStyle(
                    color: Color(0xff7b5cff),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '제품 에너지 사용량',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          const Text(
            '16,240원',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('75.69 kWh', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          const Text(
            '지난달 같은 기간 대비 8% 사용량 증가',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// 🔹 각 가전 타일
class _DeviceTile extends StatelessWidget {
  final String name;
  final double width;
  final String status;
  final Widget icon;
  final VoidCallback onTap;

  const _DeviceTile({
    required this.name,
    required this.icon,
    required this.onTap,
    required this.width,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SizedBox(width: 40, height: 40, child: icon)),
              const SizedBox(width: 10),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmartRoutineHeaderCard extends StatelessWidget {
  final PregnancyController controller;

  const _SmartRoutineHeaderCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 맞춤 루틴 상세 설정 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SmartRoutineDetailScreen(controller: controller),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xfff5efff),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome, color: Color(0xff7b5cff)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나를 위한 가전별 맞춤 루틴',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '임산부 기본 코스로 가전을 자동 제어합니다.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xff7b5cff)),
          ],
        ),
      ),
    );
  }
}
