import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/repositories/reward_repositories.dart';

import '../model/reward_history_model.dart';

class RewardPointHistoryController extends GetxController{
  static RewardPointHistoryController get instance => Get.find();

  Rx<RewardHistoryResponse> rewardHistory = RewardHistoryResponse().obs;
  RxBool hittingAPi = false.obs;


  @override
  void onInit() {
    super.onInit();
  onRefresh();

  }

  Future<void> onRefresh() async{
    print('refresh');
    getRewardHistoryList();
  }

  Future<void> getRewardHistoryList() async{
    hittingAPi.value = true;
    rewardHistory.value = await RewardRepositories().getRewardHistory();
    hittingAPi.value = false;
  }
}