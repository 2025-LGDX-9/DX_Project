import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class InnerTemper extends StatefulWidget {
  const InnerTemper({super.key});

  @override
  State<InnerTemper> createState() => _InnerTemperState();
}

class _InnerTemperState extends State<InnerTemper> {
  int currentTemp = 26; // 선택된 온도
  bool isAbove = true;  // true = 이상이면, false = 이하면

  FixedExtentScrollController wheelController =
  FixedExtentScrollController(initialItem: 26 - 16); // 온도 범위 16~30

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  void _loadSavedValues() {
    final box = Hive.box("routine_settings");

    // 온도 로딩
    int? savedTemp = box.get("innerTempValue");
    if (savedTemp != null) {
      currentTemp = savedTemp;
    }

    // 조건 로딩
    String? savedCondition = box.get("innerTempCondition");
    if (savedCondition != null) {
      isAbove = (savedCondition == "이상이면");
    }

    // 스크롤 위치를 저장된 온도에 맞게 이동
    wheelController = FixedExtentScrollController(initialItem: currentTemp - 16);

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
          "실내 온도",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // ★ 중앙 흰색 카드
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
                // 왼쪽 온도 선택 영역 (스크롤 다이얼)
                Column(
                  children: [
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
                            currentTemp = 16 + index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            int value = 16 + index;

                            // 다이얼 선택된 값 강조
                            bool selected = value == currentTemp;

                            return Opacity(
                              opacity: selected ? 1.0 : 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$value",
                                    style: TextStyle(
                                      fontSize: selected ? 32 : 26,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "℃",
                                    style: TextStyle(
                                      fontSize: selected ? 18 : 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: 15, // 16~30도 → 15개
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 40),

                // 오른쪽 조건 "이상이면 / 이하면"
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isAbove = true),
                      child: Text(
                        "이상이면",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isAbove ? FontWeight.w700 : FontWeight.w400,
                          color: isAbove ? Colors.black : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () => setState(() => isAbove = false),
                      child: Text(
                        "이하면",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isAbove ? FontWeight.w400 : FontWeight.w700,
                          color: isAbove ? Colors.grey.shade400 : Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const Spacer(),

          // ★ 하단 버튼 영역
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
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
                        color: Color(0xFF4667FF),
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
                  margin: const EdgeInsets.only(right: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4667FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final box = Hive.box("routine_settings");
                      await box.put("innerTempValue", currentTemp);
                      await box.put(
                        "innerTempCondition",
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
