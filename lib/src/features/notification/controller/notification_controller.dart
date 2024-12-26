import 'package:get/get.dart';

class NotificationController extends GetxController{
  static NotificationController get instance => Get.find();

  Future <void> onRefresh() async{
    print('api not implemented');
  }
}