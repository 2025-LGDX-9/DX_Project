import 'package:hive/hive.dart';

part 'energy_log.g.dart';

@HiveType(typeId: 12)   // typeId= 앱 전체에서 유니크해야 함
class EnergyLog {
  @HiveField(0)
  int deviceId;

  @HiveField(1)
  DateTime eventTime;

  @HiveField(2)
  String sourceType;

  @HiveField(3)
  String extraInfo;

  @HiveField(4)
  bool powerState;

  EnergyLog({
    required this.deviceId,
    required this.eventTime,
    required this.sourceType,
    required this.extraInfo,
    required this.powerState,
  });

  factory EnergyLog.fromJson(Map<String, dynamic> json) {
    return EnergyLog(
      deviceId: json['DEVICE_ID'] ?? 0,

      eventTime: DateTime.tryParse(json['EVENT_TIME'] ?? '')
          ?? DateTime.now(),

      sourceType: json['SOURCE_TYPE'] ?? '',

      extraInfo: json['EXTRA_INFO'] ?? '',

      powerState: json['POWER_STATE'] == 1 ||
          json['POWER_STATE'] == true ||
          json['POWER_STATE'] == "1",
    );
  }

}
