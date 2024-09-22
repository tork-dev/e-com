import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/spinner_wheel/model/spinner_coupon_list_response.dart';
import 'package:kirei/src/features/spinner_wheel/model/spinner_coupon_response.dart';
import 'package:kirei/src/features/spinner_wheel/repositories/spinner_repositories.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';

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



 Future<void>getSpinnerCouponList() async{
  spinnerCouponList.value = await SpinnerRepositories().getCouponList();
  for (var item in spinnerCouponList.value.data!) {
   couponList.add('${item.discount}% Off');
   couponCodeList.add(item.couponCode.toString());
  }
}

Future<void> getSelectedCouponResponse(accessToken) async{
  selectedCouponResponse.value = await SpinnerRepositories().getSelectedCoupon(accessToken);

  if(selectedCouponResponse.value.result == true) {
   print('got coupon from backend ${selectedCouponResponse.value.data?.couponCode}');

   print(couponCodeList.indexOf(selectedCouponResponse.value.data?.couponCode));

   selectedIndex.value =
       couponCodeList.indexOf(selectedCouponResponse.value.data?.couponCode);

   selected.add(selectedIndex.value);
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
