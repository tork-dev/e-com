import 'package:hive/hive.dart';

import '../logging/logger.dart';

class CachingUtility {
  static final _box = Hive.box('cacheBox');

  /// Default time-to-live for cached data
  static const Duration defaultTTL = Duration(hours: 1);

  /// Save data to cache with optional TTL
  /// [key] - unique identifier for the cached data
  /// [data] - the data to cache (must be JSON serializable)
  /// [ttl] - optional time-to-live, defaults to 1 hour
  static Future<void> saveData(
    String key,
    dynamic data, {
    Duration? ttl,
  }) async {
    final cacheEntry = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttlMs': (ttl ?? defaultTTL).inMilliseconds,
    };
    await _box.put(key, cacheEntry);
  }

  /// Get cached data if it exists and hasn't expired
  /// Returns null if data doesn't exist or has expired
  static dynamic getData(String key) {
    final cached = _box.get(key);
    if (cached == null) return null;

    // Handle old cache entries without TTL (backward compatibility)
    if (cached is! Map || !cached.containsKey('timestamp')) {
      return cached;
    }

    final timestamp = cached['timestamp'] as int;
    final ttlMs = cached['ttlMs'] as int? ?? defaultTTL.inMilliseconds;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Check if cache has expired
    if (now - timestamp > ttlMs) {
      _box.delete(key); // Clean up expired data
      Log.d('Cache expired for key: $key');
      return null;
    }

    return cached['data'];
  }

  /// Check if cache entry exists and is still valid
  static bool isValid(String key) {
    return getData(key) != null;
  }

  /// Clear specific cache entry
  static Future<void> clearCache(String key) async {
    await _box.delete(key);
  }

  /// Clear all cached data
  static Future<void> clearAll() async {
    await _box.clear();
    Log.d("All cache cleared!");
  }

  /// Clear all expired cache entries
  static Future<void> clearExpired() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final keysToDelete = <dynamic>[];

    for (final key in _box.keys) {
      final cached = _box.get(key);
      if (cached is Map && cached.containsKey('timestamp')) {
        final timestamp = cached['timestamp'] as int;
        final ttlMs = cached['ttlMs'] as int? ?? defaultTTL.inMilliseconds;
        if (now - timestamp > ttlMs) {
          keysToDelete.add(key);
        }
      }
    }

    for (final key in keysToDelete) {
      await _box.delete(key);
    }

    if (keysToDelete.isNotEmpty) {
      Log.d('Cleared ${keysToDelete.length} expired cache entries');
    }
  }
}
