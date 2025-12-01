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
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    // 카드 2열 배치를 위한 너비 계산
    final double screenWidth = MediaQuery.of(context).size.width;
    const double horizontalPadding = 16;
    const double betweenCard = 12;
    final double cardWidth =
        (screenWidth - horizontalPadding * 2 - betweenCard) / 2;

    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('가전 루틴'),
        backgroundColor: const Color(0xfffdf5f7),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(horizontalPadding),
        children: [
          // 1) 11월(12월) 리포트 카드
          const _EnergyReportCard(),
          const SizedBox(height: 24),

          // 2) 스마트 루틴 섹션
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

          // 3) 내 가전 섹션
          const Text(
            '내 가전',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // 4) 내 가전 카드 2열 배치
          Wrap(
            spacing: betweenCard,
            runSpacing: betweenCard,
            children: [
              // 에어컨
              _DeviceCard(
                width: cardWidth,
                icon: Icons.ac_unit,
                name: '에어컨',
                status: '온도 조절: 24–26℃ 유지',
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

              // 공기청정기
              _DeviceCard(
                width: cardWidth,
                icon: Icons.air,
                name: '공기청정기',
                status: '냄새 제거 모드로 켜짐',
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

              // 가습기
              _DeviceCard(
                width: cardWidth,
                icon: Icons.grain,
                name: '가습기',
                status:
                '습도 조절: ${controller.humidifierTargetHumidity.toStringAsFixed(0)}% 유지',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          HumidifierControlScreen(controller: controller),
                    ),
                  ).then((_) => setState(() {}));
                },
              ),

              // 로봇청소기
              _DeviceCard(
                width: cardWidth,
                icon: Icons.cleaning_services_outlined,
                name: '로봇청소기',
                status: '오전 10시, 오후 5시 작동',
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
    );
  }
}

/// 11월 / 12월 리포트 카드
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '75.69 kWh',
            style: TextStyle(fontSize: 12),
          ),
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

/// 상단 "나를 위한 가전별 맞춤 루틴" 카드
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

/// 내 가전용 작은 카드 (2열)
class _DeviceCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String name;
  final String status;
  final VoidCallback onTap;

  const _DeviceCard({
    required this.width,
    required this.icon,
    required this.name,
    required this.status,
    required this.onTap,
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
              Icon(icon, color: const Color(0xff7b5cff), size: 30),
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
