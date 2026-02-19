import 'package:get/get.dart';
import 'package:statusly/features/splash/presentation/controller/splash_controller.dart';

class SplashBinding  implements Bindings{
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }

}