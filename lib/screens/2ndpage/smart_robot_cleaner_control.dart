import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SmartRobotCleanerControl extends StatefulWidget {
  const SmartRobotCleanerControl({super.key});

  @override
  State<SmartRobotCleanerControl> createState() => _SmartRobotCleanerControlState();
}

class _SmartRobotCleanerControlState extends State<SmartRobotCleanerControl> {
  late String selectedAction; // "clean" or "charge"

  @override
  void initState() {
    super.initState();

    final box = Hive.box("routine_settings");
    selectedAction = box.get("robot_action", defaultValue: "clean");
  }

  void saveValues() {
    final box = Hive.box("routine_settings");
    box.put("robot_action", selectedAction);
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
          "로봇청소기",
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

          _buildActionCard(),

          const Spacer(),

          _buildBottomButtons(),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // ① 상단 카드 UI (청소 시작 / 충전 시작)
  // -------------------------------------------------------------------------
  Widget _buildActionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _actionRow("청소 시작", "clean"),
          Divider(color: Colors.grey.shade300, height: 1),
          _actionRow("충전 시작", "charge"),
        ],
      ),
    );
  }

  Widget _actionRow(String label, String value) {
    return GestureDetector(
      onTap: () => setState(() => selectedAction = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: selectedAction == value
                  ? const Color(0xff5667FF)
                  : Colors.transparent,
              size: 26,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // ② 하단 취소 / 저장 버튼
  // -------------------------------------------------------------------------
  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            margin: const EdgeInsets.only(left: 20, right: 8),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "취소",
                style: TextStyle(
                  color: Color(0xff5667FF),
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
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                saveValues();
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
    );
  }
}
