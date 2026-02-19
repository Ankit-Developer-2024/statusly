
import 'package:get/get.dart';
import 'package:statusly/core/routing/app_routes.dart';
import 'package:statusly/features/home/presentation/bindings/home_bonding.dart';
import 'package:statusly/features/home/presentation/view/home_screen.dart';
import 'package:statusly/features/splash/presentation/bindings/splash_binding.dart';
import 'package:statusly/features/splash/presentation/view/splash_screen.dart';

class AppPages{

  static List<GetPage> getPages = [
    GetPage(
       name: AppRoutes.splash,
       page: ()=> SplashScreen(),
       binding: SplashBinding(),
    ),
    GetPage(
       name: AppRoutes.home,
       page: ()=> HomeScreen(),
       binding: HomeBinding(),
    ),
  ];

}