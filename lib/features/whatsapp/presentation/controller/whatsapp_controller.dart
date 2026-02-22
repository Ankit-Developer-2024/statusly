import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:statusly/core/method_channels/status_saf_method_channel.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/utility/helper/device_info_helper.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';
import 'package:statusly/features/home/presentation/view/widgets/dialog_box/allow_access_folder_path_dialog_box.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class WhatsAppController extends GetxController{

  final PageController pageController=PageController(initialPage: 0);

  RxInt currentPage = 0.obs;

  RxList<Uint8List> images=<Uint8List>[].obs;
  RxList<String> videos=<String>[].obs;
  RxList<String> savedVideos=<String>[].obs;
  RxBool isPermission=true.obs;
  Map<String, Uint8List?> videoThumbnailCache = {};
  Map<String, Uint8List?> savedVideoThumbnailCache = {};

  @override
  void onInit(){
    super.onInit();
    loadStatuses();
  }

  void loadStatuses()async{
    if(isAndroid()){
      if(await DeviceInfoHelper.androidDeviceVersion()>=11){
        loadAndroidStatuses();
      }else{
        // For version <=10
        loadAndroidStatuses();
      }

    }else{
      // For IOS
    }
  }

  void loadAndroidStatuses() async {
    //verified that is suitable for android version 11+
    String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
    if(savedUri==null || savedUri.isEmpty){
      isPermission.value=false;
      Get.dialog(AllowAccessFolderPathDialogBox()).then((val){
        String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
        if(savedUri!=null && savedUri.isNotEmpty)  isPermission.value=true;
        return;
      });
    }

    final files = await StatusSafMethodChannel.readStatuses(savedUri!);

    for(int i=0;i<files.length;i++){
      if(files[i].endsWith(".jpg")){
        Uint8List? data=  await StatusSafMethodChannel.getImageBytes(files[i]);
        if(data!=null){
          images.add(data);
        }
      }else if(files[i].endsWith(".mp4")){
        videos.add(files[i]);
      }
    }
  }

  Future<Uint8List?> generateVideoThumbnail(String videoContentUri) async {
   try{

     if (videoThumbnailCache.containsKey(videoContentUri)) {
       return videoThumbnailCache[videoContentUri];
     }
     String path;
     if(isAndroid()){
       if(await DeviceInfoHelper.androidDeviceVersion()>=11){
         path = await StatusSafMethodChannel.copyUriToFile(videoContentUri,type: "thumbnail");
       }else{
         // for version <=10
         path = await StatusSafMethodChannel.copyUriToFile(videoContentUri,type: "thumbnail");
       }
     }else{
       //IOS
       path = await StatusSafMethodChannel.copyUriToFile(videoContentUri,type: "thumbnail");
     }

     final thumbnail = await VideoThumbnail.thumbnailData(
       video: path,
       imageFormat: ImageFormat.JPEG,
       quality: 75,
     );

     videoThumbnailCache[videoContentUri] = thumbnail;
     return thumbnail;
   }catch(e){
     appLog(e);
     return null;
   }
  }

  Future<Uint8List?> generateSavedVideoThumbnail(String videoContentPath) async {
   try{

     if (savedVideoThumbnailCache.containsKey(videoContentPath)) {
       return savedVideoThumbnailCache[videoContentPath];
     }

     final thumbnail = await VideoThumbnail.thumbnailData(
       video: videoContentPath,
       imageFormat: ImageFormat.JPEG,
       quality: 75,
     );

     savedVideoThumbnailCache[videoContentPath] = thumbnail;
     return thumbnail;
   }catch(e){
     appLog(e);
     return null;
   }
  }

  void getSavedVideo()async{
    List<String>? savedVideoPath=await AppPreferences.instance.getValue(StorageKeys.whatsAppSaved);
    if(savedVideoPath==null || savedVideoPath.isEmpty){
      savedVideos.clear();
    }else{
      savedVideos.clear();
      savedVideos.addAll(List.from(savedVideoPath));
    }
  }

  Future<void> deleteSavedVideo(String path,int index) async {
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
      savedVideos.removeAt(index);
      if(savedVideos.isEmpty){
        AppPreferences.instance.delete(StorageKeys.whatsAppSaved);
      }else{
        AppPreferences.instance.putValue(StorageKeys.whatsAppSaved, List<String>.from(savedVideos).toList());
      }
      showToast("Deleted successfully");
    } else {
      showToast("Video not found");
    }
  }

  Future<void> downloadVideoToGallery(String path)async{
    bool isSaved;
    if(isAndroid()){
      if(await DeviceInfoHelper.androidDeviceVersion()>=11){
        isSaved= await StatusSafMethodChannel.saveUriVideo(path);
      }else{
        //version <=10
        isSaved= await StatusSafMethodChannel.saveUriVideo(path);
      }
    }else{
      //IOS
      isSaved= await StatusSafMethodChannel.saveUriVideo(path);
    }

    if(isSaved){
      showToast("Video download successfully");
    }else{
      showToast("Unable to download video");
    }
  }

}