import 'package:hive/hive.dart';
import '../models/favorite_device.dart';

class FavoriteService {
  static final box = Hive.box<FavoriteDevice>('favorite_devices');

  static List<FavoriteDevice> getFavorites() {
    return box.values.toList();
  }

  static void addFavorite(FavoriteDevice device) {
    box.add(device);
  }

  static void removeFavorite(String name) {
    FavoriteDevice? item;

    for (final e in box.values) {
      if (e.name == name) {
        item = e;
        break;
      }
    }

    item?.delete();
  }
}
