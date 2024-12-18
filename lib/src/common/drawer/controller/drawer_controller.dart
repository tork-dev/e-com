import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{
  static AppDrawerController get instance => Get.find();


  RxList<AllCategory> allCategories = <AllCategory>[].obs;
  // RxList<bool> isExpandedListCategoryList = [false].obs;
  // RxList isExpandedListSubCategoryList = [].obs;
  RxBool mainCategoryExpanded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCategories();
  }

  void fetchAllCategories() async {
    allCategories.value = await DrawerRepositories().getAllCategories();
    // Initialize the list based on the number of categories
    // isExpandedListCategoryList.value = List.generate(allCategories.length, (index) => false);
    // isExpandedListSubCategoryList.value = allCategories.map((category) {
    //   return List.generate(category.children?.length ?? 0, (index) => false);
    // }).toList();

  }
}