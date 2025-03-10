

import 'package:get/get.dart';
import 'package:kirei/src/common/controller/common_controller.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // Get.put(NetworkManager());
    Get.put(CommonController());
  }

}