import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/appoinment/repositories/appoinment_repositories.dart';
import 'package:kirei/src/features/appoinment/view/payment_screen.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../../bottom_navigation/convex_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../shop/controller/shop_controller.dart';
import '../model/appointment_model.dart';

class AppointmentController extends GetxController {
  static AppointmentController get instance => Get.find();
  final GlobalKey<ScaffoldState> appointmentKey = GlobalKey<ScaffoldState>();

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  TextEditingController problemController = TextEditingController();

  // ConvexBottomNavController bottomController  = Get.put(ConvexBottomNavController());
  //HomeController homeController  = Get.put(HomeController());
  //final shopController = Get.put(ShopController());

  Rx<AppointmentResponse> appointmentResponse = AppointmentResponse().obs;

  RxString paymentMethod = 'bkash'.obs;

  @override
  void onInit() {
    super.onInit();
    // homeController.callApis.value = false;
    //shopController.callApis.value = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    appointmentKey.currentState!.dispose();
  }

  void onMakePayment() async {
    if (fullNameController.text == '') {
      return AppHelperFunctions.showToast('Name is required');
    }
    if (ageController.text == '') {
      return AppHelperFunctions.showToast('Age is required');
    }
    if (contactNumberController.text == '') {
      return AppHelperFunctions.showToast('Number is required');
    }
    if (whatsAppNumberController.text == '') {
      return AppHelperFunctions.showToast('WhatsApp number is required');
    }
    if (problemController.text == '') {
      print(problemController.text);
      return AppHelperFunctions.showToast('Problem is required');
    }

    appointmentResponse.value = await AppointmentRepository().submitAppointment(
        age: ageController.text,
        contactNumber: contactNumberController.text,
        name: fullNameController.text,
        paymentType: paymentMethod.value,
        problem: problemController.text,
        whatsappNumber: whatsAppNumberController.text);


    if (appointmentResponse.value.result == true) {
      String? url = appointmentResponse.value.data!.paymentUrl;
      if (url!.isNotEmpty) {
        if (paymentMethod.value == 'bkash') {
          Get.offAll(() => AppointmentPaymentScreen(
                initialUrl: url,
                screenName: 'bKash',
              ));
        } else if (paymentMethod.value == 'ssl') {
          Get.offAll(() => AppointmentPaymentScreen(
                initialUrl: url,
                screenName: 'sslcommerz',
              ));
        }
      }
    }
    AppHelperFunctions.showToast(appointmentResponse.value.message!);
  }
}
