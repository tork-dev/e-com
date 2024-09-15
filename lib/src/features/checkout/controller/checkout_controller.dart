import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/cart/model/cart_get_response_model.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/model/coupon_apply_model.dart';
import 'package:kirei/src/features/checkout/model/coupon_remove_model.dart';
import 'package:kirei/src/features/checkout/model/order_create_model.dart';
import 'package:kirei/src/features/checkout/model/payment_types_model.dart';
import 'package:kirei/src/features/checkout/repositories/checkout_repositories.dart';
import 'package:kirei/src/features/checkout/view/widget/bkash_screen.dart';
import 'package:kirei/src/features/checkout/view/order_status_page.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../../../common/widgets/buttons/app_buttons.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../view/widget/ssl_screen.dart';

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
  RxBool isLoading = false.obs;
  RxInt rewardBalance = 0.obs;
  RxInt redeemPoint = 0.obs;
  RxInt redeemedPoint = 0.obs;
  RxDouble grandTotal = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    print('refresh');
    await getCheckoutSummary();
    await getPaymentMethods();
    AppHelperFunctions.showToast('Cart Updated');
    addressAvailabilityCheck();
    getUserRewardBalance();
  }
  
  
  Future<void> getUserRewardBalance () async{
    final response = await http.get(Uri.parse(AppApiEndPoints.rewardPointBalance), headers: {
      'Authorization' : "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}"
    });
    rewardBalance.value = int.parse(response.body);
    print('this is balance : ${response.body}');
  }

  void addressAvailabilityCheck() {
    if (addressController.nameController.text == "Guest" ||
        addressController.addressController.text == "") {
      isAddressAvailable.value = false;
    } else {
      isAddressAvailable.value = true;
    }
  }

  Future<void> getCheckoutSummary() async {
    checkoutSummary.value =
        await CheckoutRepositories().getCartSummaryResponse();
    couponController.text = checkoutSummary.value.couponCode ?? '';
    isCouponApplied.value = checkoutSummary.value.couponApplied!;
    grandTotal.value = checkoutSummary.value.grandTotalValue;
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

  Future<void> onCouponApplied() async {
    if (couponController.text == '') {
      AppHelperFunctions.showToast('Please enter a coupon code');
      return;
    }
    await getCouponAppliedResponse();
    if (couponResponse.value.result == true) {
      getCheckoutSummary();
      isCouponApplied.value = true;
    }else{
      couponController.clear();
    }
    AppHelperFunctions.showToast(couponResponse.value.message!);
  }

  /// Coupon Remove
  Future<CouponRemoveResponse> getCouponRemoveResponse() async {
    return couponRemoveResponse.value =
        await CheckoutRepositories().getCouponRemoveResponse();
  }

  Future<void> onCouponRemove() async {
    await getCouponRemoveResponse();
    if (couponRemoveResponse.value.result == true) {
      isCouponApplied.value = false;
      getCheckoutSummary();
      couponController.clear();
    }
    AppHelperFunctions.showToast(couponRemoveResponse.value.message!);
  }

  /// Crete Order Method
  Future<void> onPressProceedToCheckout() async {

    if(!await validateCheckoutDetails()) return;


    isLoading.value = true;

    Map<String, dynamic> requestBody = prepareRequestBody();


    try {
      orderCreateResponse.value = await CheckoutRepositories()
          .getOrderCreateResponseFromCod(requestBody: requestBody);

      isLoading.value = false;

      if (selectedPaymentMethod.value == 1) {
        Get.offAll(() => BkashScreen(
            bkashInitialUrl: orderCreateResponse.value.data!.paymentUrl!,
            orderId: orderCreateResponse.value.data!.order!.id!));
        return;
      }
      if (selectedPaymentMethod.value == 2) {
        Get.offAll(() => SslCommerzScreen(
              orderId: orderCreateResponse.value.data!.order!.id!,
              sslInitialUrl: orderCreateResponse.value.data!.paymentUrl!,
              amount: orderCreateResponse.value.data!.order!.grandTotal!,
              paymentMethodKey: 'ssl',
              paymentType: orderCreateResponse.value.data!.order!.paymentType!,
            ));
        return;
      }
      // Check if the widget is mounted before updating the UI

      AppHelperFunctions.showToast(orderCreateResponse.value.message!);
      Get.offAll(() => AppOrderStatusScreen(
            statusString: orderCreateResponse.value.message!,
            status: orderCreateResponse.value.result ?? false,
            orderId: orderCreateResponse.value.data!.order!.id!,
          ));

      if(orderCreateResponse.value.result == true){
        final List<Map<String, dynamic>> items = allCartProducts[0].cartItems!.map((item) {
          return {
            'item_id': item.productId,
            'price': item.price,
            'quantity': item.quantity,
          };
        }).toList();

        EventLogger().logPurchaseEvent(jsonEncode(items), checkoutSummary.value.grandTotalValue);
      }

      // Additional logic for payment handling can be added here
    } catch (e) {
      print('Error in onPressProceed: $e');
      // Handle the error appropriately, e.g., show a dialog or log it.
    }
  }

  Future<bool> validateCheckoutDetails() async {
    // if (checkoutSummary.value.grandTotalValue == 0.00) {
    //   AppHelperFunctions.showToast('Nothing to pay');
    //   return false;
    // }

    if (selectedPaymentMethodName.value == "") {
      AppHelperFunctions.showToast('Please select a payment method');
      return false;
    }

    if (selectedPaymentMethodName.value == "bkash" &&
            checkoutSummary.value.grandTotalValue! < 1 ||
        selectedPaymentMethodName.value == "ssl" &&
            checkoutSummary.value.grandTotalValue! < 10.00) {
      AppHelperFunctions.showToast(
          'Minimum amount not reached. Please select cash on delivery');
      return false;
    }

    if (!isTermsChecked.value) {
      AppHelperFunctions.showToast("Please agree to the terms and conditions");
      return false;
    }

    if (addressController.nameController.text == "" ||
        addressController.nameController.text.isEmpty) {
      AppHelperFunctions.showToast('Name is required');
      return false;
    }

    if (addressController.phoneController.text == "" ||
        addressController.phoneController.text.isEmpty) {
      AppHelperFunctions.showToast('Phone is required');
      return false;
    } else if (addressController.phoneController.text.length > 11 ||
        addressController.phoneController.text.length < 11 ||
        !addressController.phoneController.text.startsWith("0")) {
      AppHelperFunctions.showToast('Invalid Phone');
      return false;
    }

    if (addressController.addressController.text == "" ||
        addressController.addressController.text.isEmpty) {
      AppHelperFunctions.showToast('Address is required');
      return false;
    } else if (addressController.addressController.value.text.length < 10) {
      AppHelperFunctions.showToast('Address must be at least 10 characters');
      return false;
    }

    if (addressController.selectedCityName.text == "" ||
        addressController.selectedCityName.text.isEmpty) {
      AppHelperFunctions.showToast('City is required');
      return false;
    }

    if (addressController.selectedZoneName.text == "" ||
        addressController.selectedZoneName.text.isEmpty) {
      AppHelperFunctions.showToast('Zone is required');
      return false;
    }

    if (addressController.selectedAreaName.text == "" ||
        addressController.selectedAreaName.text.isEmpty) {
      AppHelperFunctions.showToast('Area is required');
      return false;
    }

    return true;
  }

  Map<String, dynamic> prepareRequestBody() {
    List<String> productIdsStringsArr = productIdsString.split(',');
    List<int> productIds = productIdsStringsArr.map(int.parse).toList();

    List<String> productQuantitiesStrings = productQuantitiesString.split(',');
    List<int> productQuantities =
        productQuantitiesStrings.map(int.parse).toList();

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
      "redeem_point" : redeemedPoint.value
    };

    return requestBody;
  }


  void pointRedeemAlert() {
    showDialog(
        context: Get.context!,
        useSafeArea: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: AppColors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: AppCardContainer(
                applyRadius: false,
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Redeem Your Points', style: Theme.of(context).textTheme.headlineSmall,),
                            AppCardContainer(
                                applyRadius: false,
                                onTap: ()=> Get.back(),
                                height: 44,
                                width: 44,
                                backgroundColor: AppColors.grey,
                                child: const Icon(Icons.clear))
                          ],
                        ),
                        const Gap(AppSizes.defaultSpace),
                        RadioListTile<int>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: AppColors.primary,
                          title: Text(
                            '100 points',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: 100,
                          groupValue: redeemPoint.value,
                          onChanged: (value) {
                            redeemPoint.value = value!;  // Update selected value
                          },
                        ),

                        RadioListTile<int>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: AppColors.primary,
                          title: Text(
                            '200 points',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: 200,
                          groupValue: redeemPoint.value,
                          onChanged: rewardBalance > 199 ? (value) {
                            redeemPoint.value = value!;  // Update selected value
                          } : null,
                        ),
                        RadioListTile<int>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: AppColors.primary,
                          title: Text(
                            '300 points',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: 300,
                          groupValue: redeemPoint.value,
                          onChanged: rewardBalance > 299 ?(value) {
                            redeemPoint.value = value!;  // Update selected value
                          } : null,
                        ),
                        RadioListTile<int>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: AppColors.primary,
                          title: Text(
                            '400 points',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: 400,
                          groupValue: redeemPoint.value,
                          onChanged: rewardBalance > 399 ? (value) {
                            redeemPoint.value = value!;  // Update selected value
                          } : null,
                        ),
                        RadioListTile<int>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: AppColors.primary,
                          title: Text(
                            '500 points',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          value: 500,
                          groupValue: redeemPoint.value,
                          onChanged: rewardBalance > 499 ?(value) {
                            redeemPoint.value = value!;  // Update selected value
                          } : null,
                        ),

                        const Gap(AppSizes.md),
                        SizedBox(
                          width: 150,
                          child: AppButtons.largeFlatFilledButton(
                              onPressed: (){
                                onRedeemPoint();
                              },
                              backgroundColor: AppColors.addToCartButton,
                              buttonText: 'Redeem Points'.toUpperCase()),
                        )
                      ],
                    );
                  }
                ),
              )
          );
        });
  }

  void onRedeemPoint() {
    redeemedPoint.value = redeemPoint.value;
    grandTotal.value = grandTotal.value - redeemedPoint.value;
    Get.back();
  }
}
