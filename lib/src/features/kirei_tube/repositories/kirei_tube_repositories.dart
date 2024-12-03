
import 'package:http/http.dart' as http;
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_response_model.dart';
import 'package:kirei/src/features/kirei_tube/model/kirei_tube_videos_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/logging/logger.dart';

import '../model/kirei_tube_details_model.dart';
import '../model/kirei_tube_playlist.dart';
import '../model/playlist_details_response.dart';

class KireiTubeRepositories {
  Future<KireiTubeHomeResponse> getKireiHome(String? searchName) async {
    final response = await http.get(Uri.parse('${AppApiEndPoints.kireiTubeHome}?search=$searchName'));

    Log.d(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeHomeResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeVideosListResponse> getKireiTubeVideos(
      {String? searchName, int? isPopular, String? orientation, String? orderBy}) async {
    Map<String, dynamic> parameters = {
      "is_popular": isPopular,
    };
    if(searchName != ''){
      parameters["search"] = searchName;
    }
    if(orientation != ''){
      parameters["orientation"] = orientation;
    }
    if(orderBy != ''){
      parameters["order_by"] = orderBy;
    }

    String queryString = parameters.entries
        .map((entry) =>
            '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
    final response = await http
        .get(Uri.parse("${AppApiEndPoints.kireiTubeVideos}?$queryString"));

    Log.d(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeVideosListResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeVideosPlaylistResponse> getKireiPlaylist(
      {required int isPopular,
      required String searchName,
      required String orderBy}) async {
    Map<String, dynamic> parameters = {
      "is_popular": isPopular,
      "title": searchName,
      "order_by": orderBy
    };

    String queryString = parameters.entries
        .map((entry) =>
    '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    final response = await http
        .get(Uri.parse("${AppApiEndPoints.kireiPlaylist}?$queryString"));

    Log.d(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeVideosPlaylistResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubeDetailsResponse> getKireiDetailsData(String videoSlug) async {
    final response = await http
        .get(Uri.parse('${AppApiEndPoints.kireiTubeVideos}/$videoSlug'));

    Log.d(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubeDetailsResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<KireiTubePlaylistDetailsResponse> getKireiPlaylistDetails(
      String playlistSlug) async {
    final response = await http.get(
        Uri.parse('${AppApiEndPoints.kireiPlaylistDetails}/$playlistSlug'));

    Log.d(response.body.toString());

    if (response.statusCode == 200) {
      return KireiTubePlaylistDetailsResponse.fromJson(response.body);
    } else {
      throw 'error';
    }
  }
}
