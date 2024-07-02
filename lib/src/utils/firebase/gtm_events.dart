import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';


class EventLogger {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  final String? userId = AppLocalStorage().readData(LocalStorageKeys.userId);

  void logEvent(String name, Map<String, dynamic> parameters) {
    _analytics.logEvent(name: name, parameters: parameters);
  }

  void logProductDetailsViewEvent(String itemId) async {
    logEvent('product_details_view', {
      'user_id': userId,
      'item_id': itemId,
    });
  }

  void logPurchaseEvent(String memberId, List<Map<String, dynamic>> items) async {
    logEvent('purchase', {
      'user_id': userId,
      'member_id': memberId,
      'items': items,
    });
  }

  void logAddToWishlistEvent(String itemId) async {
    logEvent('add_to_wishlist', {
      'user_id': userId,
      'item_id': itemId,
    });
  }

  void logAddToCartEvent(String itemId) async {
    logEvent('add_to_cart', {
      'user_id': userId,
      'item_id': itemId,
    });
  }

  void logUserDataEvent(String gender, String phoneNumber) async {
    logEvent('user_data_update', {
      'user_id': userId,
      'gender': gender,
      'phone_number': phoneNumber,
    });
  }
}
