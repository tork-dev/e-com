import 'package:get/get.dart';
import 'package:kirei/src/common/drawer/repositories/repositories.dart';
import '../model/all_category_model.dart';

class AppDrawerController extends GetxController{

  final bool isOpenDrawer;
  AppDrawerController({required this.isOpenDrawer});

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
    if(isOpenDrawer) {
      fetchAllNewCategories();
    }else{
      fetchAllCategories();
    }
  }

  void fetchAllNewCategories() async {
    allNewCategories.value = await DrawerRepositories().getAllNewCategories();
  }

  void fetchAllCategories() async {
    allNewCategories.value = await DrawerRepositories().getAllCategories();
  }
}