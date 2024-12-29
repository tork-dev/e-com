import 'package:get/get.dart';
import 'package:kirei/src/features/notification/model/user_notification_response.dart';
import 'package:kirei/src/features/notification/repositories/notification_repositories.dart';

class NotificationController extends GetxController{
  static NotificationController get instance => Get.find();

  RxBool hittingApi = false.obs;
  Rx<UserNotificationResponse> notificationList = UserNotificationResponse().obs;


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future <void> onRefresh() async{
    getNotificationList();
  }

  Future<void> getNotificationList() async{
    hittingApi.value = true;
    notificationList.value = await NotificationRepo().getNotificationList();
    hittingApi.value = false;
  }
}