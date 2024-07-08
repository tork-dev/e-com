import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kirei/src/features/personalization/view/profile.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:upgrader/upgrader.dart';
import '../main.dart';
import 'features/notification_view/view/notification.dart';
import 'features/splash/view/splash_screen.dart';
import './utils/theme/theme.dart';
import './utils/constants/text_strings.dart';
import 'common/bindings/general_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create an instance of FirebaseAnalytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // final routes = [
  //   GetPage(name: '/', page: () => SplashScreen()),
  //   // GetPage(name: '/second', page: () => SecondScreen()),
  //   // GetPage(name: '/third', page: () => ThirdScreen()),
  // ];

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        initialBinding: GeneralBindings(),
        title: AppTexts.appName,
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        //darkTheme: MyAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        // home: UpgradeAlert(
        //   showReleaseNotes: false,
        //   child: const SplashScreen(),
        // ),
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => UpgradeAlert(
              showReleaseNotes: false,
              child: const SplashScreen(),
            ),
          ),
          GetPage(name: '/home', page: () => const SplashScreen()),
          GetPage(name: '/filter', page: () => const ProfileScreen()),

          // Add more routes as needed
        ],

        //navigatorKey: navigatorKey,
      ),
    );
  }
}
