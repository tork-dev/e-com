import 'package:http/http.dart' as http;
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

import '../model/membership_level_model.dart';
import '../model/point_redemption_model.dart';
import '../model/reward_history_model.dart';
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

  Future<MemberShipLevelResponse> getMembershipLevel() async{
    final response = await http.get(Uri.parse(AppApiEndPoints.pointLevel));
    return MemberShipLevelResponse.fromJson(response.body);
  }

  Future<RewardHistoryResponse> getRewardHistory()async{
    final response = await http.get(Uri.parse(AppApiEndPoints.rewardHistory), headers: {
      'Authorization': 'Bearer $accessToken'
    });
    return RewardHistoryResponse.fromJson(response.body);
  }
}
