import 'dart:convert';

import '../model/gaip_user_id_model.dart';
import 'package:http/http.dart' as http;

class GaipUserIdRepository{
  Future<GaipUserIdResponse> getGaipUserId() async {
    Uri url =
    Uri.parse("https://api.recommender.gigalogy.com/v1/users/generate/id");
    final response = await http.get(url, headers: {
      "project-key": "pwtqOj1tByfuVmbVTwCbAvrGpCdrnVEcLYTHiFPC69I=",
      "api-key": "gAAAAABlQeFH4mLUV2P-6fW4z0AuVBEvLE2HDjechDbJBpXkOJoGj-xHW5D-JbNEurBxAKdiQgIdeQ91vhP59BXqJMpkfLeumUgSRygOqeROOx8hWwDfL1Nl9B9H7drTbV4t87yWMxvV"
    });
    print(url);
    print(response.body.toString());
    return GaipUserIdResponse.fromJson(jsonDecode(response.body));
  }
}