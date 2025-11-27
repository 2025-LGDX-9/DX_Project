import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';

// ⬇️ 네가 실제로 가진 파일 이름에 맞게 수정된 부분
import 'week_health_screen.dart';
import 'nutrition_guide_screen.dart';
import 'government_support_screen.dart';

class InfoScreen extends StatelessWidget {
  final PregnancyController controller;

  const InfoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('임신 관련 정보'),
        backgroundColor: const Color(0xfffdf5f7),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MeditationCard(),
            const SizedBox(height: 24),
            const Text(
              '정보 제공 페이지',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildCategoryGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    final double itemWidth =
        (MediaQuery.of(context).size.width - 16 * 2 - 16 * 3) / 4;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        CategoryButton(
          width: itemWidth,
          icon: Icons.calendar_month,
          label: '주차별\n건강 정보',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WeekHealthScreen(weeks: controller.weeks),
              ),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.medication_liquid,
          label: '영양제·식단',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NutritionGuideScreen(),
              ),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.local_hospital,
          label: '건강·의료',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('건강·의료 정보는 준비 중입니다.')),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.fitness_center,
          label: '운동',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('운동 가이드는 준비 중입니다.')),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.home,
          label: '생활 환경\n관리',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('생활 환경 관리는 준비 중입니다.')),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.shopping_bag,
          label: '산모 용품',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('산모 용품 정보는 준비 중입니다.')),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.question_answer,
          label: '자주하는\n질문',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('FAQ는 준비 중입니다.')),
            );
          },
        ),
        CategoryButton(
          width: itemWidth,
          icon: Icons.volunteer_activism,
          label: '정부지원/\n복지 정보',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const GovernmentSupportScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MeditationCard extends StatelessWidget {
  const _MeditationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/meditation.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '스트레스 완화 콘텐츠 추천',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '집에서 따라하는 10분 명상',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '간단한 호흡과 스트레칭으로 몸과 마음을 함께 풀어주세요.',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double width;

  const CategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, size: 30, color: const Color(0xff7b5cff)),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
