import 'dart:convert';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gtm/gtm.dart';
import 'package:kirei/src/utils/helpers/gigalogy/repository/gigalogy_repositories.dart';
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
        'advertiser_tracking_enabled': true,
        'Content_ID': itemId,
        'Content_Type': 'product',
        'Member_ID': memberId
      },
    );
    GigalogyRepository().sendDetailsEvent(itemId);
  }

  void logPurchaseEvent(items, dynamic itemPrice) async {
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
      valueToSum: itemPrice.toDouble(),
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': items,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'ValueToSum': itemPrice,
        'Member_ID': memberId
      },
    );

    GigalogyRepository().sendPurchaseDataEvent(items: jsonDecode(items));
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
    GigalogyRepository().sendChoosingDataEvent(itemSlug: itemId);
  }

  void logAddToCartEvent(String itemId, dynamic itemPrice) async {
    Log.i(memberId.toString());
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
   GigalogyRepository().sendChoosingDataEvent(itemSlug: itemId);
  }

  void logUserDataEvent() async {
    logEvent('user_data_update', {
      'user_id': gaipUserId,
      'member': memberId,
    });
    GigalogyRepository().sendUserDataEvent();
  }

  void logSearchEvent(String searchValue) {
    logEvent('Search', {
      'SearchValue': searchValue,
      'user_id': gaipUserId,
      'member_id': memberId
    });

    gtm.push('Search', parameters: {
      'item_id': searchValue,
      'user_id': gaipUserId,
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

  void logReviewEvent(
      {required String itemId,
      required String rating,
      required String feedback}) {
    GigalogyRepository().sendChoosingDataEvent(
        itemSlug: itemId, rating: rating, feedBack: feedback);
  }

  void logLoginEvent(String loginMethod) {
    logEvent('login', {
      "method": loginMethod
    });

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
    logEvent('login', {
      "method": loginMethod
    });

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
    logEvent('share', {
      "content_type": "product",
      "item_id": itemId,
    });

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
    logEvent('remove_from_cart', {
      'user_id': gaipUserId,
      'member': memberId,
      'item_id': itemId,
    });

    gtm.push('remove_from_cart', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'item_id': itemId,
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


  void logViewCartEvent(String items) async {
    logEvent('view_cart', {
      'user_id': gaipUserId,
      'member_id': memberId,
      'items': items,
    });

    gtm.push('view_cart', parameters: {
      'user_id': gaipUserId,
      'member_id': memberId,
      'items': items,
    });

    facebookAppEvents.logEvent(
      name: 'view_cart',
      parameters: {
        'advertiser_tracking_enabled': true,
        'Content_ID': items,
        'Content_Type': 'product',
        'Currency': 'BDT',
        'Member_ID': memberId
      },
    );
  }



}
