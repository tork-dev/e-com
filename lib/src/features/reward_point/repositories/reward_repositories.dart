import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/point_redemption_model.dart';
import '../model/reward_model.dart';

class RewardRepositories {

  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);

  Future<RewardResponse> getRewardResponse() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.rewardPoint), headers: {
      'Authorization':
          'Bearer $accessToken'
    });

    if(response.statusCode == 200){
      return RewardResponse.fromJson(response.body);
    }else{
      throw 'error';
    }
  }

  Future<PointRedemptionResponse> getPointRedeemProducts() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.pointRedeemProducts), headers: {
      'Authorization':
      'Bearer $accessToken'
    });

    if(response.statusCode == 200){
      return PointRedemptionResponse.fromJson(response.body);
    }else{
      throw 'error';
    }
  }
}
