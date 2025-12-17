import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InnerHumidity extends StatefulWidget {
  const InnerHumidity({super.key});

  @override
  State<InnerHumidity> createState() => _InnerHumidityState();
}

class _InnerHumidityState extends State<InnerHumidity> {
  int currentHumidity = 60; // 선택 습도
  bool isAbove = false;     // false = 이하면, true = 이상이면

  late FixedExtentScrollController wheelController;

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  /// ---------------------------------------------------
  /// 🔵 Hive 저장값 불러오기
  /// ---------------------------------------------------
  void _loadSavedValues() {
    final box = Hive.box("routine_settings");

    int savedValue = box.get("humidity_value", defaultValue: 60);
    String savedCond = box.get("humidity_condition", defaultValue: "이하면");

    currentHumidity = savedValue;
    isAbove = savedCond == "이상이면";

    wheelController = FixedExtentScrollController(
        initialItem: (currentHumidity - 40) ~/ 5);

    setState(() {});
  }

  @override
  void dispose() {
    wheelController.dispose();
    super.dispose();
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
          "실내 습도",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // ===================== 흰 카드 영역 =====================
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ===================== 왼쪽 습도 휠 =====================
                SizedBox(
                  height: 130,
                  width: 80,
                  child: ListWheelScrollView.useDelegate(
                    controller: wheelController,
                    physics: const FixedExtentScrollPhysics(),
                    itemExtent: 40,
                    diameterRatio: 1.6,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        currentHumidity = 40 + index * 5;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 21, // 40~140까지 5단위 (원하면 40~90만 사용해도 됨)
                      builder: (context, index) {
                        int value = 40 + index * 5;
                        bool selected = value == currentHumidity;

                        return Opacity(
                          opacity: selected ? 1.0 : 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$value",
                                style: TextStyle(
                                  fontSize: selected ? 32 : 26,
                                  fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "%",
                                style: TextStyle(
                                  fontSize: selected ? 18 : 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 40),

                // ===================== 오른쪽 조건 =====================
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isAbove = true),
                      child: Text(
                        "이상이면",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                          isAbove ? FontWeight.w700 : FontWeight.w400,
                          color: isAbove ? Colors.black : Colors.grey.shade400,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    GestureDetector(
                      onTap: () => setState(() => isAbove = false),
                      child: Text(
                        "이하면",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                          !isAbove ? FontWeight.w700 : FontWeight.w400,
                          color: !isAbove ? Colors.black : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // ===================== 버튼 영역 =====================
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  margin: const EdgeInsets.only(left: 20, right: 8),
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

              Expanded(
                child: Container(
                  height: 55,
                  margin: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5667FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    /// ---------------------------
                    /// 🔵 저장 버튼 → Hive Save
                    /// ---------------------------
                    onPressed: () async {
                      final box = Hive.box("routine_settings");

                      await box.put("humidity_value", currentHumidity);
                      await box.put(
                        "humidity_condition",
                        isAbove ? "이상이면" : "이하면",
                      );

                      Navigator.pop(context, true);
                    },

                    child: const Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
