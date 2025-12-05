import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SmartAirconControl extends StatefulWidget {
  const SmartAirconControl({super.key});

  @override
  State<SmartAirconControl> createState() => _SmartAirconControlState();
}

class _SmartAirconControlState extends State<SmartAirconControl> {
  bool powerOn = true;

  List<String> windStrengthList = ["약", "보통", "강"];
  int windStrengthIndex = 0;

  List<String> windDirectionList = ["집중", "와이드", "분리", "좌", "우"];
  int windDirectionIndex = 0;

  double targetTemp = 28;

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  void _loadSavedValues() {
    final box = Hive.box("routine_settings");

    // 켜기/끄기
    String? power = box.get("aircon_power");
    if (power != null) {
      powerOn = (power == "켜기");
    }

    // 바람 세기
    String? windStrength = box.get("aircon_wind_strength");
    if (windStrength != null) {
      windStrengthIndex = windStrengthList.indexOf(windStrength);
    }

    // 바람 방향
    String? windDirection = box.get("aircon_wind_direction");
    if (windDirection != null) {
      windDirectionIndex = windDirectionList.indexOf(windDirection);
    }

    // 희망 온도
    int? temp = box.get("aircon_target_temp");
    if (temp != null) {
      targetTemp = temp.toDouble();
    }

    setState(() {}); // UI 업데이트
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECEEF1),

      appBar: AppBar(
        backgroundColor: const Color(0xffECEEF1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "에어컨",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ------------------ 켜기/끄기 카드 ------------------
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => powerOn = true),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                          color: powerOn ? const Color(0xff4667FF) : Colors.transparent,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text("켜기",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: powerOn ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300, height: 1),
                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => setState(() => powerOn = false),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                          color: !powerOn ? const Color(0xff4667FF) : Colors.transparent,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text("끄기",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: !powerOn ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ------------------ 바람 세기 ------------------
            _OptionArrowCard(
              title: "바람 세기",
              value: windStrengthList[windStrengthIndex],
              onLeftTap: () {
                setState(() {
                  windStrengthIndex =
                      (windStrengthIndex - 1 + windStrengthList.length) %
                          windStrengthList.length;
                });
              },
              onRightTap: () {
                setState(() {
                  windStrengthIndex =
                      (windStrengthIndex + 1) % windStrengthList.length;
                });
              },
            ),

            const SizedBox(height: 20),

            // ------------------ 바람 방향 ------------------
            _OptionArrowCard(
              title: "바람 방향",
              value: windDirectionList[windDirectionIndex],
              onLeftTap: () {
                setState(() {
                  windDirectionIndex =
                      (windDirectionIndex - 1 + windDirectionList.length) %
                          windDirectionList.length;
                });
              },
              onRightTap: () {
                setState(() {
                  windDirectionIndex =
                      (windDirectionIndex + 1) % windDirectionList.length;
                });
              },
            ),

            const SizedBox(height: 30),

            // ------------------ 희망 온도 ------------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const Text("희망 온도",
                      style: TextStyle(fontSize: 14, color: Colors.black54)),

                  const SizedBox(height: 10),

                  Text("${targetTemp.toStringAsFixed(0)}°C",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _roundBtn(
                        icon: Icons.remove,
                        onTap: () {
                          setState(() {
                            targetTemp = (targetTemp - 1).clamp(16, 30);
                          });
                        },
                      ),
                      const SizedBox(width: 20),

                      Expanded(
                        child: Slider(
                          value: targetTemp,
                          min: 16,
                          max: 30,
                          activeColor: const Color(0xff1E88E5),
                          onChanged: (v) => setState(() => targetTemp = v),
                        ),
                      ),

                      const SizedBox(width: 20),

                      _roundBtn(
                        icon: Icons.add,
                        onTap: () {
                          setState(() {
                            targetTemp = (targetTemp + 1).clamp(16, 30);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ------------------ 하단 저장 버튼 ------------------
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.only(right: 6),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("취소",
                        style: TextStyle(
                            color: Color(0xff4667FF),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4667FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final box = Hive.box("routine_settings");

                        await box.put("aircon_power", powerOn ? "켜기" : "끄기");
                        await box.put("aircon_wind_strength",
                            windStrengthList[windStrengthIndex]);
                        await box.put("aircon_wind_direction",
                            windDirectionList[windDirectionIndex]);
                        await box.put("aircon_target_temp",
                            targetTemp.toInt());

                        Navigator.pop(context, true);
                      },
                      child: const Text("저장",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }
}

class _OptionArrowCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const _OptionArrowCard({
    required this.title,
    required this.value,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onLeftTap,
            child: const CircleAvatar(
              backgroundColor: Color(0xffE6E8EB),
              child: Icon(Icons.chevron_left, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff4667FF),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onRightTap,
            child: const CircleAvatar(
              backgroundColor: Color(0xffE6E8EB),
              child: Icon(Icons.chevron_right, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
