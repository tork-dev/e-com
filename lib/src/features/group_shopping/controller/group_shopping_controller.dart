import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/group_shopping/model/group_shopping_products_model.dart';
import 'package:kirei/src/features/group_shopping/repositories/group_shopping_repositories.dart';
import '../../../utils/constants/app_api_end_points.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../address/controller/address_controller.dart';
import '../../address/model/address_city_model.dart';
import '../../address/model/area_response.dart';
import '../../address/model/zone_response.dart';
import '../../address/repositories/address_repositories.dart';
import '../model/group_checkout_model.dart';
import '../model/group_shopping_groups.dart';
import '../view/widgets/bkash_screen_group.dart';
import '../view/widgets/ssl_screen_group.dart';

class GroupShoppingController extends GetxController {
  static GroupShoppingController get instance => Get.find();

  RxBool hittingGroupApi = false.obs;
  RxBool hittingProductApi = false.obs;
  final addressController = Get.put(AddressController());


  Rx<GroupShoppingProductsResponse> groupShoppingProduct =
      GroupShoppingProductsResponse().obs;
  Rx<GroupShoppingGroupsResponse> groupShoppingGroup =
      GroupShoppingGroupsResponse().obs;

  Rx<CityResponse> cityList = CityResponse().obs;
  Rx<ZoneResponse> zoneList = ZoneResponse().obs;
  Rx<AreaResponse> areaList = AreaResponse().obs;
  TextEditingController noteController = TextEditingController();
  RxString selectedPaymentMethod = 'bkash'.obs;
  Rx<GroupShoppingCheckoutResponse> checkoutResponse =
      GroupShoppingCheckoutResponse().obs;

  final ScrollController scrollController = ScrollController();

  Rxn<DateTime> endTime = Rxn<DateTime>();

  RxString remainingTime = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    print('refresh');
    getProducts();
    getGroups();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      400,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> getProducts() async {
    hittingProductApi.value = true;
    groupShoppingProduct.value =
    await GroupShoppingRepo().getGroupShoppingProducts();
    hittingProductApi.value = false;
  }

  Future<void> getGroups() async{
    hittingGroupApi.value = true;
    groupShoppingGroup.value =
    await GroupShoppingRepo().getGroupShoppingGroups();
    hittingGroupApi.value = false;
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
    // addressController.validateForm();
    checkoutResponse.value = await GroupShoppingRepo().createAGroup(
        AppApiEndPoints.createGroup,
        productId,
        selectedPaymentMethod.value,
        addressController.nameController.text.toString(),
        addressController.phoneController.text.toString(),
        addressController.addressController.text.toString(),
        addressController.selectedCityId.value,
        addressController.selectedZoneId.value,
        addressController.selectedAreaId.value,
        noteController.text.toString());

    AppHelperFunctions.showToast(checkoutResponse.value.message!);
    if(selectedPaymentMethod.value == "ssl"){
      Get.to(()=> GroupSslCommerzScreen(sslInitialUrl: checkoutResponse.value.data!.paymentUrl!));
    }else{
      Get.to(()=> GroupBkashScreen(bkashInitialUrl: checkoutResponse.value.data!.paymentUrl!));
    }
  }

  Future<void> joinGroup(token, productId) async {
    checkoutResponse.value = await GroupShoppingRepo().createAGroup(
        '${AppApiEndPoints.joinGroup}/$token',
        productId,
        selectedPaymentMethod.value,
        addressController.nameController.text.toString(),
        addressController.phoneController.text.toString(),
        addressController.addressController.text.toString(),
        addressController.selectedCityId.value,
        addressController.selectedZoneId.value,
        addressController.selectedAreaId.value,
        noteController.text.toString());
    AppHelperFunctions.showToast(checkoutResponse.value.message!);

    if(selectedPaymentMethod.value == "ssl"){
      Get.to(()=> GroupSslCommerzScreen(sslInitialUrl: checkoutResponse.value.data!.paymentUrl!));
    }else{
      Get.to(()=> GroupBkashScreen(bkashInitialUrl: checkoutResponse.value.data!.paymentUrl!));
    }
  }

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
    DateTime now = DateTime.now();
    Duration difference = endTime.difference(now);

    if (difference.isNegative) {
      remainingTime.value = "Time's up!";
      stopCountdown(); // Stop the timer when the countdown ends
    } else {
      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);

      remainingTime.value = '${hours.toString().padLeft(2, '0')}h:'
          '${minutes.toString().padLeft(2, '0')}m:'
          '${seconds.toString().padLeft(2, '0')}s';
    }
  }

  @override
  void onClose() {
    stopCountdown(); // Clean up the timer when the controller is destroyed
    super.onClose();
  }
}
