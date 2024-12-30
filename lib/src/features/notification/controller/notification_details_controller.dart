import 'package:get/get.dart';
import 'package:kirei/src/features/notification/model/user_notification_response.dart';
import 'package:kirei/src/features/notification/repositories/notification_repositories.dart';

class NotificationDetailsController extends GetxController{
  static NotificationDetailsController get instance => Get.find();

  final int notificationId;
  NotificationDetailsController({required this.notificationId});

  RxBool hittingApi = false.obs;
  Rx<UserNotificationResponse> userNotification = UserNotificationResponse().obs;


  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future <void> onRefresh() async{
    getNotificationDetails();
  }

  Future<void> getNotificationDetails() async{
    hittingApi.value = true;
    userNotification.value = await NotificationRepo().getNotificationDetails(notificationId);
    hittingApi.value = false;
  }
}