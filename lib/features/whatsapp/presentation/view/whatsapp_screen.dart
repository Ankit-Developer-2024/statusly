import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/image_page_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/saved_page_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/video_page_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/whatsapp_app_bar.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/whatsapp_top_button_widget.dart';

class WhatsappScreen extends GetView<WhatsAppController> {
  const WhatsappScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white, // White background
          statusBarIconBrightness: Brightness.dark, // Black icons for Android
          statusBarBrightness: Brightness.dark,   // Black icons for iOS
        ),
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              WhatsappAppBar(),
              WhatsappTopButtonWidget()
            ],
            body: PageView(
              scrollDirection: Axis.horizontal, // Default is horizontal
              pageSnapping: true,
              controller: controller.pageController,
              onPageChanged: (val){
                controller.currentPage.value=val;
                if(val==2) {
                  controller.getSavedVideo();
                }
              },
              children: <Widget>[
                ImagePageViewWidget(),
                VideoPageViewWidget(),
                SavedPageViewWidget()
              ],

            ),
          ),
        ),
      ),
    );
  }
}



