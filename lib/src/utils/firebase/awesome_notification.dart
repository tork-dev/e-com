import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/bottom_navigation/convex-bottom_navigation.dart';
import 'package:kirei/src/features/bottom_navigation/convex_controller.dart';

import '../../../main.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg");
    } else {
      print("FOREGROUND");
    }

    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }

  static Future<void> onNotificationCreated(ReceivedNotification receivedNotification) async {
    // Handle when a notification is created
  }

  static Future<void> onNotificationDisplayed(ReceivedNotification receivedNotification) async {
    // Handle when a notification is displayed
  }

  static Future<void> onDismissAction(ReceivedAction receivedAction) async {
    // Handle when a notification is dismissed
  }

  static Future<void> onActionReceived(ReceivedAction receivedAction) async {
    print('notification');
    print(receivedAction.id);
    print(receivedAction.body);
    print(receivedAction.actionType);
    print(receivedAction.payload);
    if(receivedAction.payload!['item_type_id'] != null){
      print(receivedAction.payload?['item_type_id']);
    }
// // Handle when a notification action is received
//     if (receivedAction.payload != null) {
// // Assuming payload contains a "screen" parameter to navigate to
//       String? screen = receivedAction.payload!['screen'];
//       if (screen != null) {
// // Navigate based on the "screen" parameter using GetX
//         Get.toNamed(screen, arguments: receivedAction.payload);
//       }
//     }
  }
}



class AwesomeNotificationController {
   Future<void> initializeRemoteNotifications({
    required bool debug
  }) async {
    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
        onFcmTokenHandle: NotificationController.myFcmTokenHandle,
       // onNativeTokenHandle: NotificationController.myNativeTokenHandle,
        licenseKeys: null,
        debug: debug
    );

    // Request initial notification permissions
    await AwesomeNotifications().requestPermissionToSendNotifications();

    // Create a notification channel
    await AwesomeNotifications().initialize(
        'resource://drawable/ic_notification', // Default icon for the channel
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              channelShowBadge: true,
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white,
              importance: NotificationImportance.High,
              defaultRingtoneType: DefaultRingtoneType.Notification
          )
        ],
        debug: debug
    );

    // Set up event listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceived,
      onNotificationCreatedMethod: NotificationController.onNotificationCreated,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayed,
    );
  }

  static Future<void> showNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Hello Awesome Notifications!',
          body: 'This is a simple notification.',
          notificationLayout: NotificationLayout.Default,
          payload: {'screen': '/details_screen', 'id': '12345'}
        )
    );

  }





  // Request FCM token to Firebase
  Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
      }
      catch (exception){
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }
}




