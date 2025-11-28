import 'dart:convert';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Weather_map_xy {
  int x;
  int y;
  Weather_map_xy(this.x, this.y);
}

class lamc_parameter {
  double Re; /* 사용할 지구반경 [ km ]      */
  double grid; /* 격자간격        [ km ]      */
  double slat1; /* 표준위도        [degree]    */
  double slat2; /* 표준위도        [degree]    */
  double olon; /* 기준점의 경도   [degree]    */
  double olat; /* 기준점의 위도   [degree]    */
  double xo; /* 기준점의 X 좌표  [격자거리]  */
  double yo; /* 기준점의 Y 좌표  [격자거리]  */
  int first; /* 시작여부 (0 = 시작)         */
  lamc_parameter({
    this.Re = 6371.00877,
    this.grid = 5.0,
    this.slat1 = 30.0,
    this.slat2 = 60.0,
    this.olon = 126.0,
    this.olat = 38.0,
    this.xo = 210 / 5.0,
    this.yo = 675 / 5.0,
    this.first = 0,
  });
}

class WeatherXYConverter {
  static Weather_map_xy toGrid(double lon, double lat) {
    double PI = 3.1415926535897931;
    double DEGRAD = PI / 180.0;

    lamc_parameter map = lamc_parameter();
    double re = map.Re / map.grid;

    double slat1 = map.slat1 * DEGRAD;
    double slat2 = map.slat2 * DEGRAD;
    double olon = map.olon * DEGRAD;
    double olat = map.olat * DEGRAD;

    double sn = tan(PI * 0.25 + slat2 * 0.5) /
        tan(PI * 0.25 + slat1 * 0.5);
    sn = log(cos(slat1) / cos(slat2)) / log(sn);

    double sf = tan(PI * 0.25 + slat1 * 0.5);
    sf = pow(sf, sn) * cos(slat1) / sn;

    double ro = tan(PI * 0.25 + olat * 0.5);
    ro = re * sf / pow(ro, sn);

    // 🔥 실제 변환
    double ra = tan(PI * 0.25 + lat * DEGRAD * 0.5);
    ra = re * sf / pow(ra, sn);

    double theta = lon * DEGRAD - olon;
    if (theta > PI) theta -= 2.0 * PI;
    if (theta < -PI) theta += 2.0 * PI;

    theta *= sn;

    double x = ra * sin(theta) + map.xo;
    double y = ro - ra * cos(theta) + map.yo;

    return Weather_map_xy((x + 1.5).toInt(), (y + 1.5).toInt());
  }
}

Future<bool> handlePermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 위치 서비스 체크
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }

  // 권한 체크
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}

Future<Map<String, dynamic>> getTodayWeather() async {
  final raw = await getWeather();

  final items = raw["response"]["body"]["items"]["item"];

  Map<String, dynamic> result = {};

  for (var item in items) {
    final category = item["category"];
    final fcstValue = item["fcstValue"];

    if (category == "TMP") result["기온"] = "$fcstValue °C";
    if (category == "REH") result["습도"] = "$fcstValue %";
    if (category == "POP") result["강수확률"] = "$fcstValue %";
    if (category == "WSD") result["풍속"] = "$fcstValue m/s";

    if (category == "SKY") {
      result["하늘상태"] = {
        "1": "맑음",
        "3": "구름많음",
        "4": "흐림",
      }[fcstValue] ?? "알수없음";
    }

    if (category == "PTY") {
      result["강수형태"] = {
        "0": "없음",
        "1": "비",
        "2": "비/눈",
        "3": "눈",
        "5": "빗방울",
        "6": "빗방울/눈날림",
        "7": "눈날림"
      }[fcstValue] ?? "알수없음";
    }
  }

  return result;
}

Future<List<Map<String, dynamic>>> getTodayHourlyWeather() async {
  final raw = await getWeather();
  final items = raw["response"]["body"]["items"]["item"];

  final now = DateTime.now();
  final today = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

  List<Map<String, dynamic>> list = [];

  Map<String, Map<String, dynamic>> temp = {};

  for (var item in items) {
    if (item["fcstDate"] != today) continue;

    final time = item["fcstTime"];
    temp.putIfAbsent(time, () => {});

    temp[time]![item["category"]] = item["fcstValue"];
  }

  // 보기 좋게 정리
  temp.forEach((time, data) {
    list.add({
      "time": time,
      "TMP": data["TMP"],
      "SKY": data["SKY"],
      "PTY": data["PTY"],
      "POP": data["POP"],
      "REH": data["REH"],
    });
  });

  return list;
}

Future<List<Map<String, dynamic>>> getTomorrowWeather() async {
  final raw = await getWeather();
  final items = raw["response"]["body"]["items"]["item"];

  final now = DateTime.now().add(Duration(days: 1));
  final tomorrow = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

  List<Map<String, dynamic>> list = [];
  Map<String, Map<String, dynamic>> temp = {};


  for (var item in items) {
    if (item["fcstDate"] != tomorrow) continue;

    print("fcstDate: ${item['fcstDate']}, fcstTime: ${item['fcstTime']}");
    final time = item["fcstTime"];
    temp.putIfAbsent(time, () => {});
    temp[time]![item["category"]] = item["fcstValue"];
  }

  temp.forEach((time, data) {
    list.add({
      "time": time,
      "TMP": data["TMP"],
      "SKY": data["SKY"],
      "PTY": data["PTY"],
      "POP": data["POP"],
      "REH": data["REH"],
    });
  });

  return list;
}



Future<Weather_map_xy> getCurrentXY() async {
  final allowed = await handlePermission();
  if (!allowed) throw Exception("위치 권한이 거부되었습니다.");

  Position pos = await Geolocator.getCurrentPosition();
  return WeatherXYConverter.toGrid(pos.longitude, pos.latitude);
}

// 🔥 최근 발표시각 계산
String getBaseTime() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 23) return "2300";
  if (hour >= 20) return "2000";
  if (hour >= 17) return "1700";
  if (hour >= 14) return "1400";
  if (hour >= 11) return "1100";
  if (hour >= 8) return "0800";
  if (hour >= 5) return "0500";
  if (hour >= 2) return "0200";

  // 새벽 1시 → 전날 23시 사용
  return "2300";
}

Future<Map<String, dynamic>> getWeather() async {
  // 1) 내 현재 위치를 위·경도로 가져와서 → 기상청 격자좌표로 변환
  Weather_map_xy xy = await getCurrentXY();   // <-- 이 함수는 이미 위에 있음

  // 2) 오늘 날짜 (YYYYMMDD) 계산
  final now = DateTime.now();
  final baseDate =
      "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

  // 3) 현재 시간 기준, 기상청 발표시각 계산 (02,05,08,11,14,17,20,23 중 하나)
  final baseTime = getBaseTime(); // 이것도 이미 위에 정의돼 있음

  // 4) 실제 요청 URL
  final url = Uri.parse(
      "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
          "?serviceKey=51057168d0268149ec4c40985eb0d71e74031f0f2af50c1fde722ae944debfb5"
          "&numOfRows=500"
          "&pageNo=1"
          "&dataType=JSON"
          "&base_date=$baseDate"
          "&base_time=$baseTime"
          "&nx=${xy.x}&ny=${xy.y}"
  );

  print("🔍 요청 URL: $url");

  final res = await http.get(url);
  print("🔍 statusCode: ${res.statusCode}");

  if (res.statusCode != 200) {
    throw Exception("기상청 API 오류: ${res.statusCode} / ${res.body}");
  }

  return jsonDecode(res.body);
}
