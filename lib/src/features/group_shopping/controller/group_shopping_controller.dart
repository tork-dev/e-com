import 'package:get/get.dart';
import 'package:kirei/src/features/group_shopping/model/group_shopping_products_model.dart';
import 'package:kirei/src/features/group_shopping/repositories/group_shopping_repositories.dart';

import '../model/group_shopping_groups.dart';

class GroupShoppingController extends GetxController{
  static GroupShoppingController get instance => Get.find();

  RxBool hittingApi = false.obs;

  Rx<GroupShoppingProductsResponse> groupShoppingProduct = GroupShoppingProductsResponse().obs;
  Rx<GroupShoppingGroupsResponse> groupShoppingGroup = GroupShoppingGroupsResponse().obs;


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh()async{
    print('refresh');
    getProducts();
  }

  Future<void> getProducts() async{
    hittingApi.value = true;
    groupShoppingProduct.value = await GroupShoppingRepo().getGroupShoppingProducts();
    groupShoppingGroup.value = await GroupShoppingRepo().getGroupShoppingGroups();
    hittingApi.value = false;
  }
}