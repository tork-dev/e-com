import 'package:get/get.dart';

class ReviewController extends GetxController{
  static ReviewController get instance => Get.find();


  Future<void> onRefresh() async{
    print('resresh');
  }
 }