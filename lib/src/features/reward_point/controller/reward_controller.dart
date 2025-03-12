import 'package:get/get.dart';
import 'package:kirei/src/features/reward_point/model/reward_model.dart';
import 'package:kirei/src/features/reward_point/repositories/reward_repositories.dart';

import '../../../utils/logging/logger.dart';

class RewardController extends GetxController {
  static RewardController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<RewardResponse> rewardResponse = RewardResponse().obs;
  RxDouble percentage = 0.0.obs;
  List<int> percentageList = [0,100,200,300];

  @override
  void onInit() {
    super.onInit();
    getRewardResponse();
  }

  Future<void> onRefresh() async {
    Log.d('refresh');
    getRewardResponse();
  }

  Future<void> getRewardResponse() async {
    hittingApi.value = true;

    // Fetch the reward response
    rewardResponse.value = await RewardRepositories().getRewardResponse();
    hittingApi.value = false;

    List allValues = [];

    // Add the minRewardPoint values to allValues list
    rewardResponse.value.memberships?.forEach((membership) {
      if (membership.minRewardPoint != null) {
        allValues.add(membership.minRewardPoint!);
      }
    });

    // Find the maximum value from allValues list
    if (allValues.isNotEmpty) {
      int maxValue = allValues.reduce((a, b) => a > b ? a : b);
      Log.d("Maximum Value: $maxValue");

      double percent = rewardResponse.value.nextMemberships!.memberShipPoint! / maxValue;


      if (percent < 1) {
        percentage.value = percent;
      } else {
        percentage.value = 1;
      }
    }
  }
}
