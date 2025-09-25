import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kirei/src/features/authentication/views/widgets/auth_input_field.dart';
import 'package:kirei/src/features/cart/controllers/cart_controller.dart';
import 'package:kirei/src/features/cart/services/cart_services.dart';
import 'package:kirei/src/features/checkout/model/checkout_summary_respopnse.dart';
import 'package:kirei/src/features/checkout/model/coupon_apply_model.dart';
import 'package:kirei/src/features/checkout/model/coupon_remove_model.dart';
import 'package:kirei/src/features/checkout/model/order_create_model.dart';
import 'package:kirei/src/features/checkout/model/payment_types_model.dart';
import 'package:kirei/src/features/checkout/repositories/checkout_repositories.dart';
import 'package:kirei/src/features/checkout/view/widget/bkash_screen.dart';
import 'package:kirei/src/features/checkout/view/order_status_page.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/helpers/auth_helper.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/features/address/controller/address_controller.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../common/widgets/buttons/app_buttons.dart';
import '../../../common/widgets/containers/card_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/logging/logger.dart';
import '../../../utils/popups/custom_loader.dart';
import '../view/widget/ssl_screen.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final addressController = Get.put(AddressController());
  final cartController = CartController.instance;

  // Rx<CheckoutSummaryResponse> checkoutSummary = CheckoutSummaryResponse().obs;
  RxList<PaymentMethodResponse> paymentMethods = <PaymentMethodResponse>[].obs;
  Rx<CouponResponse> couponResponse = CouponResponse().obs;
  Rx<CouponRemoveResponse> couponRemoveResponse = CouponRemoveResponse().obs;
  Rx<OrderCreateResponse> orderCreateResponse = OrderCreateResponse().obs;

  TextEditingController couponController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  RxInt selectedPaymentMethod = 0.obs;
  RxString selectedPaymentMethodName = 'cash_on_delivery'.obs;
  RxBool isTermsChecked = false.obs;
  RxBool isAddressAvailable = false.obs;
  RxBool isCouponApplied = false.obs;
  RxInt rewardBalance = 0.obs;
  RxInt redeemPoint = 0.obs;
  RxInt redeemedPoint = 0.obs;
  RxDouble grandTotal = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _executeCheckoutApis();
    // Reactively run APIs once shippingAddress is loaded
    // ever(addressController.shippingAddress, (AddressResponse? addr) {
    //   if (addr != null) {
    //   }
    // });
  }

  Future<void> onRefresh() async {
    if (addressController.hasData) {
      await _executeCheckoutApis();
    }
  }

  Future<void> _executeCheckoutApis() async {
    // Optional delay
    // await Future.delayed(const Duration(seconds: 1));

    // await getCheckoutSummary();
    await getPaymentMethods();
    if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) != null) {
      addressAvailabilityCheck();
      getUserRewardBalance();
    }
  }

  Future<void> getUserRewardBalance() async {
    final response = await http.get(
      Uri.parse(AppApiEndPoints.rewardPointBalance),
      headers: {
        'Authorization':
            "Bearer ${AppLocalStorage().readData(LocalStorageKeys.accessToken)}",
      },
    );
    rewardBalance.value = int.parse(response.body);
    Log.d('this is balance : ${response.body}');
  }

  void addressAvailabilityCheck() {
    if (addressController.nameController.text == "Guest" ||
        addressController.addressController.text == "") {
      isAddressAvailable.value = false;
    } else {
      isAddressAvailable.value = true;
    }
  }

  // Future<void> getCheckoutSummary() async {
  //   checkoutSummary.value =
  //       await CheckoutRepositories().getCartSummaryResponse(addressController.selectedCityId.value);
  //   couponController.text = checkoutSummary.value.data?.couponCode ?? '';
  //   isCouponApplied.value = checkoutSummary.value.data!.couponApplied!;
  //   grandTotal.value = checkoutSummary.value.data!.grandTotalValue;
  // }

  Future<List<PaymentMethodResponse>> getPaymentMethods() async {
    print("payment methods");
    return paymentMethods.value =
        await CheckoutRepositories().getPaymentMethods();
  }

  // /// Coupon Apply
  // Future<CouponResponse> getCouponAppliedResponse() async {
  //   return couponResponse.value = await CheckoutRepositories()
  //       .getCouponApplyResponse(couponCode: couponController.text.toString());
  // }

  Future<void> onCouponApplied() async {
    if (couponController.text == '') {
      AppHelperFunctions.showToast('Please enter a coupon code');
      return;
    }
    bool? result = await cartController.getCheckoutSummary(
      couponCode: couponController.text.toString(),
    );
    isCouponApplied.value = result!;
    AppHelperFunctions.showToast(
      result ? "Coupon Applied" : "Coupon Not Applied",
    );
  }

  // /// Coupon Remove
  // Future<CouponRemoveResponse> getCouponRemoveResponse() async {
  //   return couponRemoveResponse.value =
  //   await CheckoutRepositories().getCouponRemoveResponse();
  // }

  Future<void> onCouponRemove() async {
    bool? result = await cartController.getCheckoutSummary();
    isCouponApplied.value = !result!;
    if (result) {
      couponController.clear();
    }
    AppHelperFunctions.showToast(
      result ? "Coupon Removed" : "Something went wrong",
    );
  }

  /// Crete Order Method
  Future<void> onPressProceedToCheckout() async {
    if (!validateCheckoutDetails()) return;
    CustomLoader.showLoaderDialog(Get.overlayContext!);

    Map<String, dynamic> requestBody = await prepareRequestBody();
    print("called request body");
    try {
      orderCreateResponse.value = await CheckoutRepositories()
          .getOrderCreateResponseFromCod(requestBody: requestBody);

      CustomLoader.hideLoader(Get.overlayContext!); // Hide loader

      CartService.getCartItems();

      // Handle different payment methods
      if (selectedPaymentMethod.value == 1) {
        if (orderCreateResponse.value.data?.paymentUrl != null) {
          Get.offAll(
            () => BkashScreen(
              bkashInitialUrl: orderCreateResponse.value.data!.paymentUrl!,
              orderId: orderCreateResponse.value.data!.order!.id!,
            ),
          );
        } else {
          throw Exception('Bkash payment URL is missing');
        }
        return;
      }

      if (selectedPaymentMethod.value == 2) {
        if (orderCreateResponse.value.data?.paymentUrl != null) {
          Get.offAll(
            () => SslCommerzScreen(
              orderId: orderCreateResponse.value.data!.order!.id!,
              sslInitialUrl: orderCreateResponse.value.data!.paymentUrl!,
              amount: orderCreateResponse.value.data!.order!.grandTotal!,
              paymentMethodKey: 'ssl',
              paymentType: orderCreateResponse.value.data!.order!.paymentType!,
            ),
          );
        } else {
          throw Exception('SslCommerz payment URL is missing');
        }
        return;
      }

      // If no specific payment method, show toast and navigate to Order Status Screen
      AppHelperFunctions.showToast(orderCreateResponse.value.message!);
      Log.d(orderCreateResponse.value.toString());
      if (orderCreateResponse.value.data!.order!.id != null) {
        Get.offAll(
          () => AppOrderStatusScreen(
            statusString: orderCreateResponse.value.message!,
            status: orderCreateResponse.value.result ?? false,
            orderId: orderCreateResponse.value.data!.order!.id!,
          ),
        );
      }
    } catch (e) {
      CustomLoader.hideLoader(
        Get.overlayContext!,
      ); // Ensure the loader is closed in case of an error
      Log.d('Error in onPressProceed: $e');
      AppHelperFunctions.showToast('An error occurred. Please try again.');
    }
  }

  bool validateCheckoutDetails() {
    // if (checkoutSummary.value.grandTotalValue == 0.00) {
    //   AppHelperFunctions.showToast('Nothing to pay');
    //   return false;
    // }

    if (selectedPaymentMethodName.value == "") {
      AppHelperFunctions.showToast('Please select a payment method');
      return false;
    }

    if (selectedPaymentMethodName.value == "bkash" &&
            cartController.cartSummaryResponse.value.data?.grandTotalValue! <
                1 ||
        selectedPaymentMethodName.value == "ssl" &&
            cartController.cartSummaryResponse.value.data?.grandTotalValue! <
                10.00) {
      AppHelperFunctions.showToast(
        'Minimum amount not reached. Please select cash on delivery',
      );
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

    if (addressController.selectedCityId.value == 0) {
      AppHelperFunctions.showToast('City is required');
      return false;
    }

    if (addressController.selectedZoneId.value == 0) {
      AppHelperFunctions.showToast('Zone is required');
      return false;
    }

    return true;
  }

  RxInt isPreOrderAvailable = 0.obs;

  Future<Map<String, dynamic>> prepareRequestBody() async {
    List<int> productIds = [];
    List<int> cartQuantities = [];

    if (cartController.allCartProducts.isNotEmpty) {
      for (var item in cartController.allCartProducts) {
        isPreOrderAvailable.value = item.isPreorder!;
        productIds.add(item.productId!);
        cartQuantities.add(item.quantity!);
      }
    }

    String productIdsJsonArray = "[${productIds.join(',')}]";
    String productQuantitiesJsonArray = "[${cartQuantities.join(',')}]";
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
      "is_preorder": isPreOrderAvailable.value,
      "payment_type": selectedPaymentMethodName.value,
      "note": notesController.text,
      "type": 'app',
      "version": "${AppLocalStorage().readData(LocalStorageKeys.appVersion)}",
      "coupon_code": couponCode,
      "redeem_point": redeemedPoint.value,
      'app_info': await AppHelperFunctions.appInfo(),
      "source": "app",
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
          ),
          child: AppCardContainer(
            borderRadius: AppSizes.cardRadiusMd,
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Redeem Your Points',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      AppCardContainer(
                        applyRadius: true,
                        onTap: () => Get.back(),
                        height: 44,
                        width: 44,
                        backgroundColor: AppColors.grey,
                        child: const Icon(Icons.clear),
                      ),
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
                      redeemPoint.value = value!; // Update selected value
                    },
                  ),

                  RadioListTile<int>(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    activeColor: AppColors.primary,
                    title: Text(
                      '150 points',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: 150,
                    groupValue: redeemPoint.value,
                    onChanged:
                        rewardBalance > 149
                            ? (value) {
                              redeemPoint.value =
                                  value!; // Update selected value
                            }
                            : null,
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
                    onChanged:
                        rewardBalance > 199
                            ? (value) {
                              redeemPoint.value =
                                  value!; // Update selected value
                            }
                            : null,
                  ),
                  RadioListTile<int>(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    activeColor: AppColors.primary,
                    title: Text(
                      '250 points',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: 250,
                    groupValue: redeemPoint.value,
                    onChanged:
                        rewardBalance > 249
                            ? (value) {
                              redeemPoint.value =
                                  value!; // Update selected value
                            }
                            : null,
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
                    onChanged:
                        rewardBalance > 299
                            ? (value) {
                              redeemPoint.value =
                                  value!; // Update selected value
                            }
                            : null,
                  ),

                  const Gap(AppSizes.defaultSpace),

                  AppButtons.largeFlatFilledButton(
                    onPressed: () {
                      onRedeemPoint();
                    },
                    backgroundColor: AppColors.addToCartButton,
                    buttonText: 'Redeem Points'.toUpperCase(),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  void onRedeemPoint() {
    redeemedPoint.value = redeemPoint.value;
    cartController.cartSummaryResponse.value.data!.grandTotalValue =
        cartController.cartSummaryResponse.value.data!.grandTotalValue -
        redeemedPoint.value;
    Get.back();
  }

  Future<void> sendCheckoutOtp() async {
    if (!validateCheckoutDetails()) return;
    CustomLoader.showLoaderDialog(Get.overlayContext!);
    final response = await CheckoutRepositories().sendCheckoutOtp(
      addressController.phoneController.text,
    );
    CustomLoader.hideLoader(Get.overlayContext!);
    if (response.result == true) {
      showOtpDialog(Get.context!);
    }
    AppHelperFunctions.showToast(response.message!);
  }

  Future<void> verifyCheckoutOtp(String otp) async {
    CustomLoader.showLoaderDialog(Get.overlayContext!);
    final response = await CheckoutRepositories().verifyCheckoutOtp(
      name: addressController.nameController.text.toString(),
      phone: addressController.phoneController.text.toString(),
      otp: otp.toString(),
    );
    CustomLoader.hideLoader(Get.overlayContext!);
    if (response.result == true) {
      await AuthHelper().setUserData(response);
      onPressProceedToCheckout();
    }
  }

  void showOtpDialog(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthInputField(
                  hingText: "Otp Code",
                  controller: otpController,
                  obscured: false,
                ),
                const Gap(AppSizes.lg),
                AppButtons.largeFlatFilledButton(
                  buttonRadius: AppSizes.cardRadiusMd,
                  backgroundColor: AppColors.secondary,
                  onPressed: () {
                    verifyCheckoutOtp(otpController.text.toString());
                  },
                  buttonText: 'Confirm OTP',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
