import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:pregnancy_mode_app/screens/2ndpage/info_tutorial.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_aircon.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_humidifier.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_robot_cleaner.dart';
import 'package:pregnancy_mode_app/screens/2ndpage/smart_routine_air_cleaner.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => InfoTutorial()));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/routine_header.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.45, 0.65, 0.90, 1.0],
                  colors: [
                    Colors.transparent,
                    Color(0xAAFFFFFF),
                    Color(0xF2FFFFFF),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 380, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                _DeviceListCard(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================================
// 기기 목록 카드
// ======================================================================

class _DeviceListCard extends StatelessWidget {
  final PregnancyController controller;

  const _DeviceListCard({required this.controller});

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
        children: [
          _DeviceRow(
            icon: "assets/images/aircon.png",
            title: "에어컨",
            description: "24℃~26℃로 설정",
            deviceType: "aircon",
            controller: controller,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SmartRoutineAircon()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/air_cleaner.png",
            title: "공기청정기",
            description: "오토모드로 설정",
            deviceType: "aircleaner",
            controller: controller,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SmartRoutineAirCleaner()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/humidifier.png",
            title: "가습기",
            description: "40%~60%로 설정",
            deviceType: "humidifier",
            controller: controller,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SmartRoutineHumidifier()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/robot_cleaner.png",
            title: "로봇청소기",
            description: "오전10시, 오후 5시에 실행",
            deviceType: "robot",
            controller: controller,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SmartRoutineRobotCleaner()));
            },
          ),
        ],
      ),
    );
  }
}

// ======================================================================
// 각 기기 Row — "루틴 적용 여부"만 저장 / 전원은 절대 건드리지 않음
// ======================================================================

class _DeviceRow extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final String deviceType;
  final PregnancyController controller;
  final VoidCallback? onTap;

  const _DeviceRow({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.deviceType,
    required this.controller,
    this.onTap,
  });

  @override
  State<_DeviceRow> createState() => _DeviceRowState();
}

class _DeviceRowState extends State<_DeviceRow> {
  late bool routineEnabled;

  @override
  void initState() {
    super.initState();

    final routine = Hive.box('routine_settings');

    routineEnabled =
        routine.get("routine_${widget.deviceType}_enabled", defaultValue: true);
  }

  Future<void> _toggle(bool value) async {
    setState(() => routineEnabled = value);

    final routine = Hive.box('routine_settings');
    final c = widget.controller;

    // 루틴 스위치 저장
    routine.put("routine_${widget.deviceType}_enabled", value);

    if (!value) return;

    switch (widget.deviceType) {
    // ------------------------------------------------------------------
    // ⭐ 에어컨
    // ------------------------------------------------------------------
      case "aircon":
        final temp = routine.get("aircon_target_temp");
        final strength = routine.get("aircon_wind_strength");
        final direction = routine.get("aircon_wind_direction");
        final power = routine.get("aircon_power");

        if (temp != null) c.airconTargetTemp = temp.toDouble();
        if (strength != null) c.airconWindStrength = strength;
        if (direction != null) c.airconWindDirection = direction;
        if (power != null) c.airconOn = (power == "켜기");
        break;

    // ------------------------------------------------------------------
    // ⭐ 공기청정기
    // ------------------------------------------------------------------
      case "aircleaner":
        final power = routine.get("aircleaner_power");
        final clean = routine.get("aircleaner_clean_level");     // "약" "보통" "강"
        final booster = routine.get("aircleaner_booster_level"); // "약" "보통" "강"

        if (power != null) c.airCleanerPowerOn = (power == "켜기");

        if (clean != null) {
          c.airCleanerCleanLevel = ["약", "보통", "강"].indexOf(clean).clamp(0, 2);
        }

        if (booster != null) {
          c.airCleanerBoosterLevel =
              ["약", "보통", "강"].indexOf(booster).clamp(0, 2);
        }
        break;

    // ------------------------------------------------------------------
    // ⭐ 가습기
    // ------------------------------------------------------------------
      case "humidifier":
        final powerH = routine.get("humid_power");
        final level = routine.get("humid_level");
        final target = routine.get("humid_target");
        final care = routine.get("humid_care");
        final auto = routine.get("humid_auto");
        final resv = routine.get("humid_reservation");
        final silent = routine.get("humid_silent");

        if (powerH != null) c.humidifierPowerOn = powerH;
        if (level != null) c.humidifierMistLevel = level;
        if (target != null) c.humidifierTargetHumidity = target;
        if (care != null) c.humidifierComfortCare = care;
        if (auto != null) c.humidifierAutoMode = auto;
        if (resv != null) c.humidifierReservationHour = resv;
        if (silent != null) c.humidifierSilentMode = silent;
        break;

    // ------------------------------------------------------------------
    // ⭐ 로봇청소기
    // ------------------------------------------------------------------
      case "robot":
        final powerR = routine.get("robot_power");
        final turbo = routine.get("robot_turbo");
        final smart = routine.get("robot_smart");
        final resv = routine.get("robot_reservation");

        if (powerR != null) c.robotPowerOn = powerR;
        if (turbo != null) c.robotTurbo = turbo;
        if (smart != null) c.robotSmartTurbo = smart;
        if (resv != null) c.robotHasReservation = resv;
        break;
    }

    // 저장
    c.saveAllDeviceSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Image.asset(widget.icon, width: 32, height: 32),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff7b8ba0),
                      ),
                    ),
                  ],
                ),
              ),

              Switch(
                value: routineEnabled,
                activeColor: Colors.redAccent,
                onChanged: _toggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
