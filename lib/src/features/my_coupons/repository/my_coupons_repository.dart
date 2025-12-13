import 'package:http/http.dart' as http;
import 'package:kirei/src/features/my_coupons/model/my_coupons_model.dart';
import 'package:kirei/src/utils/constants/app_api_end_points.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';

class MyCouponsRepository {
  final accessToken = AppLocalStorage().readData(LocalStorageKeys.accessToken);


  Future<MyCouponListModel> getMyCoupons() async {
    final response = await http.get(Uri.parse(AppApiEndPoints.myCoupons), headers:{
      "Authorization": "Bearer $accessToken"
    });
    return MyCouponListModel.fromJson(response.body);
  }
}