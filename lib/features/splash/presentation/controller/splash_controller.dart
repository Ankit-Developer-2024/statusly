import 'dart:async';

import 'package:get/get.dart';
import 'package:statusly/core/routing/app_routes.dart';

class SplashController extends GetxController{


  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init(){
    Timer(Duration(seconds: 3), (){
      Get.offAllNamed(AppRoutes.home);
    });
  }
}