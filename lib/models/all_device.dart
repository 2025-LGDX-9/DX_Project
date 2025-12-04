import 'package:hive/hive.dart';

part 'all_device.g.dart';

@HiveType(typeId: 1)
class AllDevice extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int iconCode;

  @HiveField(2)
  String type;  // ← 필수 추가: aircon, aircleaner, humidifier, robot

  AllDevice({
    required this.name,
    required this.iconCode,
    required this.type,
  });
}
