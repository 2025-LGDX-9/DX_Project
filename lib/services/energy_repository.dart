import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/energy_log.dart';

class EnergyRepository {
  Future<void> fetchAndSaveLogs() async {
    print("=== fetchAndSaveLogs 시작 ===");

    try {
      final url = "http://192.168.219.97:8001/getLogs";
      print("요청 URL: $url");

      final res = await http.get(Uri.parse(url));
      print("서버 응답 코드: ${res.statusCode}");
      print("서버 응답 바디: ${res.body}");

      final List data = jsonDecode(res.body);

      final box = Hive.box<EnergyLog>('energy_logs');

      for (var item in data) {
        box.add(
          EnergyLog(
            deviceId: item["DEVICE_ID"],
            eventTime: DateTime.parse(item["EVENT_TIME"]),
            sourceType: item["SOURCE_TYPE"],
            extraInfo: item["EXTRA_INFO"],
            powerState: item["POWER_STATE"] == "Y",
          ),
        );
      }
    } catch (e, st) {
      print("🔥 fetchAndSaveLogs 오류: $e");
      print(st);
    }
  }

}
