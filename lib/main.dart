import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}



Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();


  await dotenv.load(fileName: ".env");
  // AwesomeNotificationController().getFirebaseMessagingToken();
  // AwesomeNotificationController().initializeRemoteNotifications(debug: false);

  await Firebase.initializeApp(
    name: 'Kirei',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  // PushNotificationService().notificationController();
  // await PushNotificationService().handelBackAndTerminateState();
  // DeepLinkHelper().deepLinkController();

  // AppLinksDeepLink().initDeepLinks();


  // Get any initial links
 // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();


  //
  // Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  // await Stripe.instance.applySettings();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));



  runApp(const  MyApp());
}
