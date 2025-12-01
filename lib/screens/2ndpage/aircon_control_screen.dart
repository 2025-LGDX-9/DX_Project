import 'package:flutter/material.dart';
import '../../pregnancy_controller.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("에어컨"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _AirconTopSection(controller: c), // 이미지 + 상태정보 + 전원버튼
          const SizedBox(height: 60),

          _CoolingSection(controller: c),   // 냉방/난방 모드
          const SizedBox(height: 16),

          _TemperatureCard(controller: c),  // 온도조절 UI
          const SizedBox(height: 16),

          _WindOptions(controller: c),      // 바람세기 + 바람방향
          const SizedBox(height: 16),

          _ReservationCard(),               // 예약
          const SizedBox(height: 12),

          _TropicalNightCard(controller: c) // 열대야/취침
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 상단 UI (이미지 + 현재온도 + 상태 + 전원버튼) ★ LG ThinQ 1:1 복제
/////////////////////////////////////////////////////////////////
class _AirconTopSection extends StatelessWidget {
  final PregnancyController controller;

  const _AirconTopSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: 140,
                child: Image.asset(
                  "assets/images/aircon.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),

              // 현재온도(실내)+습도는 필요 시 추가 가능
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.thermostat, size: 18, color: Colors.black87),
                  Text(" 28°C   ", style: TextStyle(fontSize: 14)),
                  Icon(Icons.water_drop, size: 16, color: Colors.black87),
                  Text(" 30%", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),

              // 공기정보
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("종합청정도  ", style: TextStyle(color: Colors.black)),
                  Icon(Icons.circle, size: 10, color: Colors.lightBlueAccent),
                  Text("  좋음", style: TextStyle(color: Colors.black)),
                  Icon(Icons.chevron_right, size: 16)
                ],
              ),
            ],
          ),

          // 🔵 우하단 전원버튼 (ThinQ와 동일한 위치/디자인)
          Positioned(
            bottom: -30,
            right: 16,
            child: GestureDetector(
              onTap: () {
                controller.airconOn = !controller.airconOn;
                (context as Element).markNeedsBuild();
              },
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: controller.airconOn
                      ? const Color(0xff19c3e6)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Icon(
                  Icons.power_settings_new,
                  size: 35,
                  color: controller.airconOn ? Colors.white : Colors.black45,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 "냉방 ↓" 섹션 (상단 타이틀) – LG 동일
/////////////////////////////////////////////////////////////////
class _CoolingSection extends StatelessWidget {
  final PregnancyController controller;

  const _CoolingSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "냉방",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 온도 조절 카드
/////////////////////////////////////////////////////////////////
class _TemperatureCard extends StatefulWidget {
  final PregnancyController controller;

  const _TemperatureCard({required this.controller});

  @override
  State<_TemperatureCard> createState() => _TemperatureCardState();
}

class _TemperatureCardState extends State<_TemperatureCard> {
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("희망 온도", style: TextStyle(color: Colors.grey.shade600)),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tempButton("-", () {
                setState(() => c.airconTargetTemp -= 1);
              }),

              SizedBox(width: 20),

              Text(
                "${c.airconTargetTemp.toStringAsFixed(0)}°C",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(width: 20),

              _tempButton("+", () {
                setState(() => c.airconTargetTemp += 1);
              }),
            ],
          ),

          Slider(
            min: 16,
            max: 30,
            value: c.airconTargetTemp,
            activeColor: const Color(0xff19c3e6),
            onChanged: (v) {
              setState(() => c.airconTargetTemp = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _tempButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffe8eef3),
          shape: BoxShape.circle,
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 22, color: Colors.black)),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 바람세기/바람방향 UI
/////////////////////////////////////////////////////////////////
class _WindOptions extends StatelessWidget {
  final PregnancyController controller;
  const _WindOptions({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _windCell(Icons.toys, "바람세기", "약풍")),
        const SizedBox(width: 12),
        Expanded(child: _windCell(Icons.air, "바람방향", "집중")),
      ],
    );
  }

  Widget _windCell(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardStyle(),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blue.shade300),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 예약 카드
/////////////////////////////////////////////////////////////////
class _ReservationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("예약", style: TextStyle(fontSize: 16)),
          Icon(Icons.chevron_right, color: Colors.black45)
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 🔵 열대야/취침 + 스위치
/////////////////////////////////////////////////////////////////
class _TropicalNightCard extends StatefulWidget {
  final PregnancyController controller;
  const _TropicalNightCard({required this.controller});

  @override
  State<_TropicalNightCard> createState() => _TropicalNightCardState();
}

class _TropicalNightCardState extends State<_TropicalNightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.bedtime, color: Colors.orange),
              SizedBox(width: 12),
              Text("열대야/취침", style: TextStyle(fontSize: 16)),
            ],
          ),
          Switch(
            value: widget.controller.airconSleepMode,
            onChanged: (v) {
              setState(() => widget.controller.airconSleepMode = v);
            },
          )
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 공용 카드 스타일
/////////////////////////////////////////////////////////////////
BoxDecoration _cardStyle() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ],
  );
}
