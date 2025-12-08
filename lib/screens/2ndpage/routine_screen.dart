import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pregnancy_mode_app/screens/2ndpage/air_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/aircon_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/chart_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/humidifier_control_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/robot_cleaner_control_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/appbar/nofification_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_detail_screen.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/edit_screen.dart';

import 'package:pregnancy_mode_app/models/energy_log.dart';

double getDeviceWatt(int id) {
  switch (id) {
    case 1:
      return 1200;
    case 2:
      return 120;
    case 3:
      return 100;
    case 4:
      return 80;
    default:
      return 0;
  }
}

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
  String _getDeviceStatus(String type, PregnancyController c) {
    switch (type) {
      case "aircon":
        final temp = c.airconTargetTemp.toStringAsFixed(0);
        final strength = c.airconWindStrength;
        final direction = c.airconWindDirection;
        return "$temp°C · $strength ·\n$direction";

      case "aircleaner":
        String levelText(int lv) {
          switch (lv) {
            case 0:
              return "약";
            case 1:
              return "보통";
            case 2:
              return "강";
            default:
              return "-";
          }
        }

        final clean = levelText(c.airCleanerCleanLevel);
        final booster = levelText(c.airCleanerBoosterLevel);
        return "청정: $clean · 부스터: $booster";

      case "humidifier":
        final hum = c.humidifierTargetHumidity.toStringAsFixed(0);

        String mistPercent(int lv) {
          switch (lv) {
            case 1:
              return "50%";
            case 2:
              return "75%";
            case 3:
              return "100%";
            default:
              return "-";
          }
        }

        final mist = mistPercent(c.humidifierMistLevel);
        return "희망습도: $hum% · 분무량: $mist";

      case "robot":
        final turbo = c.robotTurbo ? "터보" : "일반";
        return "모드: $turbo";

      default:
        return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 16 * 2 - 12) / 2;

    return Scaffold(
      backgroundColor: const Color(0xffFAF0F0),
      body: Column(
        children: [
          // ---------------------- 상단바 ----------------------
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Text(
                        "홈",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        child: Image.asset(
                          "assets/images/keyboard_arrow_down.png",
                          width: 10,
                          height: 10,
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    // 추가 패널
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
                                padding: const EdgeInsets.only(top: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xffEFF1F4),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.add_circle,
                                                color: Color(0xff43BA84)),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "제품 추가",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
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

                    const SizedBox(width: 10),

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

                    const SizedBox(width: 10),
                  ],
                )
              ],
            ),
          ),

          // ---------------------- 본문 ----------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 자동 계산되는 리포트 카드
                const _EnergyReportCard(),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('스마트 루틴',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),

                const SizedBox(height: 8),
                _SmartRoutineHeaderCard(controller: controller),
                const SizedBox(height: 24),

                Row(
                  children: [
                    const Text('내 가전',
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditScreen()));
                      },
                      child: const Icon(Icons.arrow_forward_ios,
                          size: 18, color: Color(0xff8F8E8E)),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    // 에어컨
                    _DeviceTile(
                      width: cardWidth,
                      name: "에어컨",
                      status: _getDeviceStatus("aircon", controller),
                      icon: Image.asset("assets/images/aircon.png"),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  AirconControlScreen(controller: controller)),
                        );
                        setState(() {});
                      },
                    ),

                    // 공기청정기
                    _DeviceTile(
                      width: cardWidth,
                      name: "공기청정기",
                      status: _getDeviceStatus("aircleaner", controller),
                      icon: Image.asset("assets/images/air_cleaner.png"),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  AirCleanerControlScreen(controller: controller)),
                        );
                        setState(() {});
                      },
                    ),

                    // 가습기
                    _DeviceTile(
                      width: cardWidth,
                      name: "가습기",
                      status: _getDeviceStatus("humidifier", controller),
                      icon: Image.asset("assets/images/humidifier.png"),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  HumidifierControlScreen(controller: controller)),
                        );
                        setState(() {});
                      },
                    ),

                    // 로봇청소기
                    _DeviceTile(
                      width: cardWidth,
                      name: "로봇청소기",
                      status: _getDeviceStatus("robot", controller),
                      icon: Image.asset("assets/images/robot_cleaner.png"),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  RobotCleanerControlScreen(controller: controller)),
                        );
                        setState(() {});
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

//
// ───────────────────────────────────────────────────────────
//   █  에너지 리포트 카드 (자동 계산됨)
// ───────────────────────────────────────────────────────────
//
class _EnergyReportCard extends StatelessWidget {
  const _EnergyReportCard();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<EnergyLog>('energy_logs').listenable(),
      builder: (context, Box<EnergyLog> box, _) {
        double totalKwh = 0;

        for (final log in box.values) {
          final hours = _getUsageHours(log.extraInfo);
          final watt = getDeviceWatt(log.deviceId);
          totalKwh += (watt * hours) / 1000.0;
        }

        final cost = totalKwh * 88.3;

        return Container(
          padding: const EdgeInsets.all(20),
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

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------- 🔵 아이콘 위치 수정 --------------------
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/images/energy_report_icon.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // -------------------- 🔵 텍스트 묶음 --------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // '자세히 보기'
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ChartScreen()),
                          );
                        },
                        child: const Text(
                          "자세히 보기 >",
                          style: TextStyle(
                            color: Color(0xff7b5cff),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 금액
                    Text(
                      '${cost.toStringAsFixed(0)} 원',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // kWh
                    Text(
                      '${totalKwh.toStringAsFixed(2)} kWh',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 지난달 데이터
                    const Text(
                      '지난달 같은 기간 87.61 kWh',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static double _getUsageHours(String extraInfo) {
    final regex = RegExp(r'\((\d{2})~(\d{2})시\)');
    final match = regex.firstMatch(extraInfo);
    if (match == null) return 0.0;

    int start = int.parse(match.group(1)!);
    int end = int.parse(match.group(2)!);

    if (end < start) end += 24;
    return (end - start).toDouble();
  }
}



//
// ───────────────────────────────────────────────────────────
//   ░  디바이스 타일
// ───────────────────────────────────────────────────────────
//
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
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ───────────────────────────────────────────────────────────
//   ░  스마트 루틴 헤더
// ───────────────────────────────────────────────────────────
//
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
            builder: (_) =>
                SmartRoutineDetailScreen(controller: controller),
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
                  color: Colors.white, shape: BoxShape.circle),
              child:
              const Icon(Icons.auto_awesome, color: Color(0xff7b5cff)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('나를 위한 가전별 맞춤 루틴',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('임산부 기본 코스로 가전을 자동 제어합니다.',
                      style:
                      TextStyle(fontSize: 13, color: Colors.black54)),
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
