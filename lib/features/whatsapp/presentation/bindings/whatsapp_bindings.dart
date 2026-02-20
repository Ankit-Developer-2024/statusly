import 'package:get/get.dart';
import 'package:statusly/features/whatsapp/presentation/controller/whatsapp_controller.dart';

class WhatsAppBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<WhatsAppController>(WhatsAppController());
  }

}