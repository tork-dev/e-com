import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/repositories/reward_repositories.dart';
import '../model/point_redemption_model.dart';

class PointRedeemController extends GetxController{
  static PointRedeemController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<PointRedemptionResponse> pointRedemptionResponse = PointRedemptionResponse().obs;


  @override
  void onInit() {
    super.onInit();
    getPointRedemptionProducts();
  }

  Future<void> onRefresh() async{
    print('refress');
  }


  Future<void> getPointRedemptionProducts() async{
    hittingApi.value = true;
    pointRedemptionResponse.value = await RewardRepositories().getPointRedeemProducts();
    hittingApi.value = false;

  }
}