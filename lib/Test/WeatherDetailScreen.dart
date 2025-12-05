import 'package:flutter/material.dart';
import '../services/change_latitude.dart';
import 'get_address.dart';

class WeatherDetailScreen extends StatefulWidget {
  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}


class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  bool loading = true;

  Map<String, dynamic>? currentWeather;
  List<Map<String, dynamic>> hourlyWeather = [];

  @override
  void initState() {
    super.initState();
    loadWeather();
  }
  String? myLocationName;

  Future<void> loadWeather() async {
    setState(() => loading = true);

    try {
      myLocationName = await getCurrentAddress();

      List<Map<String, dynamic>> todayList = await getTodayHourlyWeather();

      final now = DateTime.now();
      final currentTime = int.parse("${now.hour.toString().padLeft(2, '0')}00");

      //  1) 현재 날씨(현재 시각과 가장 가까운 fcst 데이터)
      Map<String, dynamic>? current;
      int minGap = 999;

      for (var data in todayList) {
        int t = int.parse(data["time"]);
        int gap = (t - currentTime).abs();
        if (gap < minGap) {
          minGap = gap;
          current = data;
        }
      }
      currentWeather = current;

      if (current != null) {
        current["SKY_TEXT"] = {
          "1": "맑음",
          "3": "구름많음",
          "4": "흐림",
        }[current["SKY"]] ?? "알수없음";
      }

      //  2) 이후 시간대만 필터링
      hourlyWeather = todayList
          .where((d) => int.parse(d["time"]) >= currentTime)
          .toList();
    } catch (e) {
      print("❌ 오류: $e");
    }

    setState(() => loading = false);
  }

  Widget buildWeatherRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(width: 10),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18))
        ],
      ),
    );
  }

  Widget buildHourlyCard(Map<String, dynamic> data) {
    String skyText = {
      "1": "맑음",
      "3": "구름많음",
      "4": "흐림",
    }[data["SKY"]] ?? "알수없음";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E2A47),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${data["time"].substring(0, 2)}시",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("기온: ${data["TMP"]}°C", style: TextStyle(color: Colors.white)),
              Text("하늘: $skyText", style: TextStyle(color: Colors.white)),
              Text("강수확률: ${data["POP"]}%", style: TextStyle(color: Colors.white)),
              Text("습도: ${data["REH"]}%", style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1A3A),
      appBar: AppBar(
        title: Text("현재 위치 날씨",style: TextStyle(color : Colors.white)),
        backgroundColor: Color(0xFF0D1A3A),

        iconTheme: IconThemeData(
          color: Colors.white,   // 뒤로가기 버튼(화살표) 색상
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ 현재 날씨 박스
            if (currentWeather != null)
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF253357),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (myLocationName != null && myLocationName!.trim().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "$myLocationName 의 날씨입니다.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(height: 12),
                    buildWeatherRow("기온", "${currentWeather!["TMP"]}°C"),
                    buildWeatherRow("습도", "${currentWeather!["REH"]}%"),
                    buildWeatherRow("강수확률", "${currentWeather!["POP"]}%"),
                    buildWeatherRow("하늘상태", "${currentWeather!["SKY_TEXT"]}"),
                  ],
                ),
              ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("시간별 예보",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),

            // ⭐ 이후 시간대 리스트
            Column(
              children: hourlyWeather
                  .map((w) => buildHourlyCard(w))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
