import 'package:flutter/material.dart';
import '../pregnancy_controller.dart';

/// 나를 위한 가전별 맞춤 루틴 - 상세 설정 화면
class SmartRoutineDetailScreen extends StatelessWidget {
  final PregnancyController controller;

  const SmartRoutineDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final babyName = controller.babyNickname ?? '우리 아기';

    return Scaffold(
      backgroundColor: const Color(0xfffdf5f7),
      body: CustomScrollView(
        slivers: [
          // 상단 앱바
          SliverAppBar(
            title: const Text('맞춤 루틴 상세 설정'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            pinned: true,
            elevation: 0,
          ),

          // 🔥 임산부 일러스트 + 그라데이션 + 텍스트
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // 배경 이미지 변경됨!
                    Image.asset(
                      'assets/images/routine_header.png', // ⬅ 변경 완료!
                      height: 360,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // 아래쪽 어둡게 그라데이션
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.55),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 텍스트(흰 + 그림자)
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: Text(
                        '$babyName 를 위한 가전별 맞춤 루틴',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 아래 상세 카드들
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                const [
                  _AirconDetailCard(),
                  SizedBox(height: 16),
                  _HumidifierDetailCard(),
                  SizedBox(height: 16),
                  _AirCleanerDetailCard(),
                  SizedBox(height: 16),
                  _RobotCleanerDetailCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 에어컨 상세 설정 (온도 슬라이더)
class _AirconDetailCard extends StatefulWidget {
  const _AirconDetailCard();

  @override
  State<_AirconDetailCard> createState() => _AirconDetailCardState();
}

class _AirconDetailCardState extends State<_AirconDetailCard> {
  double _temp = 24;

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      icon: Icons.ac_unit,
      title: '에어컨',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('권장 온도 범위: 24–26℃'),
          const SizedBox(height: 8),
          Text(
            '${_temp.toStringAsFixed(1)}℃',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: _temp,
            min: 18,
            max: 30,
            onChanged: (v) => setState(() => _temp = v),
          ),
        ],
      ),
    );
  }
}

/// 가습기 상세 설정 (습도 슬라이더)
class _HumidifierDetailCard extends StatefulWidget {
  const _HumidifierDetailCard();

  @override
  State<_HumidifierDetailCard> createState() => _HumidifierDetailCardState();
}

class _HumidifierDetailCardState extends State<_HumidifierDetailCard> {
  double _humidity = 50;

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      icon: Icons.grain,
      title: '가습기',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('권장 습도 범위: 40–60%'),
          const SizedBox(height: 8),
          Text(
            '${_humidity.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: _humidity,
            min: 30,
            max: 70,
            onChanged: (v) => setState(() => _humidity = v),
          ),
        ],
      ),
    );
  }
}

/// 공기청정기 상세 설정 (강도 단계)
class _AirCleanerDetailCard extends StatefulWidget {
  const _AirCleanerDetailCard();

  @override
  State<_AirCleanerDetailCard> createState() => _AirCleanerDetailCardState();
}

class _AirCleanerDetailCardState extends State<_AirCleanerDetailCard> {
  String _mode = '표준';

  final List<String> _modes = ['저속', '표준', '강풍', '취침'];

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      icon: Icons.air,
      title: '공기청정기',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('동작 모드'),
          DropdownButton<String>(
            value: _mode,
            items: _modes
                .map((m) => DropdownMenuItem(
              value: m,
              child: Text(m),
            ))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _mode = v);
            },
          ),
        ],
      ),
    );
  }
}

/// 로봇청소기 상세 설정 (시간 설정)
class _RobotCleanerDetailCard extends StatefulWidget {
  const _RobotCleanerDetailCard();

  @override
  State<_RobotCleanerDetailCard> createState() =>
      _RobotCleanerDetailCardState();
}

class _RobotCleanerDetailCardState extends State<_RobotCleanerDetailCard> {
  TimeOfDay _morningTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _eveningTime = const TimeOfDay(hour: 17, minute: 0);

  Future<void> _pickTime(bool isMorning) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isMorning ? _morningTime : _eveningTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isMorning) {
          _morningTime = picked;
        } else {
          _eveningTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String format(TimeOfDay t) =>
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

    return _DetailCard(
      icon: Icons.cleaning_services_outlined,
      title: '로봇청소기',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('하루 두 번 자동 청소 시간'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => _pickTime(true),
                icon: const Icon(Icons.wb_sunny_outlined),
                label: Text('오전 ${format(_morningTime)}'),
              ),
              TextButton.icon(
                onPressed: () => _pickTime(false),
                icon: const Icon(Icons.nights_stay_outlined),
                label: Text('오후 ${format(_eveningTime)}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 공통 카드 UI
class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.child,
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
              Icon(icon),
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
