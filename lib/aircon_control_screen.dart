import 'package:flutter/material.dart';
import 'pregnancy_controller.dart';

class AirconControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const AirconControlScreen({super.key, required this.controller});

  @override
  State<AirconControlScreen> createState() => _AirconControlScreenState();
}

class _AirconControlScreenState extends State<AirconControlScreen> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        title: const Text('에어컨 제어'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AirconTopSection(controller: c),
          const SizedBox(height: 24),
          _PowerToggle(controller: c),
          const SizedBox(height: 24),
          _TemperatureControl(controller: c),
          const SizedBox(height: 24),
          _ModeSelector(controller: c),
          const SizedBox(height: 24),
          _FanSpeedSelector(controller: c),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////
// 🔵 상단 에어컨 이미지 + 현재 온도 표시
//////////////////////////////////////////////
class _AirconTopSection extends StatelessWidget {
  final PregnancyController controller;

  const _AirconTopSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 에어컨 이미지 (넣을 이미지가 없으면 아이콘으로 표시)
        SizedBox(
          height: 160,
          child: Image.asset(
            'assets/images/aircon.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${controller.airconTargetTemp.toStringAsFixed(1)}°C',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '설정 온도',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////
// 🔵 전원 ON/OFF
//////////////////////////////////////////////
class _PowerToggle extends StatefulWidget {
  final PregnancyController controller;

  const _PowerToggle({required this.controller});

  @override
  State<_PowerToggle> createState() => _PowerToggleState();
}

class _PowerToggleState extends State<_PowerToggle> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return _Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '전원',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: c.airconOn,
            onChanged: (v) {
              setState(() => c.airconOn = v);
            },
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////
// 🔵 온도 슬라이더 조절
//////////////////////////////////////////////
class _TemperatureControl extends StatefulWidget {
  final PregnancyController controller;

  const _TemperatureControl({required this.controller});

  @override
  State<_TemperatureControl> createState() => _TemperatureControlState();
}

class _TemperatureControlState extends State<_TemperatureControl> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '온도 설정',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '${c.airconTargetTemp.toStringAsFixed(1)}°C',
            style: const TextStyle(fontSize: 18),
          ),
          Slider(
            value: c.airconTargetTemp,
            min: 16,
            max: 30,
            onChanged: (v) {
              setState(() => c.airconTargetTemp = v);
            },
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////
// 🔵 운전 모드 선택 (냉방/제습/송풍/자동)
//////////////////////////////////////////////
class _ModeSelector extends StatefulWidget {
  final PregnancyController controller;

  const _ModeSelector({required this.controller});

  @override
  State<_ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<_ModeSelector> {
  final List<String> modes = ['냉방', '제습', '송풍', '자동'];

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '운전 모드',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: modes.map((m) {
              final selected = (m == c.airconMode);
              return ChoiceChip(
                selected: selected,
                label: Text(m),
                selectedColor: const Color(0xff7b61ff),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                ),
                onSelected: (_) {
                  setState(() => c.airconMode = m);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////
// 🔵 풍량 설정 (1~3)
//////////////////////////////////////////////
class _FanSpeedSelector extends StatefulWidget {
  final PregnancyController controller;

  const _FanSpeedSelector({required this.controller});

  @override
  State<_FanSpeedSelector> createState() => _FanSpeedSelectorState();
}

class _FanSpeedSelectorState extends State<_FanSpeedSelector> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '풍량',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [1, 2, 3].map((level) {
              final selected = (c.airconFanLevel == level);
              return GestureDetector(
                onTap: () => setState(() => c.airconFanLevel = level),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                    selected ? const Color(0xff7b61ff) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$level 단계',
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////
// 🔵 공통 카드 위젯
//////////////////////////////////////////////
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
