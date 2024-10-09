import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/group_shopping/model/group_shopping_products_model.dart';
import 'package:kirei/src/features/group_shopping/repositories/group_shopping_repositories.dart';

import '../../../utils/constants/app_api_end_points.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../address/model/address_city_model.dart';
import '../../address/model/area_response.dart';
import '../../address/model/zone_response.dart';
import '../../address/repositories/address_repositories.dart';
import '../model/group_checkout_model.dart';
import '../model/group_shopping_groups.dart';

class GroupShoppingController extends GetxController{
  static GroupShoppingController get instance => Get.find();

  RxBool hittingApi = false.obs;

  Rx<GroupShoppingProductsResponse> groupShoppingProduct = GroupShoppingProductsResponse().obs;
  Rx<GroupShoppingGroupsResponse> groupShoppingGroup = GroupShoppingGroupsResponse().obs;

  Rx<CityResponse> cityList = CityResponse().obs;
  Rx<ZoneResponse> zoneList = ZoneResponse().obs;
  Rx<AreaResponse> areaList = AreaResponse().obs;
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
  TextEditingController noteController = TextEditingController();
  RxString selectedPaymentMethod = 'bksah'.obs;
  Rx<GroupShoppingCheckoutResponse> checkoutResponse =
      GroupShoppingCheckoutResponse().obs;

  final ScrollController scrollController = ScrollController();

  Rx<DateTime> endTime = DateTime.now().obs;



  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh()async{
    print('refresh');
    getProducts();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      400,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> getProducts() async{
    hittingApi.value = true;
    groupShoppingProduct.value = await GroupShoppingRepo().getGroupShoppingProducts();
    groupShoppingGroup.value = await GroupShoppingRepo().getGroupShoppingGroups();
    hittingApi.value = false;
    hittingApi.value = false;
    startCountdown(endTime.value);
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



  Future<void> createGroup(productId) async {
    checkoutResponse.value = await GroupShoppingRepo().createAGroup(
        AppApiEndPoints.createGroup,
        productId,
        selectedPaymentMethod.value,
        nameController.text.toString(),
        phoneController.text.toString(),
        addressController.text.toString(),
        selectedCityId.value,
        selectedZoneId.value,
        selectedAreaId.value,
        noteController.text.toString());
    Get.back();
    AppHelperFunctions.showToast(checkoutResponse.value.message!);
  }


  Future<void> joinGroup(token, productId) async {
    checkoutResponse.value = await GroupShoppingRepo().createAGroup(
        '${AppApiEndPoints.joinGroup}/$token',
        productId,
        selectedPaymentMethod.value,
        nameController.text.toString(),
        phoneController.text.toString(),
        addressController.text.toString(),
        selectedCityId.value,
        selectedZoneId.value,
        selectedAreaId.value,
        noteController.text.toString());
    AppHelperFunctions.showToast(checkoutResponse.value.message!);
  }


  RxString remainingTime = ''.obs;
  Timer? _timer;

  // Method to start the countdown
  void startCountdown(DateTime endTime) {
    _updateRemainingTime(endTime); // Update initially

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime(endTime);
    });
  }

  // Method to stop the countdown
  void stopCountdown() {
    _timer?.cancel();
  }

  // Helper function to calculate remaining time and update the string
  void _updateRemainingTime(DateTime endTime) {
    Duration difference = endTime.difference(DateTime.now());

    if (difference.isNegative) {
      remainingTime.value = "Time's up!";
      stopCountdown(); // Stop the timer when the countdown ends
    } else {
      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);

      remainingTime.value = '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  void onClose() {
    stopCountdown(); // Clean up the timer when the controller is destroyed
    super.onClose();
  }




}