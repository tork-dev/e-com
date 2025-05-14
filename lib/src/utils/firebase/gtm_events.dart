import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gtm/gtm.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:kirei/src/utils/logging/logger.dart';

class EventLogger {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  FacebookAppEvents facebookAppEvents = FacebookAppEvents();
  Gtm gtm = Gtm.instance;

  final String? memberId =
      AppLocalStorage().readData(LocalStorageKeys.userEmail).toString();
  final String? userName =
      AppLocalStorage().readData(LocalStorageKeys.userName);
  // final String? gaipUserId =
  //     AppLocalStorage().readData(LocalStorageKeys.gaipUserId);

  void logEvent(String name, Map<String, Object>? parameters) {
    _analytics.logEvent(name: name, parameters: parameters);
  }

  void logProductDetailsViewEvent(String itemId) async {
    // logEvent('product_details_view', {
    //   'member_id': memberId!,
    //   'item_id': itemId,
    // });

    gtm.push('product_details_view', parameters: {
      'member_id': memberId,
      'item_id': itemId,
    });

    facebookAppEvents.logEvent(
      name: 'ViewContent',
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Member_ID': memberId
      },
    );
  }

  void logPurchaseEvent(List<Map<String, dynamic>> items, dynamic itemPrice, String orderId) async {
    // Firebase Analytics
    // logEvent('purchase', {
    //   'transaction_id': orderId,
    //   'value': itemPrice.toDouble(),
    //   'currency': 'BDT',
    //   'member_id': memberId.toString(),
    //   'items': items, // must be a List of Maps
    // });

    // Google Tag Manager
    gtm.push('purchase', parameters: {
      'transaction_id': orderId,
      'value': itemPrice.toDouble(),
      'currency': 'BDT',
      'member_id': memberId,
      'items': items,
    });

    // Facebook App Events
    facebookAppEvents.logEvent(
      name: 'Purchase',
      valueToSum: itemPrice.toDouble(),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': items.map((e) => e['item_id']).join(','), // or item_name
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  void logAddToWishlistEvent(String itemId, dynamic itemPrice) async {
    // logEvent('add_to_wishlist', {
    //   'member_id': memberId!,
    //   'item_id': itemId,
    //   'value': itemPrice.toDouble(),
    //   'currency': 'BDT',
    // });
    gtm.push('add_to_wishlist', parameters: {
      'member_id': memberId,
      'item_id': itemId,
      'value': itemPrice.toDouble(),
      'currency': 'BDT',
    });

    facebookAppEvents.logEvent(
      name: 'AddToWishlist',
      valueToSum: double.parse(itemPrice.toString()),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  void logAddToCartEvent(String itemId, dynamic itemPrice) async {
    Log.i(memberId.toString());
    // logEvent('add_to_cart', {
    //   'member': memberId!,
    //   'item_id': itemId,
    //   'value': itemPrice.toDouble(),
    //   'currency': 'BDT',
    // });

    gtm.push('add_to_cart', parameters: {
      'member_id': memberId,
      'item_id': itemId,
      'value': itemPrice.toDouble(),
      'currency': 'BDT',
    });

    facebookAppEvents.logEvent(
      name: 'AddToCart',
      valueToSum: itemPrice.toDouble(),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }

  void logUserDataEvent() async {
    logEvent('user_data_update', {
      'member': memberId!,
    });
  }

  void logSearchEvent(String searchValue) {
    // logEvent('Search', {
    //   'SearchValue': searchValue,
    //   'member_id': memberId!
    // });

    gtm.push('Search', parameters: {
      'item_id': searchValue,
      'member_id': memberId
    });

    facebookAppEvents.logEvent(
      name: 'Search',
      parameters: {
        'advertiser_tracking_enabled': true,
        'SearchValue': searchValue,
        'Content_Type': 'product',
        'Member_ID': memberId
      },
    );
  }

  void initialCheckoutEvent(String cartId, dynamic subtotalPrice) {
    // logEvent('Search', {
    //   'cart_id': cartId,
    //   'member_id': memberId!,
    //   'value': double.parse(subtotalPrice.toString()),
    //   'currency': 'BDT',
    // });

    gtm.push('Search', parameters: {
      'cart_id': cartId,
      'member_id': memberId,
      'value': double.parse(subtotalPrice.toString()),
      'currency': 'BDT',
    });

    facebookAppEvents.logEvent(
      name: 'InitiateCheckout',
      valueToSum: double.parse(subtotalPrice),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': cartId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': subtotalPrice,
        'Member_ID': memberId
      },
    );
  }

  // void logReviewEvent(
  //     {required String itemId,
  //     required String rating,
  //     required String feedback}) {
  //
  // }

  void logLoginEvent(String loginMethod) {
    // logEvent('login', {
    //   "method": loginMethod
    // });

    gtm.push('login', parameters: {
      "method": loginMethod
    });

    facebookAppEvents.logEvent(
      name: 'login',
      parameters: {
        'advertiser_tracking_enabled': true,
        "method": loginMethod
      },
    );
  }

  void logSignUpEvent(String loginMethod) {
    // logEvent('login', {
    //   "method": loginMethod
    // });

    gtm.push('login', parameters: {
      "method": loginMethod
    });

    facebookAppEvents.logEvent(
      name: 'login',
      parameters: {
        'advertiser_tracking_enabled': true,
        "method": loginMethod
      },
    );
  }

  void shareEvent(String itemId) {
    // logEvent('share', {
    //   "content_type": "product",
    //   "item_id": itemId,
    // });

    gtm.push('share', parameters: {
      "content_type": "product",
      "item_id": itemId,
    });

    facebookAppEvents.logEvent(
      name: 'share',
      parameters: {
        'advertiser_tracking_enabled': true,
        "content_type": "product",
        "item_id": itemId,
      },
    );
  }


  void logRemoveFromCartEvent(String itemId, dynamic itemPrice) async {
    Log.i(memberId.toString());
    // logEvent('remove_from_cart', {
    //   'member': memberId!,
    //   'item_id': itemId,
    //   'value': itemPrice.toDouble(),
    //   'currency': 'BDT',
    // });

    gtm.push('remove_from_cart', parameters: {
      'member_id': memberId,
      'item_id': itemId,
      'value': itemPrice.toDouble(),
      'currency': 'BDT',
    });

    facebookAppEvents.logEvent(
      name: 'remove_from_cart',
      valueToSum: itemPrice.toDouble(),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );
  }


  void logViewCartEvent(String items, dynamic totalValue) async {
    // logEvent('view_cart', {
    //   'member_id': memberId!,
    //   'items': items,
    //   'value': totalValue.toDouble(),
    //   'currency': 'BDT'
    // });

    gtm.push('view_cart', parameters: {
      'member_id': memberId,
      'items': items,
      'value': totalValue.toDouble(),
      'currency': 'BDT'
    });

    facebookAppEvents.logEvent(
      name: 'view_cart',
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': items,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': totalValue,
        'Member_ID': memberId
      },
    );
  }



}
