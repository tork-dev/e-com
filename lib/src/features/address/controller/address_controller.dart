import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
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
  RxString selectedCityName = ''.obs;
  RxString selectedZoneName = ''.obs;
  RxString selectedAreaName = ''.obs;
  RxBool hittingApi = true.obs;
  RxBool zoneFocus = false.obs;
  RxBool focusArea = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController selectedCityController = TextEditingController();
  TextEditingController selectedZoneController = TextEditingController();
  TextEditingController selectedAreaController = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    await getShippingAddress();
    if (shippingAddress.value.data != null) {
      setAddress();
    }
    getCityList();
    print('refresh');
  }

  Future<void> getShippingAddress() async {
    hittingApi.value = true;
    shippingAddress.value = await AddressRepositories().getAddressList();
    hittingApi.value = false;
  }

  void setAddress() {
    nameController.text = shippingAddress.value.data![0].name!;
    phoneController.text = shippingAddress.value.data![0].phone!;
    emailController.text = shippingAddress.value.data![0].email ?? '';
    addressController.text = shippingAddress.value.data![0].address!;
    selectedCityName.value = shippingAddress.value.data![0].cityName!;
    selectedCityId.value = shippingAddress.value.data![0].cityId!;
    selectedZoneName.value = shippingAddress.value.data![0].zoneName!;
    selectedZoneId.value = shippingAddress.value.data![0].zoneId!;
    selectedAreaName.value = shippingAddress.value.data![0].areaName!;
    selectedAreaId.value = shippingAddress.value.data![0].areaId!;
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

  Future<void> onPressSave() async {
    if (nameController.text == "") {
      AppHelperFunctions.showToast('Name is required');
      return;
    }

    if (phoneController.text == "") {
      AppHelperFunctions.showToast('Phone is required');
      return;
    } else if (phoneController.text.length > 11) {
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    } else if (phoneController.text.length < 11) {
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    } else if (!phoneController.text.startsWith("0")) {
      AppHelperFunctions.showToast('Invalid Phone');
      return;
    }

    if (addressController.text == "") {
      AppHelperFunctions.showToast('Address is required');
      return;
    } else if (addressController.value.text.length < 10) {
      AppHelperFunctions.showToast('Address have to be minimum 10 character');
      return;
    }

    if (selectedCityName.value == "") {
      AppHelperFunctions.showToast('City is required');
      return;
    }

    if (selectedZoneName.value == "") {
      AppHelperFunctions.showToast('Zone is required');
      return;
    }

    if (emailController.text.toString().isNotEmpty) {
      if (!addressFormKey.currentState!.validate()) {
        return;
      }
    }

    createOrUpdateAddress.value =
        await AddressRepositories().getAddressAddResponse(
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
    if (createOrUpdateAddress.value.result == true) {
      Get.back();
    }
  }

// List getFilteredData(String query, filterFunction) {
//   return dataList.where((item) => filterFunction(item, query)).toList();
// }
}
