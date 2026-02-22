import 'dart:io';

import 'package:get/get.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/component/widgets/video_view_widget.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/image_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/saved_status_empty_widget.dart';

class SavedPageViewWidget extends GetView<WhatsAppController> {
  const SavedPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Obx((){
        return controller.savedVideos.isEmpty
          ? SavedStatusEmptyWidget()
          : SliverPadding(
          padding: EdgeInsets.all(AppDimensions.spacing_15),
          sliver: SliverGrid.builder(
              itemCount: controller.savedVideos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppDimensions.spacing_10,
                  crossAxisSpacing: AppDimensions.spacing_10,
                  mainAxisExtent: 200
              ),
              itemBuilder: (context,index){
                final filePath = controller.savedVideos[index];
                return Container(
                  decoration: BoxDecoration(
                      color:AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                      boxShadow: [
                        BoxShadow(color: AppColors.grey400,spreadRadius: 1,blurRadius: 1.5,offset: Offset(0, 1))
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_3,
                    children: [
                      InkWell(
                        onTap: (){
                         filePath.endsWith("png")
                         ? Get.to(ImageViewWidget(image: File(filePath).readAsBytesSync()),)
                         : Get.to(VideoViewWidget(videoUri: filePath));
                        },
                        child: Container(
                          height:150,
                          width: double.maxFinite,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                              child: filePath.endsWith("png")
                                     ? Image.file(File(filePath),fit: BoxFit.fill,)
                                     : FutureBuilder(
                                  future: controller.generateSavedVideoThumbnail(filePath),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                                      return Image.memory(snapshot.data!,fit: BoxFit.fill,);
                                    }else if(snapshot.hasError){
                                      return Icon(Icons.image_outlined);
                                    }else{
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade200,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          width: double.maxFinite,
                                          height: 100,
                                          color: AppColors.white,
                                        ),
                                      );
                                    }
                                  }
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  3.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: AppDimensions.spacing_4,
                          children: [
                            Expanded(
                                child: PrimaryButton(
                                  onPress: (){
                                    controller.deleteSavedVideo(filePath, index);
                                  },
                                  leftIcon: Icon(Icons.delete_outline,size: 18,color: AppColors.white,),
                                  backgroundColor:AppColors.redAccent
                                )),
                            Expanded(
                                child: PrimaryButton(
                                  onPress:(){
                                    downloadFileToGallery(filePath);
                                  },
                                  leftIcon: Icon(Icons.save_alt_rounded,size: 17,color: AppColors.white,),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        );
      })
      ],
    );
  }
}
