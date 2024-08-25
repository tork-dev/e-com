import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_details_model.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_response_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/logging/logger.dart';

class KireiTubeRepositories {
  Future<KireiTubeResponse> getKireiTubeList() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.kireiTubeList));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeResponse.fromJson(jsonDecode(response.body));
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeDetailsResponse> getKireiDetailsData(String videoSlug) async {
    final response = await http
        .get(Uri.parse('${AppApiEndPoints.kireiTubeList}/$videoSlug'));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeDetailsResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }
}
