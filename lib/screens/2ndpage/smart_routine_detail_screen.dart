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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => InfoTutorial()));
              },
              icon: const Icon(Icons.info_outline))
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
            description: "온도 조절 : 24~26℃ 유지",
            deviceType: "aircon",
            controller: controller,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SmartRoutineAircon()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/air_cleaner.png",
            title: "공기청정기",
            description: "오토 모드로 작동",
            deviceType: "aircleaner",
            controller: controller,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SmartRoutineAirCleaner()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/humidifier.png",
            title: "가습기",
            description: "습도 조절 : 40~60% 유지",
            deviceType: "humidifier",
            controller: controller,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SmartRoutineHumidifier()));
            },
          ),

          Divider(height: 1, color: Color(0xffe8e8e8)),

          _DeviceRow(
            icon: "assets/images/robot_cleaner.png",
            title: "로봇청소기",
            description: "오전 10시, 오후 5시 작동",
            deviceType: "robot",
            controller: controller,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SmartRoutineRobotCleaner()));
            },
          ),
        ],
      ),
    );
  }
}

class _DeviceRow extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final String deviceType;     // aircon / aircleaner / humidifier / robot
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
  late bool isOn;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('device_settings');

    switch (widget.deviceType) {
      case "aircon":
        isOn = box.get('airconOn', defaultValue: false);
        break;

      case "aircleaner":
        isOn = box.get('ac_power', defaultValue: true);
        break;

      case "humidifier":
        isOn = box.get('hum_power', defaultValue: true);
        break;

      case "robot":
        isOn = box.get('robot_on', defaultValue: true);
        break;

      default:
        isOn = false;
    }
  }

  Future<void> _toggle(bool value) async {
    setState(() => isOn = value);
    final box = Hive.box('device_settings');

    switch (widget.deviceType) {
      case "aircon":
        widget.controller.airconOn = value;
        await box.put('airconOn', value);
        break;

      case "aircleaner":
        widget.controller.airCleanerPowerOn = value;
        await box.put('ac_power', value);
        break;

      case "humidifier":
        widget.controller.humidifierPowerOn = value;
        await box.put('hum_power', value);
        break;

      case "robot":
        widget.controller.robotPowerOn = value;
        await box.put('robot_on', value);
        break;
    }

    print("[${widget.deviceType}] 변경됨 → $value");
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
                value: isOn,
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
