
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';

import '../../../main.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';


class PushNotificationService {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void notificationController(){
    initNotifications();
    firebaseMessage();
    handelBackAndTerminateState();
  }


  Future<void> initNotifications() async{

    await _firebaseMessaging.requestPermission(
        alert: true,
        sound: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
    );

    final fCMToken = await _firebaseMessaging.getToken();

    print("FCM TOKEN is : ${fCMToken}");
    await AppLocalStorage().saveDataIfNull(LocalStorageKeys.fcmToken, fCMToken);
    print("local fcm : ${AppLocalStorage().readData(LocalStorageKeys.fcmToken)}");
    // initPushNotifications();
  }

  void firebaseMessage(){
    FirebaseMessaging.onMessage.listen((message) {
      print(message.data);
      print(message.notification!.title);
      print(message.notification!.body);
      if (Platform.isAndroid) {
        initLocalNotification(message);
        showNotification(message);
      }else{
        showNotification(message);
      }
    });
  }

  Future<void> initLocalNotification(RemoteMessage message)async{

    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@drawable/ic_notification');
    DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings
    );

   await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload){
       handelMessage(message);
      }
    );


  }

  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId!,
        'Kirei',
        importance: Importance.max
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    
    Future.delayed(Duration.zero, (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    });


  }

  void handelMessage(RemoteMessage? message ){
    RoutingHelper.urlRouting(message!.data['route']);
  }

  Future handelBackAndTerminateState() async{
    RemoteMessage? initialMessage = await  _firebaseMessaging.getInitialMessage();
    if(initialMessage!= null){
      handelMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handelMessage(message);
    });

  }


}