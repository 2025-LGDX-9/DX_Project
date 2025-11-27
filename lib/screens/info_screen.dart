import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';

class InfoScreen extends StatelessWidget {
  final PregnancyController controller;

  const InfoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 타이틀
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "임신 관련 정보",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 상단 콘텐츠 + 제목 묶음
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MeditationRecommendCard(),
                const SizedBox(height: 24),
                const Text(
                  '정보 제공 페이지',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _InfoCategoryGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeditationRecommendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 영역
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/meditation.png', // 명상 일러스트
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '스트레스 완화 콘텐츠 추천',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  '집에서 따라하는 10분 명상',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '간단한 호흡과 스트레칭으로 몸과 마음을 함께 풀어주세요.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _InfoIconButton extends StatelessWidget {
  final String imagePath;
  final String label;

  const _InfoIconButton({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label 페이지는 아직 준비 중이에요.')));
      },
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _InfoCategoryGrid extends StatelessWidget {
  const _InfoCategoryGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 0.8,
      // 아이콘+텍스트 비율 조정
      shrinkWrap: true,
      // ★ 높이를 내용에 맞게 줄이기
      physics: const NeverScrollableScrollPhysics(),
      // ★ 바깥 스크롤과만 동작
      children: const [
        _InfoGridItem(
          label: '주차별\n건강 정보',
          assetPath: 'assets/images/info_week.png',
        ),
        _InfoGridItem(
          label: '영양제·식단',
          assetPath: 'assets/images/info_nutrition.png',
        ),
        _InfoGridItem(
          label: '건강·의료',
          assetPath: 'assets/images/info_health.png',
        ),
        _InfoGridItem(
          label: '운동',
          assetPath: 'assets/images/info_exercise.png',
        ),
        _InfoGridItem(
          label: '생활환경\n관리',
          assetPath: 'assets/images/info_life.png',
        ),
        _InfoGridItem(
          label: '산모 용품',
          assetPath: 'assets/images/info_goods.png',
        ),
        _InfoGridItem(
          label: '자주하는\n질문',
          assetPath: 'assets/images/info_faq.png',
        ),
        _InfoGridItem(
          label: '정부 지원\n복지 정보',
          assetPath: 'assets/images/info_support.png',
        ),
      ],
    );
  }
}

/// 한 칸짜리 아이콘 + 텍스트 위젯
class _InfoGridItem extends StatelessWidget {
  final String label;
  final String assetPath;

  const _InfoGridItem({required this.label, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}
