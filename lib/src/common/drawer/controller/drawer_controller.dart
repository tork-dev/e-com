import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{

  static AppDrawerController get instance => Get.find();


  RxList<AllCategory> allNewCategories = <AllCategory>[].obs;
  RxBool mainCategoryExpanded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      fetchAllNewCategories();
  }

  void fetchAllNewCategories() async {
    allNewCategories.value = await DrawerRepositories().getAllNewCategories();
  }


}