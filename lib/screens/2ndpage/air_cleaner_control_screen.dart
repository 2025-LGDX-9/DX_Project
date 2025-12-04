import 'package:flutter/material.dart';
import '../../pregnancy_controller.dart';

/// 공기청정기 제어 화면
class AirCleanerControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const AirCleanerControlScreen({super.key, required this.controller});

  @override
  State<AirCleanerControlScreen> createState() =>
      _AirCleanerControlScreenState();
}

class _AirCleanerControlScreenState extends State<AirCleanerControlScreen> {
  late bool powerOn;
  late int cleanLevel;
  late int boosterLevel;
  late bool aiMode;
  late bool smartCare;

  @override
  void initState() {
    super.initState();

    widget.controller.loadAllDeviceSettings();

    // Controller 값 로드
    powerOn = widget.controller.airCleanerPowerOn;
    cleanLevel = widget.controller.airCleanerCleanLevel;
    boosterLevel = widget.controller.airCleanerBoosterLevel;
    aiMode = widget.controller.airCleanerAiMode;
    smartCare = widget.controller.airCleanerSmartCare;
  }

  void _saveToController() {
    final c = widget.controller;

    c.airCleanerPowerOn = powerOn;
    c.airCleanerCleanLevel = cleanLevel;
    c.airCleanerBoosterLevel = boosterLevel;
    c.airCleanerAiMode = aiMode;
    c.airCleanerSmartCare = smartCare;

    c.saveAllDeviceSettings();
  }

  String _levelText(int level) {
    switch (level) {
      case 0:
        return '약';
      case 1:
        return '보통';
      case 2:
        return '강';
      default:
        return '약';
    }
  }

  void _changeLevel(bool isClean, int delta) {
    setState(() {
      if (isClean) {
        cleanLevel = (cleanLevel + delta).clamp(0, 2);
      } else {
        boosterLevel = (boosterLevel + delta).clamp(0, 2);
      }
      _saveToController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8f4ff),
      appBar: AppBar(
        title: const Text('공기청정기'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 상단 공기청정기 이미지/상태 영역
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffe8f4ff), Color(0xfffdfdfd)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.air,
                    size: 90,
                    color: Color(0xff4a90e2),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '종합환경도 보통',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '실내 공기질 · 냄새 · 먼지를 종합적으로 케어합니다.',
                    style: TextStyle(color: Colors.grey.shade700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // 전원 버튼
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        powerOn = !powerOn;
                        _saveToController();
                      });
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: powerOn
                            ? const Color(0xff4a90e2)
                            : Colors.grey.shade300,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (powerOn)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    powerOn ? '전원 켜짐' : '전원 꺼짐',
                    style: TextStyle(
                      color: powerOn ? Colors.blueGrey : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 하단 제어 박스
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 클린부스터 영역 제목
                  const Text(
                    '클린부스터',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _modeControlCard(
                          title: '청정 세기',
                          levelText: _levelText(cleanLevel),
                          onDecrease: () => _changeLevel(true, -1),
                          onIncrease: () => _changeLevel(true, 1),
                          icon: Icons.toys,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _modeControlCard(
                          title: '부스터 세기',
                          levelText: _levelText(boosterLevel),
                          onDecrease: () => _changeLevel(false, -1),
                          onIncrease: () => _changeLevel(false, 1),
                          icon: Icons.bubble_chart,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 회전 안내
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xffe6f3ff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.sync_alt, color: Color(0xff4a90e2)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '부스터 회전: 상단 켜짐, 하단 꺼짐',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // AI 모드
                  _toggleRow(
                    title: '인공지능+',
                    subtitle: '실내 공기질이 좋을 때 절전 운전해요.',
                    value: aiMode,
                    onChanged: (v) {
                      setState(() {
                        aiMode = v;
                        _saveToController();
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // 스마트케어
                  _toggleRow(
                    title: '스마트케어',
                    subtitle: '사용환경과 방식에 맞춰 제품 운전해요.',
                    value: smartCare,
                    onChanged: (v) {
                      setState(() {
                        smartCare = v;
                        _saveToController();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeControlCard({
    required String title,
    required String levelText,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff6f8ff),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xff4a90e2)),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _roundIconButton(icon: Icons.chevron_left, onTap: onDecrease),
              Text(
                levelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _roundIconButton(icon: Icons.chevron_right, onTap: onIncrease),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xff4a90e2),
        ),
      ),
    );
  }

  Widget _toggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xff4a90e2),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
