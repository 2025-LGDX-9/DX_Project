import 'package:hive/hive.dart';

part 'all_device.g.dart';

@HiveType(typeId: 1)
class AllDevice extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int iconCode;

  AllDevice({required this.name, required this.iconCode});
}
