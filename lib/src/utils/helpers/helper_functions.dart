import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kirei/src/common/widgets/buttons/app_buttons.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/authentication/views/forgot_password/view/otp.dart';
import 'package:kirei/src/features/spinner_wheel/view/spinner_wheel_alert.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/routing_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/storage_utility.dart';

class AppHelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // static showFlashBar(
  //     {String? message,
  //     Icon? icon,
  //     FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM}) {
  //   Flushbar(
  //     message: message,
  //     backgroundColor: Colors.red,
  //     duration: const Duration(seconds: 3),
  //     icon: icon,
  //     flushbarPosition: flushbarPosition,
  //   ).show(Get.context!);
  // }

  static void showSimpleSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void showSnackBarWithDesign(
      {required title, message = '', duration = 3, backgroundColor, icon}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: AppColors.white,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: Icon(
          icon,
          color: AppColors.white,
        ));
  }

  static void showSnackBarWithAction(
      {required String message,
      required String label,
      required dynamic onPressed}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: label, onPressed: onPressed),
      ),
    );
  }

  static void showAlert(
      {required String message,
      required String leftButtonName,
      required String rightButtonName,
      required VoidCallback onRightPress,
      required VoidCallback onLeftPress,
      required Color rightButtonColor,
      Color leftButtonColor = Colors.transparent,
      Color rightButtonTextColor = AppColors.white,
      Color leftButtonTextColor = AppColors.black}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusSm),
          ),
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: AppColors.white,
          content: SizedBox(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(AppSizes.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onLeftPress,
                      child: Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: leftButtonColor),
                        child: Text(
                          leftButtonName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: leftButtonTextColor),
                        ),
                      ),
                    ),
                    const Gap(AppSizes.spaceBtwSmallItem),
                    InkWell(
                      onTap: onRightPress,
                      child: Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: rightButtonColor, borderRadius: BorderRadius.circular(AppSizes.xs)),
                        child: Text(
                          rightButtonName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: rightButtonTextColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showPopUpAlert(
      {String? title,
      String? subTitle,
      required String leftButtonName,
      String? rightButtonName,
      VoidCallback? onRightPress,
      required VoidCallback onLeftPress,
      String? imgUrl}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          backgroundColor: AppColors.popUpBackground,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: imgUrl != null,
                    child: AppBannerImage(
                        applyImageRadius: true,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        isNetworkImage: true,
                        imgUrl: imgUrl),
                  ),
                  Visibility(
                    visible: title != null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          const Gap(AppSizes.defaultSpace),
                          Text(
                            title ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Gap(AppSizes.sm),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                          vertical: title == null ? AppSizes.defaultSpace : 0),
                      child: Column(
                        children: [
                          HtmlWidget(subTitle ?? ''),
                          const Gap(AppSizes.xl),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: rightButtonName != null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppCardContainer(
                                  onTap: onLeftPress,
                                  applyRadius: true,
                                  borderRadius: AppSizes.cardRadiusXs,
                                  height: 40,
                                  width: 120,
                                  hasBorder: true,
                                  child: Center(
                                    child: Text(
                                      leftButtonName,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  )),
                              const Gap(AppSizes.sm),
                              AppCardContainer(
                                  onTap: onRightPress,
                                  applyRadius: true,
                                  borderRadius: AppSizes.cardRadiusXs,
                                  height: 40,
                                  width: 120,
                                  backgroundColor: AppColors.primary,
                                  child: Center(
                                    child: Text(
                                      rightButtonName ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .apply(color: AppColors.white),
                                    ),
                                  )),
                            ],
                          ),
                          const Gap(AppSizes.md),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: AppSizes.md,
                top: AppSizes.md,
                child: AppCardContainer(
                    onTap: onLeftPress,
                    applyRadius: true,
                    borderRadius: AppSizes.cardRadiusXs,
                    backgroundColor: AppColors.whitePink,
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.clear)),
              )
            ],
          ),
        );
      },
    );
  }

  void showAlertForFirstTime() {
    showDialog(
        context: Get.context!,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (BuildContext context) => const AppSpinnerWheelAlert());
  }

  void verifyPhone() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: AppColors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Otp(
              isForSpinner: true,
            ),
          );
        });
  }

  static void showSpinnerCoupon(
      {required String title,
      required String subTitle,
        String? expireMessage,
      String? couponCode,
      VoidCallback? onCouponPress,
      required String imgUrl}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          insetPadding: const EdgeInsets.all(AppSizes.md),
          backgroundColor: AppColors.popUpBackground,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(AppSizes.xl),
                  AppBannerImage(
                      applyImageRadius: false,
                      height: 100,
                      isNetworkImage: true,
                      imgUrl: imgUrl),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.defaultSpace),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Gap(AppSizes.sm),
                        Text(
                          subTitle,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Gap(AppSizes.md),
                        Text(
                          "*NOTE: $expireMessage",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: AppColors.error),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(AppSizes.xl),
                        Visibility(
                            visible: couponCode != null,
                            child: AppCardContainer(
                              applyRadius: false,
                              onTap: onCouponPress,
                              backgroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(couponCode ?? ''),
                                  const Gap(AppSizes.sm),
                                  const Icon(Icons.copy)
                                ],
                              ),
                            )
                        ),
                        const Gap(AppSizes.defaultSpace),
                        AppButtons.largeFlatFilledButton(
                            backgroundColor: const Color(0xffDA5555),
                            onPressed: () {
                              Get.offAllNamed('/shop');
                            },
                            buttonText: 'Continue shopping')
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: AppSizes.md,
                top: AppSizes.md,
                child: AppCardContainer(
                    onTap: () => Get.back(),
                    applyRadius: false,
                    backgroundColor: AppColors.grey,
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.clear)),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<void> showLoaderDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Ensures the dialog won't take full screen
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ), // Loader
                SizedBox(height: 20), // Space between loader and text
                Text(
                  "Please wait...",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (int i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  String stripHtmlTags(String htmlString) {
    // Remove HTML comments and metadata tags
    final RegExp regExpComments =
        RegExp(r'<!--.*?-->', multiLine: true, caseSensitive: false);
    String result = htmlString.replaceAll(regExpComments, '');

    // Remove all HTML tags
    final RegExp regExpTags =
        RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    result = result.replaceAll(regExpTags, '');

    // Replace common HTML entities
    result = result.replaceAll('&nbsp;', ' ');
    result = result.replaceAll('&lt;', '<');
    result = result.replaceAll('&gt;', '>');
    result = result.replaceAll('&amp;', '&');
    result = result.replaceAll('&quot;', '"');
    result = result.replaceAll('&apos;', "'");

    return result.trim();
  }

  bool isVersionLessThan(String version1, String version2) {
    List<int> v1 = version1.split('.').map(int.parse).toList();
    List<int> v2 = version2.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (v1[i] < v2[i]) return true;
      if (v1[i] > v2[i]) return false;
    }
    return false; // They are equal
  }

  static deBouncerSearchDelay(function) {
    Future.delayed(const Duration(microseconds: 300), () => function);
  }

  static String formatTimestampWithAgo(DateTime? dateAndTime) {
    DateTime now = DateTime.now();
    DateTime dateTime = (dateAndTime ?? now);
    Duration difference = now.difference(dateTime);

    if(difference.inDays >= 365){
    int year = (difference.inDays / 365).floor();
    return year == 1 ? '1 year ago' : '$year year ago';
    }
    else if(difference.inDays >= 30){
      int month = (difference.inDays / 30).floor();
      return month == 1 ? '1 month ago' : '$month month ago';
    }
    else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  static getAndroidDeviceInfo() async {
    final String version =
        AppLocalStorage().readData(LocalStorageKeys.appVersion);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final Map<String, dynamic> allInfo = {
      'app_version': version,
      'device_type': 'android',
      'os_version': androidInfo.version.release,
      'device_model': androidInfo.model,
      'device_brand': androidInfo.brand,
      'device_manufacturer': androidInfo.manufacturer,
    };
    return allInfo;
  }

  static getIosDeviceInfo() async {
    final String version =
        AppLocalStorage().readData(LocalStorageKeys.appVersion);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    final Map<String, dynamic> allInfo = {
      'app_version': version,
      'device_type': 'IOS',
      'os_version': iosDeviceInfo.systemVersion,
      'device_brand': iosDeviceInfo.name,
      'device_model': iosDeviceInfo.model,
    };
    return allInfo;
  }

  static appInfo() async {
    final Map<String, dynamic> deviceInfoHeaders = Platform.isAndroid
        ? await AppHelperFunctions.getAndroidDeviceInfo()
        : await AppHelperFunctions.getIosDeviceInfo();

    return deviceInfoHeaders;
  }


  void showKireiReturnPolicyAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusSm),
          ),
          contentPadding: const EdgeInsets.all(AppSizes.defaultSpace),
          content: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: AppCardContainer(
                  onTap: ()=> Get.back(),
                  backgroundColor: AppColors.primary.withAlpha(197),
                    padding: EdgeInsets.all(AppSizes.sm),
                    child: Icon(Icons.clear, size: 20, color: AppColors.white)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/icons/return_image.png', // Make sure this is your image path
                      height: 80,
                    ),
                  ),
                  const Gap(AppSizes.spaceBtwItems),
                   Text(
                    "Easy Returns with Kirei",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  Text(
                    "🛡️ 100% Satisfaction Promise",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(AppSizes.spaceBtwItems),
                   Text(
                    "At Kirei, we care about your happiness with every purchase. "
                        "If something doesn’t feel right, simply return the item to the delivery person on the spot.",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Gap(AppSizes.spaceBtwDefaultItems),
                  Text(
                    "No return fees. No extra costs. You’ll get a full refund (if paid) or an exchange (if available) within 5 working days. "
                        "Just make sure to check and return the product while the delivery person is still present.",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Gap(AppSizes.defaultSpace),
                  OutlinedButton.icon(
                    onPressed: () {
                      RoutingHelper.urlRouting("${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/return-refund");
                    },
                    icon: const Icon(Icons.info_outline),
                    label: const Text("Learn More"),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void openWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }


}
