import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';
import 'smart_routine_detail_screen.dart';

class RoutineScreen extends StatefulWidget {
  final PregnancyController controller;

  const RoutineScreen({super.key, required this.controller});

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
      appBar: AppBar(
        title: const Text('가전 루틴'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: const Color(0xfffdf5f7),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- 나를 위한 가전별 맞춤 루틴 카드 ----
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SmartRoutineDetailScreen(
                    controller: widget.controller,
                  ),
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

          // ---- 여기 추가: 내 가전 제목 ----
          const Text(
            '내 가전',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // ---- 개별 가전 on/off 카드들 ----
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
    );
  }
}

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
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
