import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_response_model.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_videos_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/logging/logger.dart';

import '../model/kirei_tube_details_model.dart';
import '../model/kirei_tube_playlist.dart';
import '../model/playlist_details_response.dart';

class KireiTubeRepositories {
  Future<KireiTubeHomeResponse> getKireiHome() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.kireiTubeHome));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeHomeResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeVideosListResponse> getKireiTubeVideos({int? isPopular, String? orientation, String? orderBy}) async {
    Map<String, dynamic> parameters = {
      "is_popular" : isPopular,
      "orientation" : orientation,
      "order_by" : orderBy
    };

    String queryString = parameters.entries
        .map((entry) =>
    '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
    final response = await http.get(Uri.parse("${AppApiEndPoints.kireiTubeVideos}?$queryString"));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeVideosListResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeVideosPlaylistResponse> getKireiPlaylist() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.kireiPlaylist));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeVideosPlaylistResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }


  Future<KireiTubeDetailsResponse> getKireiDetailsData(String videoSlug) async {
    final response = await http
        .get(Uri.parse('${AppApiEndPoints.kireiTubeVideos}/$videoSlug'));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeDetailsResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubePlaylistDetailsResponse> getKireiPlaylistDetails(String playlistSlug) async {
    final response = await http
        .get(Uri.parse('${AppApiEndPoints.kireiPlaylistDetails}/$playlistSlug'));

    AppLoggerHelper.debug(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubePlaylistDetailsResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }
}
