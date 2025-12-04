import 'package:hive/hive.dart';

part 'favorite_device.g.dart';

@HiveType(typeId: 0)
class FavoriteDevice extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int iconCode;

  @HiveField(2)
  String type; // ← 추가 (예: "aircon", "aircleaner", "humidifier", "robot")

  FavoriteDevice({
    required this.name,
    required this.iconCode,
    required this.type,
  });
}
