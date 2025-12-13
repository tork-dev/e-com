import 'package:get/get.dart';
import 'package:kirei/src/features/my_coupons/model/my_coupons_model.dart';
import 'package:kirei/src/utils/logging/logger.dart';

import '../repository/my_coupons_repository.dart';

class MyCouponsController extends GetxController{
  static MyCouponsController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<MyCouponListModel> myCoupons = MyCouponListModel().obs;
  Rx<CouponList> selectedCoupon = CouponList().obs;





  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }

  Future<void> getCoupons() async {
    try {
      hittingApi.value = true;
      myCoupons.value = await MyCouponsRepository().getMyCoupons();
    }catch(e){
      Log.e(e.toString());
    }finally{
      hittingApi.value = false;
    }

  }

}