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
            // 상단 태명 + D-day
            Text(
              babyName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              controller.dDayString.isEmpty
                  ? '임신 ${weeks}주차'
                  : controller.dDayString,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),

            // 태아 카드
            _buildBabyCard(weeks),
            const SizedBox(height: 24),

            // 임신 주차 꿀팁
            const Text(
              '임신 주차 꿀팁',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const _TipCard(
              title: '오늘의 생활 꿀팁',
              description: '가습기를 40–60%로 유지해보세요.',
              buttonText: '오늘의 영양제 추천 보기',
              icon: Icons.medication_outlined,
            ),

            // 🔻 기존의 "에어컨 온도 조절" 영역은 제거됨 🔻
            // const SizedBox(height: 24),
            // const Text('에어컨 온도 조절',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 8),
            // const _TemperatureControl(),

            const SizedBox(height: 24),

            // 즐겨 찾는 제품 섹션
            _buildFavoriteDevicesSection(),
          ],
        ),
      ),
    );
  }

  /// 태아 카드 위젯
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              'assets/images/baby.png', // 태아 이미지
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

/// 임신 주차 꿀팁 카드
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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

/// 홈 화면에서 즐겨 찾는 제품 영역
Widget _buildFavoriteDevicesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '즐겨 찾는 제품',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),

      // 가로 스크롤 카드 리스트
      SizedBox(
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            FavoriteDeviceCard(
              name: '냉장고',
              status: '냉장 온도 3℃',
              icon: Icons.kitchen,
            ),
            FavoriteDeviceCard(
              name: '전기레인지',
              status: '보온 모드',
              icon: Icons.microwave,
            ),
            FavoriteDeviceCard(
              name: 'TV',
              status: '꺼짐',
              icon: Icons.tv,
            ),
            FavoriteDeviceCard(
              name: '공기청정기',
              status: '케어 중',
              icon: Icons.air,
            ),
          ],
        ),
      ),
    ],
  );
}

/// 즐겨 찾는 제품 카드
class FavoriteDeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;

  const FavoriteDeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
