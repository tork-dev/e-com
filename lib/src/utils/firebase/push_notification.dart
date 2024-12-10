//
// import 'dart:io';
// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:kirei/src/utils/helpers/routing_helper.dart';
//
// import '../../../main.dart';
// import '../local_storage/local_storage_keys.dart';
// import '../local_storage/storage_utility.dart';
//
// @pragma('vm:entry-point')
// void notificationResponse(NotificationResponse notificationResponse) {
//   print('This is action id: ${notificationResponse.actionId}');
//   print('This is payload: ${notificationResponse.payload}');
//
//   // Handle the action based on the actionId
//   switch (notificationResponse.actionId) {
//     case 'action_1':
//     // Perform specific logic for action 1
//       print('Action 1 triggered');
//       // Navigate to a specific screen or perform an action
//       break;
//     case 'action_2':
//     // Perform specific logic for action 2
//       print('Action 2 triggered');
//       // Navigate to a different screen or perform another action
//       break;
//     default:
//       print('Unknown action triggered');
//       break;
//   }
//
//   // If there is payload data, you can parse and use it here
//   if (notificationResponse.payload != null) {
//     final payloadData = notificationResponse.payload;
//     // Handle the payload data
//   }
// }
//
//
//
// class PushNotificationService {
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   void notificationController(){
//     initNotifications();
//     firebaseMessage();
//     //handelBackAndTerminateState();
//   }
//
//
//   Future<void> initNotifications() async{
//
//     await _firebaseMessaging.requestPermission(
//         alert: true,
//         sound: true,
//         announcement: true,
//         badge: true,
//         carPlay: true,
//         criticalAlert: true,
//         provisional: true,
//     );
//
//     final fCMToken = await _firebaseMessaging.getToken();
//
//     print("FCM TOKEN is : ${fCMToken}");
//     await AppLocalStorage().saveData(LocalStorageKeys.fcmToken, fCMToken);
//     print("local fcm : ${AppLocalStorage().readData(LocalStorageKeys.fcmToken)}");
//     // initPushNotifications();
//   }
//
//   void firebaseMessage(){
//     FirebaseMessaging.onMessage.listen((message) {
//       print(message.data);
//       print(message.notification!.title);
//       print(message.notification!.body);
//       if (Platform.isAndroid) {
//         initLocalNotification(message);
//         showNotification(message);
//       }else{
//         showNotification(message);
//       }
//     });
//   }
//
//   Future<void> initLocalNotification(RemoteMessage message)async{
//
//     AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@drawable/ic_notification');
//     DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings();
//
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: darwinInitializationSettings
//     );
//
//    await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onDidReceiveNotificationResponse: (payload){
//       //  handelMessage(message);
//       // }
//      onDidReceiveNotificationResponse: notificationResponse
//     );
//
//
//   }
//
//   Future<void> showNotification(RemoteMessage message)async{
//
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         message.notification!.android!.channelId!,
//         'Kirei',
//         importance: Importance.max
//     );
//
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//         channel.id.toString(),
//         channel.name.toString(),
//       channelDescription: 'Your channel description',
//       importance: Importance.high,
//       priority: Priority.high,
//       ongoing: true,
//       styleInformation: const BigTextStyleInformation(''),
//       ticker: 'ticker',
//       playSound: true,
//       icon: '@drawable/ic_notification',
//
//       actions: <AndroidNotificationAction>[
//         AndroidNotificationAction(message.data['action_id'], 'Action 1', showsUserInterface: true),
//         AndroidNotificationAction('action_2', 'Action 2', showsUserInterface: true),
//       ],
//     );
//
//     const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//
//     Future.delayed(Duration.zero, (){
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title,
//           message.notification!.body,
//           notificationDetails,
//         payload: '{"route": "${message.data['route']}"}',
//       );
//     });
//
//
//   }
//
//   void handelMessage(RemoteMessage? message ){
//     RoutingHelper.urlRouting(message!.data['route']);
//   }
//
//   Future handelBackAndTerminateState() async{
//     RemoteMessage? initialMessage = await  _firebaseMessaging.getInitialMessage();
//     if(initialMessage!= null){
//       handelMessage(initialMessage);
//     }
//
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       handelMessage(message);
//     });
//
//   }
//
//
// }