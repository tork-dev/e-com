import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import '../../shop/model/shop_data_model.dart';
import '../model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchRepositories {
  Future<ProductMiniResponse> getSearchResponse(String searchKey) async {
    final response = await http.get(Uri.parse(
        "${AppApiEndPoints.shopProducts}search=$searchKey&gaip_user_id=null"));
    if (response.statusCode == 200) {
      //var responseBody = jsonDecode(response.body);
      //return ShopPageResponse.fromJson(jsonDecode(response.body));
      return productMiniResponseFromJson(response.body);
    } else {
      throw 'error';
    }
  }

  Future<ShopPageResponse> getSearchByImage(
      {required Uint8List imageBytes, required String imageName}) async {
    ///upload image for search product by multipart request
    Uri url = Uri.parse(AppApiEndPoints.imageSearch);
    var request = http.MultipartRequest('POST', url);

    var image =
        http.MultipartFile.fromBytes('image', imageBytes, filename: imageName);
    request.files.add(image);

    request.fields['order_by'] = "default";

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Error: ${response.reasonPhrase}');
    }
    return ShopPageResponse.fromJson(jsonDecode(response.body));
    //return jsonDecode(response.body);
  }

  /// Image Search base64
  Future<ProductMiniResponse> getImageSearch(
      {required String image, required String filename}) async {
    var postBody = jsonEncode({"image": image, "filename": filename});

    Uri url = Uri.parse(AppApiEndPoints.imageSearch);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          //"Authorization": "Bearer $accessToken",
        },
        body: postBody);

    return productMiniResponseFromJson(response.body);
  }
}
