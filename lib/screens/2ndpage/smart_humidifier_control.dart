  import 'package:flutter/material.dart';
  import 'package:hive/hive.dart';

  class SmartHumidifierControl extends StatefulWidget {
    const SmartHumidifierControl({super.key});

    @override
    State<SmartHumidifierControl> createState() => _SmartHumidifierControlState();
  }

  class _SmartHumidifierControlState extends State<SmartHumidifierControl> {
    late bool isPowerOn;
    late int mistLevel; // 0=없음, 1=약, 2=중, 3=강
    late int targetHumidity; // 30~70
    late bool comfortCare;
    late bool autoMode;
    late int reservationHour; // 0/3/6
    late bool silentMode;

    @override
    void initState() {
      super.initState();
      final box = Hive.box("routine_settings");

      isPowerOn = box.get("humid_power", defaultValue: true);
      mistLevel = box.get("humid_level", defaultValue: 1);
      targetHumidity = box.get("humid_target", defaultValue: 50);
      comfortCare = box.get("humid_care", defaultValue: false);
      autoMode = box.get("humid_auto", defaultValue: false);
      reservationHour = box.get("humid_reservation", defaultValue: 0);
      silentMode = box.get("humid_silent", defaultValue: false);
    }

    void saveValues() {
      final box = Hive.box("routine_settings");

      box.put("humid_power", isPowerOn);
      box.put("humid_level", mistLevel);
      box.put("humid_target", targetHumidity);
      box.put("humid_care", comfortCare);
      box.put("humid_auto", autoMode);
      box.put("humid_reservation", reservationHour);
      box.put("humid_silent", silentMode);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xffECEFF3),
        appBar: AppBar(
          backgroundColor: const Color(0xffECEFF3),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "가습기",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Column(
          children: [
            const SizedBox(height: 10),
            _buildPowerCard(),
            const SizedBox(height: 20),
            _buildMainSettingBoard(),
            const Spacer(),

            /// 하단 저장 영역
            Row(
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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

    //---------------------------------------------------------------------------
    // ① 전원 On / Off 카드 (사진그대로)
    //---------------------------------------------------------------------------
    Widget _buildPowerCard() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _powerRow("켜기", true),
            Divider(color: Colors.grey.shade300, height: 1),
            _powerRow("끄기", false),
          ],
        ),
      );
    }

    Widget _powerRow(String label, bool value) {
      return GestureDetector(
        onTap: () => setState(() => isPowerOn = value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(
                Icons.check,
                color: isPowerOn == value ? const Color(0xff5667FF) : Colors.transparent,
                size: 26,
              ),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    }

    //---------------------------------------------------------------------------
    // ② 사진 하단 전체 settings UI 블럭
    //---------------------------------------------------------------------------
    Widget _buildMainSettingBoard() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffF7F8FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _wheelCard("세기", mistLevel, ["-", "약", "중", "강"], (v) {
                  mistLevel = v;
                })),
                const SizedBox(width: 10),
                Expanded(child: _wheelCard("희망 습도", targetHumidity, List.generate(9, (i) => "${30 + i * 5}%"),
                        (v) {
                      targetHumidity = 30 + (v * 5);
                    })),
              ],
            ),
            const SizedBox(height: 12),
            _gridOptions(),
          ],
        ),
      );
    }

    //---------------------------------------------------------------------------
    // ③ 세기 / 희망습도 카드 (좌우 버튼)
    //---------------------------------------------------------------------------
    Widget _wheelCard(String title, int current, List<String> options, Function(int) onChange) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleBtn(Icons.chevron_left, () {
                  setState(() {
                    int idx = options.indexOf(title == "세기"
                        ? ["-", "약", "중", "강"][mistLevel]
                        : "${current}%");
                    idx = (idx - 1).clamp(0, options.length - 1);
                    if (title == "세기") mistLevel = idx;
                    else onChange(idx);
                  });
                }),
                Text(
                  title == "세기"
                      ? options[mistLevel]
                      : "$current%",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5667FF),
                  ),
                ),
                _circleBtn(Icons.chevron_right, () {
                  setState(() {
                    int idx = options.indexOf(title == "세기"
                        ? ["-", "약", "중", "강"][mistLevel]
                        : "${current}%");
                    idx = (idx + 1).clamp(0, options.length - 1);
                    if (title == "세기") mistLevel = idx;
                    else onChange(idx);
                  });
                }),
              ],
            ),
          ],
        ),
      );
    }

    Widget _circleBtn(IconData icon, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 17,
          backgroundColor: const Color(0xffE6E8EB),
          child: Icon(icon, color: Colors.black87),
        ),
      );
    }

    //---------------------------------------------------------------------------
    // ④ 아래 3x2 작은 옵션 버튼들
    //---------------------------------------------------------------------------
    Widget _gridOptions() {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
        children: [
          _smallTile(Icons.opacity, comfortCare ? "켜짐" : "꺼짐", "쾌적", comfortCare, () {
            setState(() => comfortCare = !comfortCare);
          }),
          _smallTile(Icons.timer, "${reservationHour == 0 ? "-" : reservationHour}", "예약", reservationHour != 0, () {
            setState(() {
              reservationHour = reservationHour == 0 ? 3 : reservationHour == 3 ? 6 : 0;
            });
          }),
          _smallTile(Icons.nights_stay, silentMode ? "ON" : "OFF", "조용", silentMode, () {
            setState(() => silentMode = !silentMode);
          }),
        ],
      );
    }

    Widget _smallTile(
        IconData icon, String title, String sub, bool active, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active ? const Color(0xffE9F1FF) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: active ? const Color(0xff4DA3FF) : Colors.transparent,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: active ? const Color(0xff4DA3FF) : Colors.grey),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      );
    }
  }
