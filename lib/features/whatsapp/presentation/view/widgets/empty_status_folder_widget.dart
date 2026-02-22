import 'package:flutter/material.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';
import 'package:statusly/core/utility/utils.dart';

class EmptyStatusFolderWidget extends StatelessWidget {
  const EmptyStatusFolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: AppDimensions.spacing_15,right: AppDimensions.spacing_15,top: AppDimensions.spacing_40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppDimensions.spacing_15,
          children: [
            UniversalMediaView(path: getLocalPng("empty_folder")),
            Text(getString("empty_status_msg"),style: AppTextStyles.medium16P(),textAlign: TextAlign.center),
            PrimaryButton(
              onPress: (){
                launchWhatsApp();
              },
              title: getString("open_whatsapp"),
            )
          ],
        ),
      ),
    );
  }
}
