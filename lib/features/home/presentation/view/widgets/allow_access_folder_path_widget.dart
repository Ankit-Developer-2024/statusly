import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/features/home/presentation/controller/home_controller.dart';

class AllowAccessFolderPathWidget extends GetView<HomeController> {
  const AllowAccessFolderPathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacing_15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppDimensions.spacing_18,
          children: [
            UniversalMediaView(path: getLocalGif("allow_permission")),
            Text(getString("allow_access_statuses"),style: AppTextStyles.medium18P(),textAlign: TextAlign.center),
            SizedBox(height: AppDimensions.spacing_10,),
            PrimaryButton(
              onPress: ()async{
                controller.allowFolderAccess();
              },
              title: getString("allow_access"),
              titleStyle: AppTextStyles.medium16P(color: AppColors.white),
              backgroundColor: AppColors.whatsAppGreen2,

            )
          ],
        ),
      ),
    );
  }
}
