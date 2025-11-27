import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/onboarding_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/nofification_screen.dart';
import 'package:pregnancy_mode_app/screens/smart_routine_detail_screen.dart';

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
  bool _airconOn = true;
  bool _airCleanerOn = true;
  bool _humidifierOn = true;
  bool _robotOn = true;

  @override
  Widget build(BuildContext context) {
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
                // 🔹 헤더 부분 (텍스트 전체가 버튼처럼 동작)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SmartRoutineDetailScreen(controller: widget.controller),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xfff7edff),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.deepPurple),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  '내 가전',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _DeviceTile(
                  name: '에어컨',
                  description: '온도 조절: 24–26°C 유지',
                  icon: Icons.ac_unit,
                  value: _airconOn,
                  onChanged: (v) => setState(() => _airconOn = v),
                ),
                _DeviceTile(
                  name: '공기청정기',
                  description: '냄새 제거 모드로 켜짐',
                  icon: Icons.air,
                  value: _airCleanerOn,
                  onChanged: (v) => setState(() => _airCleanerOn = v),
                ),
                _DeviceTile(
                  name: '가습기',
                  description: '습도 조절: 40–60% 유지',
                  icon: Icons.grain,
                  value: _humidifierOn,
                  onChanged: (v) => setState(() => _humidifierOn = v),
                ),
                _DeviceTile(
                  name: '로봇청소기',
                  description: '오전 10시, 오후 5시 작동',
                  icon: Icons.cleaning_services_outlined,
                  value: _robotOn,
                  onChanged: (v) => setState(() => _robotOn = v),
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
  final bool value;
  final ValueChanged<bool> onChanged;

  const _DeviceTile({
    required this.name,
    required this.description,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(name),
        subtitle: Text(description),
        trailing: Switch(value: value, onChanged: onChanged),
      ),
    );
  }
}
