import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/air_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/aircon_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/humidifier_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/robot_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/appbar/nofification_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_detail_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/edit_screen.dart';

class RoutineScreen extends StatefulWidget {
  final PregnancyController controller;

  const RoutineScreen({
    super.key,
    required this.controller,
  });

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  /// 🔥 공통 상태 문자열 생성 — HomeScreen FavoriteCard와 동일 구조(+커스텀 적용)
  String _getDeviceStatus(String type, PregnancyController c) {
    switch (type) {
      case "aircon":
        final t = c.airconTargetTemp.toStringAsFixed(0);
        final mode = c.airconSleepMode ? "취침" : "기본";
        return "$t°C · $mode";

      case "aircleaner":
      // 단계 → 텍스트 변환
        String levelText(int lv) {
          switch (lv) {
            case 0: return "약";
            case 1: return "보통";
            case 2: return "강";
            default: return "-";
          }
        }

        final clean = levelText(c.airCleanerCleanLevel);
        final booster = levelText(c.airCleanerBoosterLevel);
        return "청정: $clean · 부스터: $booster";

      case "humidifier":
        final hum = c.humidifierTargetHumidity.toStringAsFixed(0);

        // 🔥 분무량 1/2/3 → 퍼센트로 변환
        String mistPercent(int level) {
          switch (level) {
            case 1: return "50%";  // 약
            case 2: return "75%";  // 보통
            case 3: return "100%"; // 강
            default: return "-";
          }
        }

        final mist = mistPercent(c.humidifierMistLevel);

        return "희망습도: $hum% · 분무량: $mist";

      case "robot":
        final turbo = c.robotTurbo ? "터보" : "일반";
        return "모드: $turbo";

      default:
        return "";
    }
  }

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
          /// ---------------------- 상단바 ----------------------
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
                    /// 제품 추가 패널
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xffEFF1F4),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
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
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => EditScreen(),
                                                  ),
                                                );
                                              },
                                              child: Ink(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.add_circle,
                                                          color: Color(0xff43BA84)),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "제품 추가",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                              FontWeight.bold,
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

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => notification()),
                        );
                      },
                      child: Image.asset(
                        "assets/images/notification.png",
                        width: 25,
                        height: 25,
                      ),
                    ),

                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),

          /// ---------------------- 본문 ----------------------
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
                    SizedBox(width: 5),
                    GestureDetector(
                      child: Icon(Icons.arrow_forward_ios,
                          size: 18, color: Color(0xff8F8E8E)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditScreen()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: betweenCard,
                  runSpacing: betweenCard,
                  children: [
                    /// ---------------- 에어컨 ----------------
                    _DeviceTile(
                      width: cardWidth,
                      name: '에어컨',
                      status: _getDeviceStatus("aircon", controller),
                      icon: Image.asset("assets/images/aircon.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AirconControlScreen(controller: controller),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),

                    /// ---------------- 공기청정기 ----------------
                    _DeviceTile(
                      width: cardWidth,
                      name: '공기청정기',
                      status: _getDeviceStatus("aircleaner", controller),
                      icon: Image.asset("assets/images/air_cleaner.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AirCleanerControlScreen(controller: controller),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),

                    /// ---------------- 가습기 ----------------
                    _DeviceTile(
                      width: cardWidth,
                      name: '가습기',
                      status: _getDeviceStatus("humidifier", controller),
                      icon: Image.asset("assets/images/humidifier.png"),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HumidifierControlScreen(controller: controller),
                          ),
                        );
                        setState(() {});
                      },
                    ),

                    /// ---------------- 로봇청소기 ----------------
                    _DeviceTile(
                      width: cardWidth,
                      name: '로봇청소기',
                      status: _getDeviceStatus("robot", controller),
                      icon: Image.asset("assets/images/robot_cleaner.png"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RobotCleanerControlScreen(controller: controller),
                          ),
                        ).then((_) => setState(() {}));
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
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12월 리포트',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '자세히 보기',
                style: TextStyle(
                  color: Color(0xff7b5cff),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '제품 에너지 사용량',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 12),
          Text(
            '16,240원',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('75.69 kWh', style: TextStyle(fontSize: 12)),
          SizedBox(height: 4),
          Text(
            '지난달 같은 기간 대비 8% 사용량 증가',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

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
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SizedBox(width: 40, height: 40, child: icon)),
              const SizedBox(height: 10),
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
          color: Color(0xfff5efff),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 4),
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
