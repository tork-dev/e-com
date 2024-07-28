import 'package:get/get.dart';

class RoutingHelper{

  urlRouting(String route){
    if(route.contains('/')){
      Get.toNamed('/');
    }else if(route.contains('/home')){
      Get.toNamed('/home');
    }
  }
}