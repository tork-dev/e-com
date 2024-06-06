import 'package:get/get.dart';
import 'package:torganic/src/features/purchase_history/model/purchase_history_details_model.dart';
import 'package:torganic/src/features/purchase_history/repositories/purchase_history_repositories.dart';

import '../model/product_history_items_model.dart';

class PurchaseHistoryDetailsController extends GetxController {
  static PurchaseHistoryDetailsController get instance => Get.find();

  PurchaseHistoryDetailsController({required this.orderId});

  final int orderId;

  Rx<PurchaseHistoryDetailsResponse> purchaseHistoryDetails =
      PurchaseHistoryDetailsResponse().obs;
  Rx<PurchaseHistoryItemsResponse> purchaseHistoryItemDetails =
      PurchaseHistoryItemsResponse().obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onRefresh();
  }

  Future onRefresh() async {
    print('refresh');
    getPurchaseHistoryDetails();
    getPurchaseHistoryItemDetails();
  }

  Future<PurchaseHistoryDetailsResponse> getPurchaseHistoryDetails() async {
    return purchaseHistoryDetails.value =
        await PurchaseHistoryRepositories().getPurchaseHistoryDetails(orderId);
  }

  Future<PurchaseHistoryItemsResponse> getPurchaseHistoryItemDetails() async {
    return purchaseHistoryItemDetails.value =
    await PurchaseHistoryRepositories().getPurchaseHistoryItemDetails(orderId);
  }

}
