import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SmartAirCleanerControl extends StatefulWidget {
  const SmartAirCleanerControl({super.key});

  @override
  State<SmartAirCleanerControl> createState() => _SmartAirCleanerControlState();
}

class _SmartAirCleanerControlState extends State<SmartAirCleanerControl> {
  // 상태값
  bool powerOn = true;

  final List<String> levelList = ["약", "보통", "강"];

  int cleanLevelIndex = 1; // 기본: 보통
  int boosterLevelIndex = 0; // 기본: 약

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  /// -------------------------------
  /// 🔵 Hive 저장값 불러오기
  /// -------------------------------
  void _loadSavedValues() {
    final box = Hive.box("routine_settings");

    // power
    String? power = box.get("aircleaner_power");
    if (power != null) {
      powerOn = power == "켜기";
    }

    // 청정 세기
    String? clean = box.get("aircleaner_clean_level");
    if (clean != null) {
      cleanLevelIndex = levelList.indexOf(clean);
      if (cleanLevelIndex == -1) cleanLevelIndex = 1;
    }

    // 부스터 세기
    String? booster = box.get("aircleaner_booster_level");
    if (booster != null) {
      boosterLevelIndex = levelList.indexOf(booster);
      if (boosterLevelIndex == -1) boosterLevelIndex = 0;
    }

    setState(() {});
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
          "공기청정기",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // ----------------------------- 전원 카드 -----------------------------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => powerOn = true),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              color: powerOn
                                  ? const Color(0xff4667FF)
                                  : Colors.transparent),
                          const SizedBox(width: 10),
                          const Text("켜기", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ),

                  Divider(color: Colors.grey.shade300, height: 1),

                  GestureDetector(
                    onTap: () => setState(() => powerOn = false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Row(
                        children: [
                          Icon(Icons.check,
                              color: !powerOn
                                  ? const Color(0xff4667FF)
                                  : Colors.transparent),
                          const SizedBox(width: 10),
                          const Text("끄기", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // ----------------------------- 청정 세기 -----------------------------
            _OptionArrowCard(
              title: "청정 세기",
              value: levelList[cleanLevelIndex],
              onLeftTap: () {
                setState(() {
                  cleanLevelIndex =
                      (cleanLevelIndex - 1 + levelList.length) %
                          levelList.length;
                });
              },
              onRightTap: () {
                setState(() {
                  cleanLevelIndex =
                      (cleanLevelIndex + 1) % levelList.length;
                });
              },
            ),

            const SizedBox(height: 20),

            // ----------------------------- 부스터 세기 -----------------------------
            _OptionArrowCard(
              title: "부스터 세기",
              value: levelList[boosterLevelIndex],
              onLeftTap: () {
                setState(() {
                  boosterLevelIndex =
                      (boosterLevelIndex - 1 + levelList.length) %
                          levelList.length;
                });
              },
              onRightTap: () {
                setState(() {
                  boosterLevelIndex =
                      (boosterLevelIndex + 1) % levelList.length;
                });
              },
            ),

            const Spacer(),

            // ----------------------------- 하단 버튼 -----------------------------
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          color: Color(0xff4667FF),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5667FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final box = Hive.box("routine_settings");

                        await box.put("aircleaner_power",
                            powerOn ? "켜기" : "끄기");
                        await box.put("aircleaner_clean_level",
                            levelList[cleanLevelIndex]);
                        await box.put("aircleaner_booster_level",
                            levelList[boosterLevelIndex]);

                        Navigator.pop(context, true);
                      },
                      child: const Text(
                        "저장",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// 🔵 Arrow Option 공용 위젯
// =======================================================================

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
              radius: 16,
              backgroundColor: Color(0xffE6E8EB),
              child: Icon(Icons.chevron_left, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff4667FF),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onRightTap,
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xffE6E8EB),
              child: Icon(Icons.chevron_right, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
