import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gtm/gtm.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';

class EventLogger {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final facebookAppEvents = FacebookAppEvents();
  final gtm = Gtm.instance;

  final String? memberId =
      AppLocalStorage().readData(LocalStorageKeys.userEmail).toString();
  final String? userName =
      AppLocalStorage().readData(LocalStorageKeys.userName);
  final String? gaipUserId =
      AppLocalStorage().readData(LocalStorageKeys.gaipUserId);

  void logEvent(String name, Map<String, dynamic> parameters) {
    _analytics.logEvent(name: name, parameters: parameters);
  }

  void logProductDetailsViewEvent(String itemId) async {
    logEvent('product_details_view', {
      'gaip_user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
    });

    gtm.push('product_details_view', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
    });

    facebookAppEvents.logEvent(
      name: 'ViewContent',
      parameters: {
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Member_ID': memberId
      },
    );
  }

  void logPurchaseEvent(String items,
      dynamic itemPrice) async {
    logEvent('purchase', {
      'user_id': gaipUserId,
      'member_id': memberId,
      'items': items,
    });

    gtm.push('purchase', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'items': items,
    });

    facebookAppEvents.logEvent(
      name: 'Purchase',
      parameters: {
        'Content_ID': items,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  void logAddToWishlistEvent(String itemId, dynamic itemPrice) async {
    logEvent('add_to_wishlist', {
      'user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
    });
    gtm.push('add_to_wishlist', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
    });

    facebookAppEvents.logEvent(
      name: 'AddToWishlist',
      parameters: {
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  void logAddToCartEvent(String itemId, dynamic itemPrice) async {
    AppLoggerHelper.info(memberId.toString());
    logEvent('add_to_cart', {
      'user_id': gaipUserId,
      'member': memberId,
      'item_id': itemId,
    });

    gtm.push('add_to_cart', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
    });

    facebookAppEvents.logEvent(
      name: 'AddToCart',
      parameters: {
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  // void logUserDataEvent(String gender, String phoneNumber) async {
  //   logEvent('user_data_update', {
  //     'user_id': gaipUserId,
  //     'member': memberId,
  //     'gender': gender,
  //     'phone_number': phoneNumber,
  //   });
  // }

  void logSearchEvent(String itemId) {
    logEvent('Search',
        {'item_id': itemId, 'user_id': gaipUserId, 'member_id': memberId});

    gtm.push('Search', parameters: {
      'item_id': itemId,
      'user_id': gaipUserId,
      'member_id': memberId
    });

    facebookAppEvents.logEvent(
      name: 'Search',
      parameters: {
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Member_ID': memberId
      },
    );
  }

  void initialCheckoutEvent(String cartId, dynamic subtotalPrice) {
    logEvent('Search', {
      'cart_id': cartId,
      'user_id': gaipUserId,
      'member_id': memberId,
      'subtotal': subtotalPrice
    });

    gtm.push('Search', parameters: {
      'cart_id': cartId,
      'user_id': gaipUserId,
      'member_id': memberId,
      'subtotal': subtotalPrice
    });

    facebookAppEvents.logEvent(
      name: 'InitiateCheckout',
      parameters: {
        'Content_ID': cartId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': subtotalPrice,
        'Member_ID': memberId
      },
    );

  }
}
