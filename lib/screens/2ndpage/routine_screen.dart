import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/air_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/aircon_control_screen.dart';
import 'package:pregnancy_mode_app/humidifier_control_screen.dart';
import 'package:pregnancy_mode_app/robot_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/appbar/nofification_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_detail_screen.dart';

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
  bool _acOn = true;
  bool _airCleanerOn = true;
  bool _robotOn = true;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

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
                // 🔹 상단 "나를 위한 가전별 맞춤 루틴" 카드
                _SmartRoutineHeaderCard(controller: controller),

                const SizedBox(height: 24),
                const Text(
                  '내 가전',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // 🔹 에어컨
                _DeviceTile(
                  name: '에어컨',
                  description: '온도 조절: 24–26℃ 유지',
                  icon: Icons.ac_unit,
                  isOn: _acOn,
                  onToggle: (value) {
                    setState(() {
                      _acOn = value;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AirconControlScreen(controller: controller),
                      ),
                    ).then((_) {
                      // 제어 화면에서 값 바뀌어도, 돌아오면 다시 그리기
                      setState(() {});
                    });
                  },
                ),

                // ───────── 공기청정기 ─────────
                _DeviceTile(
                  name: '공기청정기',
                  description: '냄새 제거 모드로 켜짐',
                  icon: Icons.air,
                  isOn: _airCleanerOn,
                  onToggle: (value) {
                    setState(() {
                      _airCleanerOn = value;
                    });
                  },
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
                  name: '가습기',
                  description:
                  '습도 조절: ${controller.humidifierTargetHumidity.toStringAsFixed(0)}% 유지',
                  icon: Icons.grain,
                  isOn: controller.humidifierPower,
                  onToggle: (value) {
                    setState(() {
                      controller.humidifierPower = value;
                    });
                  },
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
                  name: '로봇청소기',
                  description: '오전 10시, 오후 5시 작동',
                  icon: Icons.cleaning_services_outlined,
                  isOn: _robotOn,
                  onToggle: (value) {
                    setState(() {
                      _robotOn = value;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RobotCleanerControlScreen(controller: controller),
                      ),
                    ).then((_) {
                      // 제어 화면에서 돌아왔을 때 상태 갱신하고 싶으면 여기서 setState 호출
                      setState(() {});
                    });
                  },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 각 가전 타일
class _DeviceTile extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final bool isOn;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTap;

  const _DeviceTile({
    required this.name,
    required this.description,
    required this.icon,
    required this.isOn,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xff7b5cff), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isOn,
                activeColor: const Color(0xff7b5cff),
                onChanged: onToggle,
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
              child: const Icon(
                Icons.auto_awesome,
                color: Color(0xff7b5cff),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나를 위한 가전별 맞춤 루틴',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '임산부 기본 코스로 가전을 자동 제어합니다.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xff7b5cff),
            ),
          ],
        ),
      ),
    );
  }
}
