import 'package:flutter/material.dart';
import 'package:kirei/src/utils/caching/caching_utility.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  void onAppClose() {
    debugPrint("🚀 App is closing (Android & iOS)!");
    CachingUtility.clearAll();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      onAppClose();
    }
  }
}
