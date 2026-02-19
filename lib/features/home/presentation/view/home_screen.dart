import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/home/presentation/controller/home_controller.dart';
import 'package:statusly/features/home/presentation/view/status_video_item.dart';
import 'package:statusly/features/home/presentation/view/widgets/allow_access_permission_widget.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getString("statusly"),style: AppTextStyles.semiBold20P(color: AppColors.white),),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:AppColors.appBarGradient,
              stops: [0.0, 0.6, 0.8, 0.9,],
            )
          ),
        ),
        toolbarHeight: AppDimensions.size_80,
      ),
      body: Obx((){
           return controller.isPermission.value
               ? Text("yes")
               : AllowAccessPermissionWidget();
         })

    );
  }
}
