import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/repositories/reward_repositories.dart';
import '../model/membership_level_model.dart';

class RewardPointLevelController extends GetxController{
  static RewardPointLevelController get instance => Get.find();

  Rx<MemberShipLevelResponse> pointLevel = MemberShipLevelResponse().obs;
  RxBool hittingApi = false.obs;


  @override
  void onInit() {
    super.onInit();
  onRefresh();
  }

  Future<void> onRefresh() async{
    print('refresh');
    getMembershipLevel();
  }

  Future<void> getMembershipLevel() async{
    hittingApi.value = true;
    pointLevel.value = await RewardRepositories().getMembershipLevel();
    hittingApi.value = false;
  }
}