import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/status_video_item.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';

class VideoViewWidget extends StatelessWidget {
  const VideoViewWidget({super.key,required this.videoUri});
  final String videoUri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getString("status"),style: AppTextStyles.medium20P(color: AppColors.white),),
        titleSpacing: 0,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_rounded,color: AppColors.white,)),
        backgroundColor: AppColors.justBlack,
      ),
      backgroundColor: AppColors.justBlack,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.shrink(),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height-300),
                  child: StatusVideoItem(uri: videoUri, isShowButton: true)
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: AppDimensions.spacing_15,right:AppDimensions.spacing_15,bottom: AppDimensions.spacing_15 ),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){}, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_5,
                    children: [
                      Icon(Icons.repeat_rounded,size: 20,color: AppColors.white,),
                      Text(getString("repost"),style: AppTextStyles.medium16P(color: AppColors.white),),
                    ],
                  )),

                  TextButton(onPressed: (){}, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_5,
                    children: [
                      Icon(Icons.share_outlined,size: 20,color: AppColors.white,),
                      Text(getString("share"),style: AppTextStyles.medium16P(color: AppColors.white),),
                    ],
                  )),
                  TextButton(onPressed: (){}, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_5,
                    children: [
                      UniversalMediaView(path:getLocalPng("save_logo"),imageHeight: 17,),
                      Text(getString("save"),style: AppTextStyles.medium16P(color: AppColors.white),),
                    ],
                  )),
                  TextButton(onPressed: (){}, child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_5,
                    children: [
                      Icon(Icons.save_alt_rounded,size: 20,color: AppColors.white,),
                      Text(getString("download"),style: AppTextStyles.medium16P(color: AppColors.white),),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
