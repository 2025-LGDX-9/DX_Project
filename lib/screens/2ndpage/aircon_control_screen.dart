import 'package:flutter/material.dart';
import '../../pregnancy_controller.dart';

class AirconControlScreen extends StatefulWidget {
  final PregnancyController controller;

  const AirconControlScreen({super.key, required this.controller});

  @override
  State<AirconControlScreen> createState() => _AirconControlScreenState();
}

class _AirconControlScreenState extends State<AirconControlScreen> {
  late bool airconOn;
  late double targetTemp;
  late bool sleepMode;
  late String windStrength;
  late String windDirection;

  @override
  void initState() {
    super.initState();

    // Controller → 화면 변수 로드
    airconOn = widget.controller.airconOn;
    targetTemp = widget.controller.airconTargetTemp;
    sleepMode = widget.controller.airconSleepMode;
    windStrength = widget.controller.airconWindStrength;
    windDirection = widget.controller.airconWindDirection;
  }

  /// 변경 사항을 PregnancyController + Hive 저장
  void _saveToController() {
    final c = widget.controller;

    c.airconOn = airconOn;
    c.airconTargetTemp = targetTemp;
    c.airconSleepMode = sleepMode;
    c.airconWindStrength = windStrength;
    c.airconWindDirection = windDirection;

    c.saveAllDeviceSettings(); // Hive 저장
  }

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
          _AirconTopSection(
            controller: c,
            powerOn: airconOn,
            onTogglePower: () {
              setState(() {
                airconOn = !airconOn;
                _saveToController();
              });
            },
          ),

          const SizedBox(height: 60),

          _CoolingSection(controller: c),
          const SizedBox(height: 16),

          _TemperatureCard(
            temp: targetTemp,
            onChange: (v) {
              setState(() {
                targetTemp = v;
                _saveToController();
              });
            },
          ),

          const SizedBox(height: 16),

          _WindOptions(
            windStrength: windStrength,
            windDirection: windDirection,
            onStrengthChange: (v) {
              setState(() {
                windStrength = v;
                _saveToController();
              });
            },
            onDirectionChange: (v) {
              setState(() {
                windDirection = v;
                _saveToController();
              });
            },
          ),
          const SizedBox(height: 16),

          _ReservationCard(),
          const SizedBox(height: 12),

          _TropicalNightCard(
            sleepMode: sleepMode,
            onToggle: (v) {
              setState(() {
                sleepMode = v;
                _saveToController();
              });
            },
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// TOP SECTION (이미지 + 상태 + 전원)
/////////////////////////////////////////////////////////////////

class _AirconTopSection extends StatelessWidget {
  final PregnancyController controller;
  final bool powerOn;
  final VoidCallback onTogglePower;

  const _AirconTopSection({
    required this.controller,
    required this.powerOn,
    required this.onTogglePower,
  });

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.thermostat, size: 18, color: Colors.black87),
                  Text(" 28°C   ", style: TextStyle(fontSize: 14)),
                  Icon(Icons.water_drop, size: 16, color: Colors.black87),
                  Text(" 30%", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("종합청정도  ", style: TextStyle(color: Colors.black)),
                  Icon(Icons.circle, size: 10, color: Colors.lightBlueAccent),
                  Text("  좋음", style: TextStyle(color: Colors.black)),
                  Icon(Icons.chevron_right, size: 16)
                ],
              ),
            ],
          ),

          Positioned(
            bottom: -30,
            right: 16,
            child: GestureDetector(
              onTap: onTogglePower,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: powerOn ? const Color(0xff19c3e6) : Colors.grey.shade300,
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
                  color: powerOn ? Colors.white : Colors.black45,
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
// 냉방 ↓
/////////////////////////////////////////////////////////////////

class _CoolingSection extends StatelessWidget {
  final PregnancyController controller;

  const _CoolingSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          "냉방",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////
// 온도 조절
/////////////////////////////////////////////////////////////////

class _TemperatureCard extends StatelessWidget {
  final double temp;
  final ValueChanged<double> onChange;

  const _TemperatureCard({required this.temp, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardStyle(),
      child: Column(
        children: [
          Text("희망 온도", style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tempButton("-", () => onChange(temp - 1)),
              const SizedBox(width: 20),

              Text(
                "${temp.toStringAsFixed(0)}°C",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 20),
              _tempButton("+", () => onChange(temp + 1)),
            ],
          ),

          Slider(
            min: 16,
            max: 30,
            value: temp,
            activeColor: const Color(0xff19c3e6),
            onChanged: onChange,
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
// 바람세기 / 바람방향 (현재 UI용 – DB 저장 항목 아님)
/////////////////////////////////////////////////////////////////

class _WindOptions extends StatelessWidget {
  final String windStrength;
  final String windDirection;
  final ValueChanged<String> onStrengthChange;
  final ValueChanged<String> onDirectionChange;

  const _WindOptions({
    required this.windStrength,
    required this.windDirection,
    required this.onStrengthChange,
    required this.onDirectionChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _windCell(
            Icons.toys,
            "바람세기",
            windStrength,
            ["약풍", "보통", "강풍"],
            onStrengthChange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _windCell(
            Icons.air,
            "바람방향",
            windDirection,
            ["와이드", "집중", "분리", "좌", "우"],
            onDirectionChange,
          ),
        ),
      ],
    );
  }

  Widget _windCell(
      IconData icon,
      String title,
      String value,
      List<String> options,
      ValueChanged<String> onChanged,
      ) {
    int currentIndex = options.indexOf(value);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardStyle(),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blue.shade300),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          /// 🔥 여기만 추가된 부분 (좌/우 화살표)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _arrowButton(Icons.chevron_left, () {
                int next = (currentIndex - 1 + options.length) % options.length;
                onChanged(options[next]);
              }),
              const SizedBox(width: 20),
              _arrowButton(Icons.chevron_right, () {
                int next = (currentIndex + 1) % options.length;
                onChanged(options[next]);
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24, color: Colors.grey),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 예약 (아직 기능 없음)
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
// 취침모드 스위치
/////////////////////////////////////////////////////////////////

class _TropicalNightCard extends StatelessWidget {
  final bool sleepMode;
  final ValueChanged<bool> onToggle;

  const _TropicalNightCard({
    required this.sleepMode,
    required this.onToggle,
  });

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
            value: sleepMode,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////
// 카드는 공용 스타일
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
