  import 'package:hive/hive.dart';

  part 'favorite_device.g.dart';

  @HiveType(typeId: 0)
  class FavoriteDevice extends HiveObject {
    @HiveField(0)
    String name;

    @HiveField(1)
    int iconCode; // Material icon codePoint

    FavoriteDevice({
      required this.name,
      required this.iconCode,
    });
  }