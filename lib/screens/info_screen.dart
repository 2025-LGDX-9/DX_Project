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
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 상단 콘텐츠 + 제목 묶음
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,   // ★ 필수: Column이 높이를 무한대로 차지하지 않음
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 추천 카드
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(
                            'assets/images/meditation.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '스트레스 완화 콘텐츠 추천',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '집에서 따라하는 10분 명상',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '간단한 호흡과 스트레칭으로 몸과 마음을 함께 풀어주세요.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  '정보 제공 페이지',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // 하단 GridView (남은 공간만 차지)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 4,
                children: const [
                  _InfoIconButton(
                    imagePath: 'assets/images/info_week.png',
                    label: '주차별\n건강 정보',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_nutrition.png',
                    label: '영양제·식단',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_health.png',
                    label: '건강·의료',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_exercise.png',
                    label: '운동',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_life.png',
                    label: '생활환경\n관리',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_goods.png',
                    label: '산모 용품',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_faq.png',
                    label: '자주하는\n질문',
                  ),
                  _InfoIconButton(
                    imagePath: 'assets/images/info_support.png',
                    label: '정부 지원\n복지 정보',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoIconButton extends StatelessWidget {
  final String imagePath;
  final String label;

  const _InfoIconButton({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label 페이지는 아직 준비 중이에요.')),
        );
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
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
