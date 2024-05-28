import 'package:get/get.dart';
import 'package:torganic/src/features/purchase_history/model/purchase_history_model.dart';
import 'package:torganic/src/features/purchase_history/repositories/purchase_history_repositories.dart';

class PurchaseHistoryController extends GetxController{
  static PurchaseHistoryController get instance => Get.find();

  Rx<PurchaseHistoryResponse> purchaseHistoryList = PurchaseHistoryResponse().obs;


  @override
  void onInit() {
    super.onInit();
    getPurchaseHistoryList();
  }

  Future onRefresh() async{
    print('refresh');
  }

  Future<PurchaseHistoryResponse> getPurchaseHistoryList()async{
    return purchaseHistoryList.value = await PurchaseHistoryRepositories().getPurchaseHistoryList();
  }
}