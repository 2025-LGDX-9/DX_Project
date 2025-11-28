import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';
import 'smart_routine_detail_screen.dart';
import 'humidifier_control_screen.dart';
import 'aircon_control_screen.dart';
import 'air_cleaner_control_screen.dart';
import 'robot_cleaner_control_screen.dart';

/// 가전 루틴 메인 화면
class RoutineScreen extends StatefulWidget {
  final PregnancyController controller;

  const RoutineScreen({super.key, required this.controller});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  // 에어컨 / 공기청정기 / 로봇청소기 ON/OFF 상태
  bool _acOn = true;
  bool _airCleanerOn = true;
  bool _robotOn = true;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('가전 루틴'),
        backgroundColor: const Color(0xfffdf5f7),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
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
    );
  }
}

/// 🔹 상단 "나를 위한 가전별 맞춤 루틴" 카드
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

/// 🔹 개별 가전 타일
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
