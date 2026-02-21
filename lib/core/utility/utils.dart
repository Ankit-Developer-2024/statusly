import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/utility/helper/storage_permission_helper.dart';
import 'package:statusly/core/utility/services/status_saf_services.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';

String getLocalImage(String name) {
  return 'assets/image/$name.png';
}

String getLocalSvg(String name) {
  return 'assets/svg/$name.svg';
}

String getLocalPng(String name) {
  return 'assets/png/$name.png';
}

String getLocalGif(String name) {
  return 'assets/gif/$name.gif';
}

void appLog(dynamic text) {
  if (kDebugMode) debugPrint(text?.toString());
}

bool isUrlCorrect(String? imagePath) {
  if (imagePath != null && imagePath.isNotEmpty) {
    bool validURL = Uri.parse(imagePath).isAbsolute;
    return validURL;
  }
  return false;
}

String getString(String key){
  return key.tr;
}

Future<void> saveVideoInsideApp(String videoUri) async {
   final String path = await StatusSafService.copyUriToFile(videoUri, type: "save");

   List<String>? data= AppPreferences.instance.getValue(StorageKeys.whatsAppSaved);

   if(data==null){
     AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,[path]);
     showToast("Video save successfully");
   }else{
     if(data.contains(path)) {
       showToast("This video is already saved");
       return;
     }
     data.add(path);
     AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,data);
     showToast("Video save successfully");
   }
}

Future<void> saveImageInsideApp(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();

  final fileName = "IMG_${DateTime.now().millisecondsSinceEpoch}.png";
  final file = File("${directory.path}/$fileName");

  await file.writeAsBytes(bytes);
  String path=file.path;

  List<String>? data= AppPreferences.instance.getValue(StorageKeys.whatsAppSaved);

  if(data==null){
    AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,[path]);
    showToast("Image save successfully");
  }else{
    if(data.contains(path)) {
      showToast("This Image is already saved");
      return;
    }
    data.add(path);
    AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,data);
    showToast("Image save successfully");
  }
}

Future<void> downloadFileToGallery(String filePath) async {
  final hasPermission = await StoragePermissionHelper.requestPermission();
  if (!hasPermission) return;

  final isVideo = filePath.toLowerCase().endsWith(".mp4");

  if (isVideo) {
    await Gal.putVideo(filePath, album: "Statusly",);
    showToast("Video download successfully");
  } else {
    await Gal.putImage(filePath, album: "Statusly",);
    showToast("Image download successfully");
  }
}

Future<void> downloadImageToGallery(Uint8List bytes) async {
  final hasPermission = await StoragePermissionHelper.requestPermission();
  if (!hasPermission) return;

  await Gal.putImageBytes(bytes, album: "Statusly",name: "IMG_${DateTime.now().millisecondsSinceEpoch.toString()}");
  showToast("Image download successfully");

}


void deleteWhatsAppLocalSavedVideo(){
   AppPreferences.instance.delete(StorageKeys.whatsAppSaved);
}

void showToast(String title){
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.grey50,
      textColor: AppColors.justBlack,
      fontSize: 16

  );

}

void shareWhatsApp(){
  SharePlus.instance.share(
      ShareParams(text: 'check out my website https://example.com')
  );
}




// import 'dart:io';
// import 'package:gal/gal.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as p;
//
// Future<bool> isAlreadySaved(String filePath) async {
//   await Permission.photos.request();
//
//   final fileName = p.basename(filePath);
//
//   final mediaList = await Gal.getMedia(
//     album: "Statusly",
//   );
//
//   for (final media in mediaList) {
//     if (media.name == fileName) {
//       return true;
//     }
//   }
//
//   return false;
// }