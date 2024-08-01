import 'package:get/get.dart';
import 'package:kirei/src/features/purchase_history/model/purchase_history_model.dart';
import 'package:kirei/src/features/purchase_history/repositories/purchase_history_repositories.dart';

import '../model/order_re_order_model.dart';

class PurchaseHistoryController extends GetxController{
  static PurchaseHistoryController get instance => Get.find();

  Rx<PurchaseHistoryResponse> purchaseHistoryList = PurchaseHistoryResponse().obs;
  Rx<ReOrderResponse> reOrderResponse = ReOrderResponse().obs;
  RxBool hittingApi = false.obs;


  @override
  void onInit() {
    super.onInit();
    getPurchaseHistoryList();
  }

  Future onRefresh() async{
    print('refresh');
  }

  Future<void> getPurchaseHistoryList()async{
    hittingApi.value = true;
    purchaseHistoryList.value = await PurchaseHistoryRepositories().getPurchaseHistoryList();
    hittingApi.value = false;
  }

  Future<ReOrderResponse> getReorderResponse(int id) async{
    return reOrderResponse.value = await PurchaseHistoryRepositories().getReOrder(id);
  }

}