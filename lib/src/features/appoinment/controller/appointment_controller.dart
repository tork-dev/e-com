import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottom_navigation/convex_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../shop/controller/shop_controller.dart';

class AppointmentController extends GetxController{
  static  AppointmentController get instance => Get.find();
  final GlobalKey<ScaffoldState> appointmentKey = GlobalKey<ScaffoldState>();
  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  TextEditingController problemController = TextEditingController();

  ConvexBottomNavController bottomController  = Get.put(ConvexBottomNavController());
  HomeController homeController  = Get.put(HomeController());
  //final shopController = Get.put(ShopController());

  @override
  void onInit() {
    super.onInit();
    homeController.callApis.value = false;
    //shopController.callApis.value = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    appointmentKey.currentState!.dispose();
  }
}