import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/screens/onboarding_screen.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

/// 가전 루틴 화면
class RoutineScreen extends StatelessWidget {
  final PregnancyController controller;

  const RoutineScreen({
    super.key,
    required this.controller, // ← main.dart 에서 넘겨주는 컨트롤러
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('가전 루틴'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔹 헤더 부분 (텍스트 전체가 버튼처럼 동작)
          _RoutineHeader(controller: controller),

          const SizedBox(height: 16),

          const _DeviceTile(
            name: '에어컨',
            description: '온도 조절: 24–26°C 유지',
            icon: Icons.ac_unit,
          ),
          const _DeviceTile(
            name: '공기청정기',
            description: '냄새 제거 모드로 켜짐',
            icon: Icons.air,
          ),
          const _DeviceTile(
            name: '가습기',
            description: '습도 조절: 40–60% 유지',
            icon: Icons.grain,
          ),
          const _DeviceTile(
            name: '로봇청소기',
            description: '오전 10시, 오후 5시 작동',
            icon: Icons.cleaning_services_outlined,
          ),
        ],
      ),
    );
  }
}

/// 🔹 상단 "나를 위한 가전별 맞춤 루틴" 카드
class _RoutineHeader extends StatelessWidget {
  final PregnancyController controller;

  const _RoutineHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff3f6ff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 👉 텍스트 영역 전체를 버튼처럼 눌렀을 때 온보딩 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OnboardingScreen(
                controller: controller,
                onCompleted: () {
                  // 온보딩 완료 후에 할 동작 있으면 여기 추가
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '나를 위한 가전별 맞춤 루틴',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('임산부 기본 코스로 가전을 자동 제어합니다.'),
          ],
        ),
      ),
    );
  }
}

/// 🔹 각 가전 타일
class _DeviceTile extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;

  const _DeviceTile({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
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
          value: true,
          onChanged: (_) {},
        ),
      ),
    );
  }
}
