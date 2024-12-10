import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kirei/src/utils/firebase/awesome_notification.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/helpers/dependency_injection/di_helper.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

// @pragma('vm:entry-point') // Required for background execution
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling a background message: ${message.messageId}');
//   // Add custom handling for background messages if needed
// }
GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize local storage
  await GetStorage.init();

  // Initialize dependency injection
  DependencyInjection.init();

  // Ensure BASE_URL_WEB is available
  final baseUrlWeb = dotenv.env["BASE_URL_WEB"];
  if (baseUrlWeb == null) {
    throw Exception("BASE_URL_WEB is not defined in .env file.");
  }

  // Clear user data if the app URL has changed
  if (AppLocalStorage().readData(LocalStorageKeys.appUrl) != baseUrlWeb) {
    AuthHelper().clearUserData();
  }

  // Save the updated app URL to local storage
  AppLocalStorage().saveData(LocalStorageKeys.appUrl, baseUrlWeb);

  // Initialize Firebase
  try {
    await Firebase.initializeApp(name: 'KireiBD');
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    if (kDebugMode) {
      print("Firebase initialization error: $e");
    }
  }

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // Initialize notification services
  final notificationServices = NotificationServices();
  notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();

  // Fetch and store FCM token
  try {
    final fcmToken = await notificationServices.getDeviceToken();
    AppLocalStorage().saveData(LocalStorageKeys.fcmToken, fcmToken);
    if (kDebugMode) {
      print('Device Token: $fcmToken');
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching FCM token: $e");
    }
  }

  // Run the app
  runApp(const MyApp());
}
