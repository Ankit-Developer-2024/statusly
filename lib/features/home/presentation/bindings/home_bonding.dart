import 'package:get/get.dart';
import 'package:statusly/features/home/presentation/controller/home_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }

}