import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';

import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{
  static AppDrawerController get instance => Get.find();


  RxList<AllCategory> allCategories = <AllCategory>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCategories();
  }

  void fetchAllCategories() async {
    allCategories.value = await DrawerRepositories().getAllCategories();
  }
}