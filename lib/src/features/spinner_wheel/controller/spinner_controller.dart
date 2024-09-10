import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
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

 final items = <String>[
  '20%',
  '30%',
  '10%',
  '5%',
  '50%',
  '3%',
 ];

 @override
 void onClose() {
  // Close the stream to prevent memory leaks
  selected.close();
  phoneNumberController.clear();
  super.onClose();
 }

 Future<void> tryLuck() async {
  if (!phoneKey.currentState!.validate()) return;
  if (!isChecked.value) {
   AppHelperFunctions.showToast('Please agree to the terms and condition');
   return;
  }

  selectedIndex.value = Fortune.randomInt(0, 2);
  selected.add(selectedIndex.value);
 }
}
