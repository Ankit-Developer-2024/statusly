import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/utility/helper/device_info_helper.dart';
import 'package:statusly/core/method_channels/status_saf_method_channel.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
   String path;
   if(isAndroid()){
     if(await DeviceInfoHelper.androidDeviceVersion()>=11){
       path = await StatusSafMethodChannel.copyUriToFile(videoUri,type: "save");
     }else{
       // for version <=10
       path = await StatusSafMethodChannel.copyUriToFile(videoUri,type: "save");
     }
   }else{
     //IOS
     path = await StatusSafMethodChannel.copyUriToFile(videoUri,type: "save");
   }

   List<String>? data= AppPreferences.instance.getValue(StorageKeys.whatsAppSaved);

   if(data==null){
     AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,[path]);
     showToast(getString("video_save_successfully"));
   }else{
     if(data.contains(path)) {
       showToast(getString("video_already_saved"));
       return;
     }
     data.add(path);
     AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,data);
     showToast(getString("video_save_successfully"));
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
    showToast(getString("image_save_successfully"));
  }else{
    if(data.contains(path)) {
      showToast(getString("image_already_saved"));
      return;
    }
    data.add(path);
    AppPreferences.instance.putValue(StorageKeys.whatsAppSaved,data);
    showToast(getString("image_save_successfully"));
  }
}

Future<void> downloadFileToGallery(String filePath) async {

  final isVideo = filePath.toLowerCase().endsWith(".mp4");

  if (isVideo) {
    await Gal.putVideo(filePath, album: "Statusly",);
    showToast(getString("video_download_successfully"));
  } else {
    await Gal.putImage(filePath, album: "Statusly",);
    showToast(getString("image_download_successfully"));
  }
}

Future<void> downloadImageToGallery(Uint8List bytes) async {
  try{
    await Gal.putImageBytes(bytes, album: "Statusly",name: "IMG_${DateTime.now().millisecondsSinceEpoch.toString()}");
    showToast(getString("image_download_successfully"));
  }catch(e){
    appLog(e);
  }

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

void shareApp(){
  SharePlus.instance.share(
      ShareParams(text: 'check out my website https://example.com')
  );
}

bool isAndroid(){
  return Platform.isAndroid;
}

bool isIOS(){
  return Platform.isIOS;
}

Future<void> launchWhatsApp() async {
  const url = 'whatsapp://status'; // Example URL scheme for WhatsApp
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    showToast(getString("whatsapp_not_installed"));
  }
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