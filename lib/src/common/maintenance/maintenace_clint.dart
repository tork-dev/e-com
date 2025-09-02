import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class MaintenanceHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request);

    // Convert response to usable Response
    final res = await http.Response.fromStream(response);

    try {
      final data = jsonDecode(res.body);

      if (res.statusCode == 404 || AppLocalStorage().readData(LocalStorageKeys.isInMaintenanceMode) == true) {
        Get.offAllNamed('/maintenance');
      }
    } catch (_) {
      // ignore JSON decode errors
    }

    return response;
  }
}
