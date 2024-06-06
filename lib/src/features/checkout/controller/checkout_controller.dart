import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:torganic/src/features/cart/model/cart_get_response_model.dart';
import 'package:torganic/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:torganic/src/features/checkout/model/coupon_apply_model.dart';
import 'package:torganic/src/features/checkout/model/coupon_remove_model.dart';
import 'package:torganic/src/features/checkout/model/order_create_model.dart';
import 'package:torganic/src/features/checkout/model/payment_types_model.dart';
import 'package:torganic/src/features/checkout/repositories/checkout_repositories.dart';
import 'package:torganic/src/features/checkout/view/order_status_page.dart';
import 'package:torganic/src/utils/helpers/helper_functions.dart';
import 'package:torganic/src/features/address/controller/address_controller.dart';
import 'package:torganic/src/utils/local_storage/local_storage_keys.dart';
import 'package:torganic/src/utils/local_storage/storage_utility.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  CheckoutController(
      {required this.allCartProducts,
      required this.productIdsString,
      required this.productQuantitiesString});

  final addressController = Get.put(AddressController());

  Rx<CheckoutSummaryResponse> checkoutSummary = CheckoutSummaryResponse().obs;
  RxList<PaymentMethodResponse> paymentMethods = <PaymentMethodResponse>[].obs;
  List<CartItemGetResponse> allCartProducts = <CartItemGetResponse>[].obs;
  Rx<CouponResponse> couponResponse = CouponResponse().obs;
  Rx<CouponRemoveResponse> couponRemoveResponse = CouponRemoveResponse().obs;
  Rx<OrderCreateResponse> orderCreateResponse = OrderCreateResponse().obs;

  TextEditingController couponController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  RxInt selectedPaymentMethod = 0.obs;
  RxString selectedPaymentMethodName = 'cash_on_delivery'.obs;
  RxBool isTermsChecked = false.obs;
  String productIdsString;
  String productQuantitiesString;
  RxBool isAddressAvailable = false.obs;
  RxBool isCouponApplied = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    print('refresh');
    await getCheckoutSummary();
    getPaymentMethods();
    AppHelperFunctions.showToast('Cart Updated');
    addressAvailabilityCheck();
  }

  bool addressAvailabilityCheck() {
    if (addressController.nameController.text == "Guest" ||
        addressController.addressController.text == "") {
      return isAddressAvailable.value = false;
    } else {
      return isAddressAvailable.value = true;
    }
  }

  Future<CheckoutSummaryResponse> getCheckoutSummary() async {
    return checkoutSummary.value =
        await CheckoutRepositories().getCartSummaryResponse();
  }

  Future<List<PaymentMethodResponse>> getPaymentMethods() async {
    return paymentMethods.value =
        await CheckoutRepositories().getPaymentMethods();
  }

  /// Coupon Apply
  Future<CouponResponse> getCouponAppliedResponse() async {
    return couponResponse.value = await CheckoutRepositories()
        .getCouponApplyResponse(couponCode: couponController.text.toString());
  }

  Future<void> onCouponApplied()async{
    if(couponController.text == ''){
      AppHelperFunctions.showToast('Please enter a coupon code');
      return;
    }
    await getCouponAppliedResponse();
    if(couponResponse.value.result == true){
      AppHelperFunctions.showToast(couponResponse.value.message!);
      isCouponApplied.value = true;
    }
  }

  /// Coupon Remove
  Future<CouponRemoveResponse> getCouponRemoveResponse() async{
    return couponRemoveResponse.value = await CheckoutRepositories().getCouponRemoveResponse();
  }

  Future<void> onCouponRemove() async{
    await getCouponRemoveResponse();
    if(couponRemoveResponse.value.result == true){
      AppHelperFunctions.showToast(couponRemoveResponse.value.message!);
      isCouponApplied.value = false;
      couponController.clear();
      return;
    }
  }

  /// Crete Order Method
  Future<void> onPressProceedToCheckout() async {
    if (!await validateCheckoutDetails()) return;

    Map<String, dynamic> requestBody = prepareRequestBody();

    try {
      print('_selected_payment_method $selectedPaymentMethod');
      print('this is my Order request' + requestBody.toString());

      orderCreateResponse.value = await CheckoutRepositories().getOrderCreateResponseFromCod(requestBody: requestBody);

      // Check if the widget is mounted before updating the UI
      if (orderCreateResponse.value.result == true) {
        AppHelperFunctions.showToast(orderCreateResponse.value.message!);
        Get.offAll(() => AppOrderStatusScreen(status: orderCreateResponse.value.message!));
        return;
      }

      // Additional logic for payment handling can be added here

    } catch (e) {
      print('Error in onPressProceed: $e');
      // Handle the error appropriately, e.g., show a dialog or log it.
    }
  }

  Future<bool> validateCheckoutDetails() async {
    if (checkoutSummary.value.grandTotalValue == 0.00) {
      AppHelperFunctions.showToast('Nothing to pay');
      return false;
    }

    if (selectedPaymentMethodName.value == "") {
      AppHelperFunctions.showToast('Please select a payment method');
      return false;
    }

    if (isTermsChecked.value == false) {
      AppHelperFunctions.showToast("Please agree to the terms and conditions");
      return false;
    }

    if (addressController.nameController.text == "" || addressController.nameController.text.isEmpty) {
      AppHelperFunctions.showToast('Name is required');
      return false;
    }

    if (addressController.phoneController.text == "" || addressController.phoneController.text.isEmpty) {
      AppHelperFunctions.showToast('Phone is required');
      return false;
    } else if (addressController.phoneController.text.length > 11 ||
        addressController.phoneController.text.length < 11 ||
        !addressController.phoneController.text.startsWith("0")) {
      AppHelperFunctions.showToast('Invalid Phone');
      return false;
    }

    if (addressController.addressController.text == "" || addressController.addressController.text.isEmpty) {
      AppHelperFunctions.showToast('Address is required');
      return false;
    } else if (addressController.addressController.value.text.length < 10) {
      AppHelperFunctions.showToast('Address must be at least 10 characters');
      return false;
    }

    if (addressController.selectedCityName.text == "" || addressController.selectedCityName.text.isEmpty) {
      AppHelperFunctions.showToast('City is required');
      return false;
    }

    if (addressController.selectedZoneName.text == "" || addressController.selectedZoneName.text.isEmpty) {
      AppHelperFunctions.showToast('Zone is required');
      return false;
    }

    if (addressController.selectedAreaName.text == "" || addressController.selectedAreaName.text.isEmpty) {
      AppHelperFunctions.showToast('Area is required');
      return false;
    }

    return true;
  }

  Map<String, dynamic> prepareRequestBody() {
    List<String> productIdsStringsArr = productIdsString.split(',');
    List<int> productIds = productIdsStringsArr.map(int.parse).toList();

    List<String> productQuantitiesStrings = productQuantitiesString.split(',');
    List<int> productQuantities = productQuantitiesStrings.map(int.parse).toList();

    String productIdsJsonArray = "[${productIds.join(',')}]";
    String productQuantitiesJsonArray = "[${productQuantities.join(',')}]";
    var couponCode = couponController.text.toString();

    Map<String, dynamic> requestBody = {
      "product_ids_arr": productIdsJsonArray,
      "product_quantities_arr": productQuantitiesJsonArray,
      "shipping_address": addressController.addressController.text,
      "shipping_name": addressController.nameController.text,
      "shipping_phone": addressController.phoneController.text,
      "shipping_city_id": addressController.selectedCityId.value,
      "shipping_zone_id": addressController.selectedZoneId.value,
      "shipping_area_id": addressController.selectedAreaId.value,
      "is_preorder": allCartProducts[0].cartItems![0].isPreorder,
      "payment_type": selectedPaymentMethodName.value,
      "note": notesController.text,
      "type": 'app',
      "version": "${AppLocalStorage().readData(LocalStorageKeys.appVersion)}",
      "coupon_code": couponCode,
    };

    return requestBody;
  }

}
