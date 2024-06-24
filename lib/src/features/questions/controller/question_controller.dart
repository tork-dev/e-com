import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController{
  static QuestionController get instance => Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();


  RxDouble givenRating = 1.0.obs;


  Future<void> onRefresh() async{
    print('resresh');
  }
 }