import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/spinner_wheel/model/spinner_coupon_list_response.dart';
import 'package:kirei/src/features/spinner_wheel/model/spinner_coupon_response.dart';
import 'package:kirei/src/features/spinner_wheel/repositories/spinner_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class SpinnerController extends GetxController {
 static SpinnerController get instance => Get.find<SpinnerController>();

 /// TextEditingController
 final phoneNumberController = TextEditingController();

 /// StreamController with broadcast
 StreamController<int> selected = StreamController<int>();

 /// formKey
 GlobalKey<FormState> phoneKey = GlobalKey<FormState>();

 /// Checkbox value
 RxBool isChecked = false.obs;

 ///selected Coupon
 RxInt selectedIndex = 0.obs;
 RxString selectedCoupon = ''.obs;
 Rx<SpinnerCouponList> spinnerCouponList = SpinnerCouponList().obs;
 Rx<SpinnerCouponResponse> selectedCouponResponse = SpinnerCouponResponse().obs;
 RxList<String> couponList = <String>[].obs;
 RxList<String> couponCodeList = <String>[].obs;

 @override
  void onInit() {
    super.onInit();
    getSpinnerCouponList();
  }


  // final items = <String>[
 //  '20%',
 //  '30%',
 //  '10%',
 //  '5%',
 //  '50%',
 //  '3%',
 // ];



 Future<void>getSpinnerCouponList() async{
  spinnerCouponList.value = await SpinnerRepositories().getCouponList();
  for (var item in spinnerCouponList.value.data!) {
   couponList.add('${item.discount}% Off');
   couponCodeList.add(item.couponCode.toString());
  }
  AppLocalStorage().saveData(LocalStorageKeys.sowedSpinner, true);

  print(couponList);
}

Future<void> getSelectedCouponResponse(accessToken) async{
  selectedCouponResponse.value = await SpinnerRepositories().getSelectedCoupon(accessToken);

  if(selectedCouponResponse.value.result == true) {
   selectedIndex.value =
       couponCodeList.indexOf(selectedCouponResponse.value.data?.couponCode);
  }else {
   Get.back();
   AppHelperFunctions.showSpinnerCoupon(
       title: selectedCouponResponse
           .value.data?.title ??
           '',
       subTitle:selectedCouponResponse
           .value
           .data
           ?.description ??
           '',
       imgUrl: selectedCouponResponse
           .value
           .data
           ?.image ??
           '');
  }
}

 @override
 void onClose() {
  // Close the stream to prevent memory leaks
  selected.close();
  phoneNumberController.clear();
  super.onClose();
 }

}
