import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:kirei/src/utils/popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[ConnectivityResult.none].obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Initial connectivity check when the app starts
  Future<void> initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      print("Error checking connectivity: $e");
    }
  }

  /// Update the connection status based on changes in connectivity.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;

    // Show warning if there's no connection
    if (_connectionStatus.every((status) => status == ConnectivityResult.none)) {
      AppLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check if the device is connected to any network (Wi-Fi or mobile).
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.any((status) => status != ConnectivityResult.none);
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose the connectivity subscription when the controller is closed.
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
