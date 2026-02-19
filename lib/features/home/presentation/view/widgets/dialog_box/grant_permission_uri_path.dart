import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/services/status_saf_services.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/home/presentation/controller/home_controller.dart';

class GrantPermissionUriPath extends GetView<HomeController> {
  const GrantPermissionUriPath({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getString("permission_required"),style: AppTextStyles.semiBold16P(),textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: AppDimensions.size_110,
                padding: EdgeInsets.all(AppDimensions.spacing_15),
                decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      top:  BorderSide(color: AppColors.grey700),
                      right:  BorderSide(color: AppColors.grey700),
                      left:  BorderSide(color: AppColors.grey700),
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radius_12)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: AppTextStyles.medium14P(color: AppColors.grey600),
                          children: [
                            TextSpan(text: getString("internal")),
                            TextSpan(text: getString("android")),
                            TextSpan(text: getString("media"),style: AppTextStyles.medium14P(color: AppColors.instaGramPink)),
                          ]
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacing_28,),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  PrimaryButton(
                    title: getString("use_this_folder_uppercase"),
                    titleStyle: AppTextStyles.semiBold16P(color: AppColors.white),
                    backgroundColor: AppColors.instaGramPink,
                  ),
                  Icon(Icons.touch_app_outlined,color: AppColors.white,size: AppDimensions.size_32,)
                ],
              )
            ],
          ),
          SizedBox(height: AppDimensions.spacing_15,),
          Text(getString("To save & download statuses , storage permission is required"),style: AppTextStyles.medium14P(),textAlign: TextAlign.center,),
          SizedBox(height: AppDimensions.spacing_15,),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_10,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: AppColors.whatsAppGreen,
                  borderRadius: BorderRadius.circular(AppDimensions.radius_100),
                ),
              ),
              Expanded(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      style: AppTextStyles.medium14P(color: AppColors.grey700),

                      children: [
                        TextSpan(text: getString("find_and_click"),),
                        TextSpan(text: getString("use_this_folder"),style: AppTextStyles.semiBold14P()),
                      ]
                  ),
                ),
              ),
            ],
          )

        ],
      ),
      actions: [
        PrimaryButton(
          onPress: () async{
            await StatusSafService.openFolderPicker();
          },
          title: getString("grant_permission"),
          titleStyle: AppTextStyles.medium16P(color: AppColors.white),
        )
      ],
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radius_12)),
    );
  }
}
