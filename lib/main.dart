import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/firebase_options.dart';
import 'package:kirei/src/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kirei/src/utils/caching/caching_utility.dart';
import 'package:kirei/src/utils/firebase/notification_service.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/helpers/deep_link_helper.dart';
import 'package:kirei/src/utils/helpers/env_config.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/features/cart/model/cart_local_model.dart';
import 'src/utils/helpers/app_life_cycle_helper.dart';

// Background message handler must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationServices().initializeLocalNotifications();
  // await NotificationServices().showNotification(message);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLifecycleObserver lifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(lifecycleObserver);

  // Load environment variables
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }


  // Initialize local storage
  await GetStorage.init();
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('cacheBox'); // Open Hive Box for caching
  CachingUtility.clearAll();

  // Adapter register (from generated file)
  Hive.registerAdapter(CartItemLocalAdapter());
  // Open Cart box
  await Hive.openBox<CartItemLocal>('cartBox');


  // Ensure BASE_URL_WEB is available
  String? baseUrlWeb = EnvConfig.baseUrlWeb;

  // Clear user data if the app URL has changed
  if (AppLocalStorage().readData(LocalStorageKeys.appUrl) != baseUrlWeb) {
    AuthHelper().clearUserData();
  }

  // Save the updated app URL to local storage
  AppLocalStorage().saveData(LocalStorageKeys.appUrl, baseUrlWeb);

  //save the

  // Initialize Firebase
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize notification services
  // Initialize notification services
  final notificationServices = NotificationServices();
  await notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();

  // Get and store FCM token
  try {
    final fcmToken = await notificationServices.getDeviceToken();
    AppLocalStorage().saveData(LocalStorageKeys.fcmToken, fcmToken);
    debugPrint('Device Token: $fcmToken');
  } catch (e) {
    debugPrint("Error fetching FCM token: $e");
  }

  Get.put(DeepLinkController());
  // Catch Flutter framework errors
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Catch async and other uncaught errors
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Run the app
  runApp(const MyApp());
}
