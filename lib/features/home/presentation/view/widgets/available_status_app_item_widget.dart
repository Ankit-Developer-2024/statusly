import 'package:flutter/material.dart';
import 'package:statusly/core/component/widgets/universal_media_view.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/core/styles/app_text_styles.dart';

class AvailableStatusAppItemWidget extends StatelessWidget {
  const AvailableStatusAppItemWidget({super.key,required this.onTap,required this.imagePath,required this.title});

  final VoidCallback? onTap;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radius_12),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.grey50.withAlpha(130),
            borderRadius: BorderRadius.circular(AppDimensions.radius_12)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppDimensions.spacing_15,
          children: [
            UniversalMediaView(
              path: imagePath,
              fit: BoxFit.contain,
              imageWidth:90,
              imageHeight: 90,
              placeHolder: Icon(Icons.image_outlined,size: 90,color: AppColors.grey600,),
              errorWidget: Icon(Icons.image_outlined,size: 90,color: AppColors.grey600,),
            ),
            Text(title,style: AppTextStyles.medium16P(),)
          ],
        ),
      ),
    );
  }
}
