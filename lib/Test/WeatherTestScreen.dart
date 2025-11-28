import 'package:flutter/material.dart';
import '../services/change_latitude.dart';  // getWeather 가져오기!

class WeatherTestScreen extends StatefulWidget {
  @override
  _WeatherTestScreenState createState() => _WeatherTestScreenState();
}

class _WeatherTestScreenState extends State<WeatherTestScreen> {
  String result = "날씨 정보를 확인하려면 버튼을 누르세요!";

  Future<void> checkWeather() async {
    setState(() {
      result = "불러오는 중...";
    });

    try {
      final data = await getTodayWeather();
      setState(() {
        result = data.entries
            .map((e) => "${e.key}: ${e.value}")
            .join("\n");
      });
    } catch (e) {
      setState(() {
        result = "오류 발생: $e";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("날씨 테스트"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: checkWeather,
            child: Text("날씨 가져오기"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(result),
            ),
          )
        ],
      ),
    );
  }
}
