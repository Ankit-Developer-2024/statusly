import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/image_page_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/video_page_view_widget.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/whatsapp_app_bar.dart';
import 'package:statusly/features/whatsapp/presentation/view/widgets/whatsapp_top_button_widget.dart';

class WhatsappScreen extends GetView<WhatsAppController> {
  const WhatsappScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            },
            children: <Widget>[
              ImagePageViewWidget(),

              VideoPageViewWidget(),

              Center(
                child: Text('Page 3', style: TextStyle(fontSize: 24)),
              ),
            ],

          ),
        ),
      ),
    );
  }
}



