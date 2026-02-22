import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/empty_status_folder_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/image_view_widget.dart';

class ImagePageViewWidget extends GetView<WhatsAppController> {
  const ImagePageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          Obx((){
            return controller.images.isEmpty
              ? EmptyStatusFolderWidget()
              : SliverPadding(
              padding: EdgeInsets.all(AppDimensions.spacing_15),
              sliver: SliverGrid.builder(
                itemCount: controller.images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppDimensions.spacing_10,
                  crossAxisSpacing: AppDimensions.spacing_10,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey400,
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: AppDimensions.spacing_3,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              ImageViewWidget(image: controller.images[index]),
                            );
                          },
                          child: Container(
                            height: 150,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius_8,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radius_8,
                              ),
                              child: Image.memory(
                                controller.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: AppDimensions.spacing_4,
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  onPress: () {
                                    saveImageInsideApp(controller.images[index]);
                                  },
                                  leftIcon: UniversalMediaView(
                                    path: getLocalPng("save_logo"),
                                    imageHeight: 17,
                                  ),
                                  backgroundColor: AppColors.primaryGreen.withAlpha(
                                    200,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  onPress:(){
                                    downloadImageToGallery(controller.images[index]);
                                  },
                                  leftIcon: Icon(
                                    Icons.save_alt_rounded,
                                    size: 17,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          })
        ],
      );

  }
}
