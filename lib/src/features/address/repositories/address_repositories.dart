import 'dart:convert';

import 'package:kirei/src/features/address/model/address_create_model.dart';
import 'package:kirei/src/features/address/model/address_model.dart';
import 'package:kirei/src/features/address/model/area_response.dart';
import 'package:kirei/src/features/address/model/zone_response.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/address_city_model.dart';
import 'package:http/http.dart' as http;

import '../model/order_address_change.dart';

class AddressRepositories{

  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);
  final version = AppLocalStorage().readData(LocalStorageKeys.appVersion);

  Future<CityResponse> getCities() async{
    final response = await http.get(Uri.parse(AppApiEndPoints.cityAddresses));

    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return CityResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }

  Future<ZoneResponse> getZones(int cityId) async{
    final response = await http.get(Uri.parse('${AppApiEndPoints.zoneAddresses}/$cityId'));

    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return ZoneResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }

  Future<AreaResponse> getAreas(int zoneId) async{
    final response = await http.get(Uri.parse('${AppApiEndPoints.areaAddresses}/$zoneId'));

    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      return AreaResponse.fromJson(responseBody);
    }else{
      throw Error();
    }
  }


  Future<AddressCreateResponse> getAddressAddResponse({
    required String address,
    required String area,
    required String zone,
    required String city,
    required String phone,
    required String name,
    required String email,
  }) async {
    var postBody = jsonEncode({
      "address": address,
      "area_id": area,
      "zone_id": zone,
      "city_id": city,
      "phone": phone,
      "name": name,
      "email": email,
      "version" : version
    });

    print("Request Body: $postBody");

    Uri url = Uri.parse(AppApiEndPoints.shippingAddressCreateOrUpdate);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: postBody,
    );

    print("Request URL: $url");
    print("Request Headers: ${response.request?.headers}");
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return AddressCreateResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create address. Status code: ${response.statusCode}');
    }
  }

  Future<AddressResponse> getAddressList() async {
    Uri url = Uri.parse(AppApiEndPoints.shippingAddress);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    print("response.body.toString()${response.body.toString()}");
    return AddressResponse.fromJson(response.body);

  }

  Future<ShippingResponse> getOrderProcessAddressUpdateResponse(
      {required int orderId,
        required String shippingName,
        required String shippingAddress,
        required int shippingAreaId,
        required int shippingCityId,
        required int shippingZoneId,
        required String shippingPhone}) async {
    var postBody = jsonEncode({
      "shipping_name" : shippingName,
      "shipping_address": shippingAddress,
      "shipping_area_id": shippingAreaId,
      "shipping_city_id": shippingCityId,
      "shipping_zone_id": shippingZoneId,
      "shipping_phone": shippingPhone
    });

    Uri url = Uri.parse("${AppApiEndPoints.changeOrderAddresses}$orderId");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);
    print(response.body.toString());
    print("URL:$url");
    return shippingResponseFromJson(response.body);
    //return addressUpdateResponseFromJson(response.body);
  }
}