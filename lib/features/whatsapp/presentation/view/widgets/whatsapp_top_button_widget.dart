import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';

class WhatsappTopButtonWidget extends GetView<WhatsAppController> {
  const WhatsappTopButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(AppDimensions.spacing_10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radius_12)
        ),
        child: Obx(
              ()=> Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: AppDimensions.spacing_10,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    controller.pageController.jumpToPage(0);
                  },
                  child: Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_8),
                      decoration: BoxDecoration(
                          color:controller.currentPage.value==0 ? AppColors.primaryGreen : AppColors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radius_8)
                      ),
                      child: Text("Image",style: AppTextStyles.medium16P(color: controller.currentPage.value==0 ? AppColors.white : AppColors.justBlack ),textAlign: TextAlign.center,)),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    controller.pageController.jumpToPage(1);
                  },
                  child: Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_8),
                      decoration: BoxDecoration(
                          color: controller.currentPage.value==1 ? AppColors.primaryGreen : AppColors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radius_8)
                      ),
                      child: Text("Video",style: AppTextStyles.medium16P(color: controller.currentPage.value==1 ? AppColors.white : AppColors.justBlack),textAlign: TextAlign.center,)),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    controller.pageController.jumpToPage(2);
                  },
                  child: Container(
                      padding: EdgeInsets.all(AppDimensions.spacing_8),
                      decoration: BoxDecoration(
                          color: controller.currentPage.value==2 ? AppColors.primaryGreen : AppColors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radius_8)
                      ),
                      child: Text("Saved",style: AppTextStyles.medium16P(color: controller.currentPage.value==2 ? AppColors.white : AppColors.justBlack),textAlign: TextAlign.center,)),
                ),
              ),
            ],
          ),
        ),
      ),
      centerTitle: true,
      pinned: true,
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
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),

    );
  }
}
