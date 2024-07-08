import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/app.dart';
import 'package:kirei/src/utils/firebase/push_notification.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'src/features/authentication/data/repositories/auth_repositories.dart';


final navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data}");
}

// Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
//   print("Message from remote ${message.data}");
//   // AwesomeNotifications().createNotification(
//   //     content: NotificationContent( //with image from URL
//   //         id: 1,
//   //         channelKey: 'basic', //channel configuration key
//   //         title: message.data["title"],
//   //         body: message.data["body"],
//   //         bigPicture: message.data["image"],
//   //         notificationLayout: NotificationLayout.BigPicture,
//   //         payload: {"name":"flutter"}
//   //     )
//   // );
// }

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          importance: NotificationImportance.High,
        ),
        //add more notification type with different configuration

      ]
  );

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    name: 'Kirei',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationService().initNotifications();

  // Get any initial links
  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();



  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));



  runApp(const  MyApp());
}
