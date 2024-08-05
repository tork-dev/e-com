import 'package:get/get.dart';
import 'package:kirei/src/features/details/controller/details_page_controller.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsPageController>(() => DetailsPageController());
  }
}