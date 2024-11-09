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
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'src/features/home/repositories/home_repositories.dart';
import 'src/utils/helpers/routing_helper.dart';



// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   NotificationServices().handleMessage(message.data['route']);
// }

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  if(AppLocalStorage().readData(LocalStorageKeys.appUrl) != dotenv.env["BASE_URL_WEB"]){
    AuthHelper().clearUserData();
  }

  AppLocalStorage().saveData(LocalStorageKeys.appUrl, dotenv.env["BASE_URL_WEB"]!);

  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));



  NotificationServices notificationServices = NotificationServices();
   notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();


  notificationServices.getDeviceToken().then((value){
    AppLocalStorage().saveData(LocalStorageKeys.fcmToken, value);
    if (kDebugMode) {
      print('device token');
      print(value);
    }
  });


  DependencyInjection.init();
  runApp(const  MyApp());
}
