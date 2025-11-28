import 'package:flutter/material.dart';
import '../pregnancy_controller.dart';

/// 주차별 건강 정보 화면
class WeekHealthScreen extends StatefulWidget {
  final PregnancyController controller;

  const WeekHealthScreen({super.key, required this.controller});

  @override
  State<WeekHealthScreen> createState() => _WeekHealthScreenState();
}

class _WeekHealthScreenState extends State<WeekHealthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 예시 주차 데이터 (15~20주)
  final List<_WeekInfo> _weeks = [
    _WeekInfo(
      week: 15,
      title: '태아 성장',
      subtitle: '이제 몸의 비율이 점점 균형을 맞춰가요.',
      bodyChange:
      '피부가 조금씩 건조해질 수 있고 피로감을 느끼기 쉬운 시기예요. 수분 섭취를 충분히 해 주세요.',
      exercise: '가벼운 스트레칭과 10분 정도 산책을 해보세요.',
      caution: '배가 당기는 느낌이 심하면 무리하지 말고 휴식을 취하세요.',
    ),
    _WeekInfo(
      week: 16,
      title: '태아 성장',
      subtitle: '이제 아기 소리를 들을 수 있어요!',
      bodyChange:
      '안정기에 접어들었어요. 유선이 발달하며 유방이 더 커지면서 피로감과 두통이 줄어들 수 있어요.',
      exercise: '10분 이상 산책해보세요.',
      caution: '카페인 섭취에 주의하세요.',
    ),
    _WeekInfo(
      week: 17,
      title: '태아 성장',
      subtitle: '아기가 활발하게 움직이기 시작하는 시기예요.',
      bodyChange:
      '허리 통증이나 다리 부종이 생길 수 있어요. 오래 서 있는 자세는 피하고 틈틈이 스트레칭을 해 주세요.',
      exercise: '가벼운 임산부 요가나 골반 스트레칭이 도움이 돼요.',
      caution: '무거운 물건 들기, 갑작스러운 동작은 피하세요.',
    ),
    _WeekInfo(
      week: 18,
      title: '태아 성장',
      subtitle: '태동이 더 분명하게 느껴질 수 있어요.',
      bodyChange:
      '소화불량이나 속쓰림이 나타날 수 있어요. 한 번에 많이 먹기보다 조금씩 자주 드세요.',
      exercise: '저강도 실내 자전거 또는 가벼운 실내 운동이 좋아요.',
      caution: '식후 바로 눕지 말고 상체를 약간 세운 상태로 휴식하세요.',
    ),
    _WeekInfo(
      week: 19,
      title: '태아 성장',
      subtitle: '감각기관이 발달하면서 소리와 빛에 반응해요.',
      bodyChange:
      '다리 쥐가 나거나 야간에 잠이 잘 오지 않을 수 있어요. 자기 전 따뜻한 물로 샤워해보세요.',
      exercise: '가벼운 하체 스트레칭으로 혈액 순환을 도와주세요.',
      caution: '속이 답답하면 꽉 끼는 옷은 피하고 편한 복장을 선택하세요.',
    ),
    _WeekInfo(
      week: 20,
      title: '태아 성장',
      subtitle: '임신 중기 중반, 태아와 산모 모두 활발한 시기예요.',
      bodyChange:
      '체중 증가가 본격적으로 시작돼요. 규칙적인 식사와 가벼운 운동으로 컨디션을 관리해 주세요.',
      exercise: '30분 이내의 가벼운 산책이나 실내 활동이 좋아요.',
      caution: '과도한 당분 섭취를 줄이고, 정기 검진 일정을 꼭 지켜주세요.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _weeks.length, vsync: this);

    // 현재 임신 주차에 맞춰 초기 인덱스 설정 (가능하면)
    final currentWeek = widget.controller.weeks;
    final idx = _weeks.indexWhere((w) => w.week == currentWeek);
    if (idx != -1) {
      _tabController.index = idx;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      appBar: AppBar(
        title: const Text('주차별 건강 정보'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xff7b61ff),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xff7b61ff),
              tabs: _weeks
                  .map((w) => Tab(text: '${w.week}주차'))
                  .toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _weeks.map((w) => _WeekDetailView(info: w)).toList(),
      ),
    );
  }
}

/// 한 주차 상세 화면
class _WeekDetailView extends StatelessWidget {
  final _WeekInfo info;

  const _WeekDetailView({required this.info});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 상단 태아 성장 카드
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${info.week}주차',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      info.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(info.subtitle),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  'assets/images/baby.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 몸의 변화
        _InfoCard(
          title: '몸의 변화',
          icon: Icons.favorite_outline,
          description: info.bodyChange,
          iconColor: Colors.pinkAccent,
        ),
        const SizedBox(height: 16),

        // 추천 운동
        _InfoCard(
          title: '추천 운동',
          icon: Icons.directions_walk,
          description: info.exercise,
          iconColor: Colors.green,
        ),
        const SizedBox(height: 16),

        // 주의사항
        _InfoCard(
          title: '주의사항',
          icon: Icons.warning_amber_outlined,
          description: info.caution,
          iconColor: Colors.redAccent,
        ),
      ],
    );
  }
}

/// 공통 정보 카드
class _InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const _InfoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// 주차별 데이터 모델
class _WeekInfo {
  final int week;
  final String title;
  final String subtitle;
  final String bodyChange;
  final String exercise;
  final String caution;

  const _WeekInfo({
    required this.week,
    required this.title,
    required this.subtitle,
    required this.bodyChange,
    required this.exercise,
    required this.caution,
  });
}
