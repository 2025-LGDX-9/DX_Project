import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/energy_log.dart';

class EnergyRepository {
  Future<void> fetchAndSaveLogs() async {

    try {
      final url = "http://192.168.219.245:8001/getLogs";

      final res = await http.get(Uri.parse(url));

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
