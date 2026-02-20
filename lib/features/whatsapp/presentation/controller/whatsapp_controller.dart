import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/utility/services/status_saf_services.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';
import 'package:statusly/features/home/presentation/view/widgets/dialog_box/grant_permission_uri_path.dart';

class WhatsAppController extends GetxController{

  final PageController pageController=PageController(initialPage: 0);

  RxInt currentPage = 0.obs;

  RxList<Uint8List> images=<Uint8List>[].obs;
  RxList<String> videos=<String>[].obs;
  RxBool isPermission=true.obs;

  @override
  void onInit() {
    super.onInit();
    loadStatuses();
  }

  void loadStatuses() async {
    String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
    if(savedUri==null || savedUri.isEmpty){
      isPermission.value=false;
      Get.dialog(GrantPermissionUriPath()).then((val){
        String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
        if(savedUri!=null && savedUri.isNotEmpty)  isPermission.value=true;
        return;
      });
    }

    final files = await StatusSafService.readStatuses(savedUri!);

    for(int i=0;i<files.length;i++){
      if(files[i].endsWith(".jpg")){
        Uint8List? data=  await StatusSafService.getImageBytes(files[i]);
        if(data!=null){
          images.add(data);
          images.add(data);
        }
      }else if(files[i].endsWith(".mp4")){
        videos.add(files[i]);
      }
    }
  }


}