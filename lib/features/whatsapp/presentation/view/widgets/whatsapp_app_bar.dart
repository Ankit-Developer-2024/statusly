import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';

class WhatsappAppBar extends StatelessWidget {
  const WhatsappAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: (){
          shareWhatsApp();
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:AppColors.appBarGradient,
                stops: [0.0, 0.6, 0.8, 0.9,],
              )
          ),
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: AppDimensions.spacing_15),
            padding: EdgeInsets.all(AppDimensions.spacing_15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radius_12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppDimensions.spacing_15,
                  children: [
                    UniversalMediaView(path: getLocalSvg("whatsapp_logo"),imageHeight: 30,),
                    Text(getString("whatsapp"),style: AppTextStyles.medium16P(),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
