import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import '../helpers/routing_helper.dart';
import '../logging/logger.dart';

class NotificationServices {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android channel ID & name
  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';

  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!);
            handleMessageFromData(data);
          } catch (e) {
            Log.e('Error parsing notification payload: $e');
          }
        }
      },
    );

    // Create notification channel (Android 8.0+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  void firebaseInit() {
    initializeLocalNotifications();

    // Handle when app is opened from terminated state by tapping a notification
    _checkInitialMessage();

    // Listen for messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Log.d('Foreground message received');
      showNotification(message);
    });

    // Listen for messages when app is opened from background by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Log.d('Background message tapped');
      handleMessageFromData(message.data);
    });

    // Set presentation options for iOS foreground notifications
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen for token refreshes
    messaging.onTokenRefresh.listen((newToken) {
      Log.d('FCM Token refreshed: $newToken');
      // TODO: send new token to your backend server here
    });
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      Log.d('App launched from terminated state via notification');
      handleMessageFromData(initialMessage.data);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification == null) {
      Log.w('Notification payload missing, skipping showNotification');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      color: AppColors.primary,
      styleInformation: const BigTextStyleInformation(''),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Use a unique notification ID (e.g., current timestamp)
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      notification.title,
      notification.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  void handleMessageFromData(Map<String, dynamic> data) {
    if (data.containsKey('route')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RoutingHelper.urlRouting(data['route']);
      });
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    if (token == null) {
      Log.w('FCM token is null');
      throw Exception('Failed to get FCM token');
    }
    return token;
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Log.d('User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Log.d('User granted provisional notification permission');
    } else {
      Log.d('User denied notification permission');
    }
  }
}
