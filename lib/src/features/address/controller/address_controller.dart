import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kirei/src/features/address/model/address_city_model.dart';
import 'package:kirei/src/features/address/model/address_create_model.dart';
import 'package:kirei/src/features/address/model/address_model.dart';
import 'package:kirei/src/features/address/model/area_response.dart';
import 'package:kirei/src/features/address/model/zone_response.dart';
import 'package:kirei/src/features/address/repositories/address_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  Rx<CityResponse> cityList = CityResponse().obs;
  Rx<ZoneResponse> zoneList = ZoneResponse().obs;
  Rx<AreaResponse> areaList = AreaResponse().obs;
  Rx<AddressResponse> shippingAddress = AddressResponse().obs;
  Rx<AddressCreateResponse> createOrUpdateAddress = AddressCreateResponse().obs;
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

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    await getShippingAddress();
    if(shippingAddress.value.data != null){
    setAddress();
    }
    getCityList();
    print('refresh');
  }

  Future<AddressResponse> getShippingAddress()async{
    return shippingAddress.value = await AddressRepositories().getAddressList();
  }

  void setAddress(){
    nameController.text = shippingAddress.value.data![0].name!;
    phoneController.text = shippingAddress.value.data![0].phone!;
    emailController.text = shippingAddress.value.data![0].email!;
    addressController.text = shippingAddress.value.data![0].address!;
    selectedCityName.text = shippingAddress.value.data![0].cityName!;
    selectedCityId.value = shippingAddress.value.data![0].cityId!;
    selectedZoneName.text = shippingAddress.value.data![0].zoneName!;
    selectedZoneId.value = shippingAddress.value.data![0].zoneId!;
    selectedAreaName.text = shippingAddress.value.data![0].areaName!;
    selectedAreaId.value = shippingAddress.value.data![0].areaId!;
  }

  Future<void> getCityList() async {
    if (cityList.value.cities == null) {
      try {
        cityList.value = await AddressRepositories().getCities();
      } catch (e) {
        print('Error fetching cities: $e');
        // Handle error as needed
      }
    }
  }

  Future<void> getZoneList(int selectedCityId) async {
    if (zoneList.value.data == null || zoneList.value.data!.zones == null) {
      try {
        zoneList.value = await AddressRepositories().getZones(selectedCityId);
      } catch (e) {
        print('Error fetching zones: $e');
        // Handle error as needed
      }
    }
  }

  Future<void> getAreaList(int selectedZoneId) async {
    if (areaList.value.areas == null) {
      try {
        areaList.value = await AddressRepositories().getAreas(selectedZoneId);
      } catch (e) {
        print('Error fetching areas: $e');
        // Handle error as needed
      }
    }
  }


  Future<void> onPressSave() async {
    if (nameController.text == "") {
      AppHelperFunctions.showToast('Name  is required');
      return;
    }

    if (phoneController.text == "") {
      AppHelperFunctions.showToast('Phone is required');
      return;
    } else if(phoneController.text.length > 11){
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    } else if(phoneController.text.length < 11){
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    }else if(!phoneController.text.startsWith("0")){
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    }

    if (addressController.text == "") {
      AppHelperFunctions.showToast('Address is required');
      return;
    } else if(addressController.value.text.length < 10) {
      AppHelperFunctions.showToast('Address have to be minimum 10 character');
      return;
    }

    if ( selectedCityName.text == "") {
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

    createOrUpdateAddress.value = await AddressRepositories()
        .getAddressAddResponse(
      name: nameController.value.text,
      phone: phoneController.text,
      email: emailController.text,
      address: addressController.value.text,
      city: selectedCityId.value.toString(),
      zone: selectedZoneId.toString(),
      area: selectedAreaId.toString(),
    );

    if (createOrUpdateAddress.value.result == false) {
      AppHelperFunctions.showToast(createOrUpdateAddress.value.message!);
      return;
    }
    AppHelperFunctions.showToast(createOrUpdateAddress.value.message!);

    onRefresh();
  }

// List getFilteredData(String query, filterFunction) {
//   return dataList.where((item) => filterFunction(item, query)).toList();
// }
}
