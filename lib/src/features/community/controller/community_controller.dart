import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController{
  static CommunityController get instance => Get.find();
  final GlobalKey<ScaffoldState> communityKey = GlobalKey<ScaffoldState>();


  Future<void> onRefresh()async{
    print('refresh');
  }
}