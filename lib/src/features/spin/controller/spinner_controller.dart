import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/spinner_coupon_list_response.dart';
import '../model/spinner_coupon_response.dart';
import '../repositories/spinner_repositories.dart';


class SaleSpinnerController extends GetxController {
 static SaleSpinnerController get instance => Get.find<SaleSpinnerController>();

 /// TextEditingController
 final phoneNumberController = TextEditingController();

 /// StreamController with broadcast
 StreamController<int> selected = StreamController<int>();

 ///selected Coupon
 RxInt selectedIndex = 0.obs;
 RxString selectedCoupon = ''.obs;
 Rx<SaleSpinnerCouponList> spinnerCouponList = SaleSpinnerCouponList().obs;
 Rx<SaleSpinnerCouponResponse> selectedCouponResponse = SaleSpinnerCouponResponse().obs;
 RxList<String> couponList = <String>[].obs;
 RxList<String> couponCodeList = <String>[].obs;
 RxBool isLoading = false.obs;

 @override
  void onInit() {
    super.onInit();
    getSpinnerCouponList();
  }



 Future<void>getSpinnerCouponList() async{
   isLoading.value = true;
  spinnerCouponList.value = await SaleSpinnerRepositories().getCouponList();
  for (var item in spinnerCouponList.value.data!) {
   couponList.add('${item.title}');
   couponCodeList.add(item.couponCode.toString());
  }
  isLoading.value = false;
}

Future<void> getSelectedCouponResponse() async{
  selectedCouponResponse.value = await SaleSpinnerRepositories().getSelectedCoupon();
   selectedIndex.value =
       couponCodeList.indexOf(selectedCouponResponse.value.data?.couponCode);

   selected.add(selectedIndex.value);
}

 @override
 void onClose() {
  // Close the stream to prevent memory leaks
  selected.close();
  phoneNumberController.clear();
  super.onClose();
 }

}
