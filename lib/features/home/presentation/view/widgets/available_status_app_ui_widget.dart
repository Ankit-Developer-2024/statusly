import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statusly/core/routing/app_routes.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/home/presentation/controller/home_controller.dart';
import 'package:statusly/features/home/presentation/view/widgets/available_status_app_item_widget.dart';

class AvailableStatusAppUiWidget extends GetView<HomeController> {
  const AvailableStatusAppUiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacing_15),
      child: Column(
        children: [
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               crossAxisSpacing: AppDimensions.spacing_30,
               mainAxisSpacing: 10,
              ),
             children: [
               AvailableStatusAppItemWidget(
                 onTap: (){
                   Get.toNamed(AppRoutes.whatsapp);
                 },
                 imagePath: getLocalSvg("whatsapp_logo"),
                 title: getString("whatsapp"),
               ),
               AvailableStatusAppItemWidget(
                  onTap: (){
                    Get.toNamed(AppRoutes.instagram);
                  },
                  imagePath: getLocalSvg("instagram_logo"),
                  title: getString("instagram"),
               )

             ],

          ),

        ],
      ),
    );
  }
}
