import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/purchase_history/model/purchase_history_details_model.dart';
import 'package:kirei/src/features/purchase_history/repositories/purchase_history_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../../utils/logging/logger.dart';
import '../../address/model/address_city_model.dart';
import '../../address/model/address_create_model.dart';
import '../../address/model/address_model.dart';
import '../../address/model/area_response.dart';
import '../../address/model/order_address_change.dart';
import '../../address/model/zone_response.dart';
import '../../address/repositories/address_repositories.dart';
import '../model/order_history_model.dart';
import '../model/product_history_items_model.dart';

class PurchaseHistoryDetailsController extends GetxController {
  static PurchaseHistoryDetailsController get instance => Get.find();

  // Rx<PurchaseHistoryDetailsResponse> purchaseHistoryDetails =
  //     PurchaseHistoryDetailsResponse().obs;
  // Rx<PurchaseHistoryItemsResponse> purchaseHistoryItemDetails =
  //     PurchaseHistoryItemsResponse().obs;

  Rx<OrderDetailsResponseModel> orderDetailsData = OrderDetailsResponseModel().obs;

  RxInt isAuthentic = 1.obs;
  TextEditingController noteController = TextEditingController();

  Rx<CityResponse> cityList = CityResponse().obs;
  Rx<ZoneResponse> zoneList = ZoneResponse().obs;
  Rx<AreaResponse> areaList = AreaResponse().obs;
  Rx<AddressResponse> shippingAddress = AddressResponse().obs;
  Rx<AddressCreateResponse> createOrUpdateAddress = AddressCreateResponse().obs;
  Rx<ShippingResponse> changedResponse = ShippingResponse().obs;

  RxInt selectedCityId = 0.obs;
  RxInt selectedZoneId = 0.obs;
  RxInt selectedAreaId = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController selectedCityName = TextEditingController();
  TextEditingController selectedZoneName = TextEditingController();
  TextEditingController selectedAreaName = TextEditingController();


  Future onRefresh(int orderId) async {
     // await getPurchaseHistoryDetails(orderId);
     // await getPurchaseHistoryItemDetails(orderId);
    await getOrderDetails(orderId);
    setAddress();
  }

  void setAddress(){
    nameController.text = orderDetailsData.value.shippingAddress!.name!;
    phoneController.text = orderDetailsData.value.shippingAddress!.phone!;
    emailController.text = orderDetailsData.value.shippingAddress!.email ?? '';
    addressController.text = orderDetailsData.value.shippingAddress!.address!;
    selectedCityName.text = orderDetailsData.value.shippingAddress!.state!;
    selectedCityId.value = orderDetailsData.value.shippingAddress!.cityId!;
    selectedZoneName.text = orderDetailsData.value.shippingAddress!.city!;
    selectedZoneId.value = orderDetailsData.value.shippingAddress!.zoneId!;
    selectedAreaName.text = orderDetailsData.value.shippingAddress!.area!;
    selectedAreaId.value = orderDetailsData.value.shippingAddress!.areaId!;
  }


  Future<CityResponse> getCityList() async {
    return cityList.value = await AddressRepositories().getCities();
  }

  Future<ZoneResponse> getZoneList(int selectedCityId) async {
    return zoneList.value =
    await AddressRepositories().getZones(selectedCityId);
  }

  Future<AreaResponse> getAreaList(int selectedZoneId) async {
    return areaList.value =
    await AddressRepositories().getAreas(selectedZoneId);
  }

  // Future<PurchaseHistoryDetailsResponse> getPurchaseHistoryDetails(int orderId) async {
  //   return purchaseHistoryDetails.value =
  //       await PurchaseHistoryRepositories().getPurchaseHistoryDetails(orderId);
  // }
  //
  // Future<PurchaseHistoryItemsResponse> getPurchaseHistoryItemDetails(int orderId) async {
  //   return purchaseHistoryItemDetails.value =
  //   await PurchaseHistoryRepositories().getPurchaseHistoryItemDetails(orderId);
  // }

  Future<OrderDetailsResponseModel> getOrderDetails(int orderId) async {
    return orderDetailsData.value =
    await PurchaseHistoryRepositories().getOrderDetails(orderId);
  }


  Future<void> processOrderAddressUpdate(int orderId)async{

    try{
      if (nameController.text == "") {
       AppHelperFunctions.showToast('Name  is required');
        return;
      }

      if (phoneController.text == "") {
        AppHelperFunctions.showToast('Phone  is required');
        return;
      } else if(phoneController.text.length != 11){
        AppHelperFunctions.showToast('Invalid Phone');
        return;
      }
      else if(!phoneController.text.startsWith("0")){
        AppHelperFunctions.showToast('Invalid Phone');
        return;
      }

      if (addressController.text == "") {
        AppHelperFunctions.showToast('Address is required');
        return;
      } else if(addressController.text.length < 10) {
        AppHelperFunctions.showToast('Address have to be minimum 10 character');
        return;
      }

      if (selectedCityName.text == "") {
        AppHelperFunctions.showToast('City is required');
        return;
      }

      if (selectedZoneName.text == "") {
        AppHelperFunctions.showToast('Zone is required');
        return;
      }
      if (selectedAreaName.text == "") {
        AppHelperFunctions.showToast('Area is required');
        return;
      }

      changedResponse.value = await AddressRepositories().getOrderProcessAddressUpdateResponse(
        orderId: orderId,
        shippingName: nameController.text,
        shippingAddress: addressController.text,
        shippingCityId: selectedCityId.value,
        shippingZoneId: selectedZoneId.value,
        shippingAreaId: selectedAreaId.value ,
        shippingPhone: phoneController.text,
      );
      await onRefresh(orderId);
      AppHelperFunctions.showToast(changedResponse.value.message!);
    } on Exception catch(e){
      Log.d("error is .... ${e.toString()}");
    } catch(e){
      Log.d("e is ${e.toString()}");
    }
  }



}
