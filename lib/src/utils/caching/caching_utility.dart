import 'package:hive/hive.dart';

import '../logging/logger.dart';

class CachingUtility {
  static final _box = Hive.box('cacheBox');

  // Save API response to cache
  static Future<void> saveData(String key, dynamic data) async {
    await _box.put(key, data);
  }

  // Get cached data
  static dynamic getData(String key) {
    return _box.get(key);
  }

  // Clear cache
  static Future<void> clearCache(String key) async {
    await _box.delete(key);
  }

  // Clear all cached data
  static Future<void> clearAll() async {
    await _box.clear();
    Log.d("All cache cleared!");
  }
}
