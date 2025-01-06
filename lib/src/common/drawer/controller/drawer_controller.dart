import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{

  static AppDrawerController get instance => Get.find();


  RxList<AllCategory> allNewCategories = <AllCategory>[].obs;
  RxList<AllCategory> allCategories = <AllCategory>[].obs;
  // RxList<bool> isExpandedListCategoryList = [false].obs;
  // RxList isExpandedListSubCategoryList = [].obs;
  RxBool mainCategoryExpanded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      fetchAllNewCategories();
      fetchAllCategories();
  }

  void fetchAllNewCategories() async {
    allNewCategories.value = await DrawerRepositories().getAllNewCategories();
  }

  void fetchAllCategories() async {
    allCategories.value = await DrawerRepositories().getAllCategories();
  }
}