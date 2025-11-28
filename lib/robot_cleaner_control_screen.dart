import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';

/// 로봇청소기 제어 화면
class RobotCleanerControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const RobotCleanerControlScreen({super.key, required this.controller});

  @override
  State<RobotCleanerControlScreen> createState() =>
      _RobotCleanerControlScreenState();
}

class _RobotCleanerControlScreenState
    extends State<RobotCleanerControlScreen> {
  bool powerOn = true;
  bool turbo = false;
  bool smartTurbo = true;
  bool hasReservation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
      appBar: AppBar(
        title: const Text('로봇청소기'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 상단 상태 영역
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.battery_full, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  '충전 완료',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '65%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          // 전체 청소 시작 버튼
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    powerOn = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('전체 청소를 시작합니다.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff385a92),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  '전체 청소 시작',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 터보 / 스마트 터보 카드
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _modeRow(
                  title: '터보',
                  subtitle: '강하게 한 번에 청소하고 싶을 때 사용해요.',
                  value: turbo,
                  onChanged: (v) => setState(() => turbo = v),
                ),
                const Divider(height: 24),
                _modeRow(
                  title: '스마트 터보',
                  subtitle: '구석, 카펫, 먼지가 많은 곳을 감지하면 더 강력한 흡입력으로 청소해요.',
                  value: smartTurbo,
                  onChanged: (v) => setState(() => smartTurbo = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 청소 예약 카드
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () async {
                // 일단은 간단하게 토글만 해두기
                setState(() {
                  hasReservation = !hasReservation;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      hasReservation
                          ? '청소 예약이 설정되었습니다.'
                          : '청소 예약이 해제되었습니다.',
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Color(0xff1b9c85)),
                  const SizedBox(width: 12),
                  const Text(
                    '청소 예약',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    hasReservation ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontSize: 13,
                      color: hasReservation
                          ? const Color(0xff1b9c85)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),

          const Spacer(),

          // 하단 탭 비슷한 영역 (디자인만)
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff385a92),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '제품',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '유용한 기능',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        const Icon(Icons.waves, color: Color(0xff385a92)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xff385a92),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
