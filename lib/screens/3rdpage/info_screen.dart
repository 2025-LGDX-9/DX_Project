import 'package:flutter/material.dart';
import 'package:pregnancy_mode_app/pregnancy_controller.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/nutrition_guide_screen.dart';
import 'package:pregnancy_mode_app/screens/3rdpage/week_health_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pregnancy_mode_app/screens/3rdpage/government_support_screen.dart';

class InfoScreen extends StatelessWidget {
  final PregnancyController controller;

  const InfoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF0F0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 제목
          const Text(
            "임신 관련 정보",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // 명상 카드
          _MeditationCard(),

          const SizedBox(height: 24),

          const Text(
            '정보 제공 페이지',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // GRIDVIEW (스크롤 금지, 높이 계산만 맡김)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            // 🔥 셀을 더 "높게" 만들어서 Column이 여유있게 들어가도록
            childAspectRatio: 0.55, // (width / height), 값 낮을수록 셀 높이가 커짐
            children: [
              CategoryButton(
                icon: Icons.calendar_month,
                label: '주차별\n건강 정보',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WeekHealthScreen(controller: controller),
                    ),
                  );
                },
              ),
              CategoryButton(
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
                icon: Icons.local_hospital,
                label: '건강·의료',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('건강·의료 정보는 준비 중입니다.')),
                  );
                },
              ),
              CategoryButton(
                icon: Icons.fitness_center,
                label: '운동',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('운동 가이드는 준비 중입니다.')),
                  );
                },
              ),
              CategoryButton(
                icon: Icons.home,
                label: '생활 환경\n관리',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('생활 환경 관리는 준비 중입니다.')),
                  );
                },
              ),
              CategoryButton(
                icon: Icons.shopping_bag,
                label: '산모 용품',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('산모 용품 정보는 준비 중입니다.')),
                  );
                },
              ),
              CategoryButton(
                icon: Icons.question_answer,
                label: '자주하는\n질문',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('FAQ는 준비 중입니다.')),
                  );
                },
              ),
              CategoryButton(
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
          ),
        ],
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  const _MeditationCard();

  // 이동할 유튜브 URL
  final String youtubeUrl = "https://www.youtube.com/watch?v=cvPS_25gRPs";

  Future<void> _openYoutube() async {
    final Uri url = Uri.parse(youtubeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      print("URL 실행 실패");
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openYoutube,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
          mainAxisSize: MainAxisSize.min,
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
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '스트레스 완화 콘텐츠 추천',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '집에서 따라하는 10분 명상',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔥 셀 안에서 필요 이상으로 안 늘어나게
        children: [
          Container(
            width: 56,  // 🔥 조금 줄임 (64 → 56)
            height: 56, // 🔥 조금 줄임
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
            child: Icon(
              icon,
              size: 28, // 살짝 줄임
              color: const Color(0xff7b5cff),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
