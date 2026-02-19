import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/splash/presentation/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UniversalMediaView(
              path: getLocalPng("statusly_logo"),
              imageHeight: AppDimensions.size_180,
            ),
            SizedBox(height: AppDimensions.spacing_18,),
            Text(getString("statusly"),style: AppTextStyles.semiBold20P(),),
            Text(getString("download_save_story"),style: AppTextStyles.semiBold20P(),)
          ],
        ),
      ),
    );
  }
}
