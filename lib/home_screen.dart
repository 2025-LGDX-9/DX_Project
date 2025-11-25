import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';

class HomeScreen extends StatelessWidget {
  final PregnancyController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final weeks = controller.weeks;
    final babyName = controller.babyNickname ?? '우리 아기';

    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('홈'),
        backgroundColor: const Color(0xfffdf5f7),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              babyName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              controller.dDayString.isEmpty
                  ? '임신 ${weeks}주차'
                  : controller.dDayString,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            _buildBabyCard(weeks),
            const SizedBox(height: 24),
            const Text('임신 주차 꿀팁',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const _TipCard(
              title: '오늘의 생활 꿀팁',
              description: '가습기를 40–60%로 유지해보세요.',
              buttonText: '오늘의 영양제 추천 보기',
              icon: Icons.medication_outlined,
            ),
            const SizedBox(height: 24),
            const Text('에어컨 온도 조절',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const _TemperatureControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildBabyCard(int weeks) {
    return Container(
      width: double.infinity,
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
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xfffde4ea),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '저는 지금 헤엄치는 중이에요',
              style: TextStyle(color: Colors.red.shade400),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/baby.png', // 네가 넣은 태아 이미지
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '임신 ${weeks}주차에는 이런 걸 해보세요!',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;

  const _TipCard({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(icon, size: 18),
            label: Text(buttonText),
            style: OutlinedButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TemperatureControl extends StatefulWidget {
  const _TemperatureControl();

  @override
  State<_TemperatureControl> createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<_TemperatureControl> {
  double _value = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('권장 범위: 24–26°C'),
        const SizedBox(height: 8),
        Text(
          '${_value.toStringAsFixed(0)}°C',
          style:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _value,
          min: 18,
          max: 30,
          onChanged: (v) {
            setState(() => _value = v);
          },
        ),
        const Text('적정 온도입니다. 몸이 춥거나 덥지 않은지 한 번 더 체크해 주세요.'),
      ],
    );
  }
}
