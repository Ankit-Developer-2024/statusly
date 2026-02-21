
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statusly/core/component/dialog_box/location_permission_dialog_box.dart';

class StoragePermissionHelper{

  static checkStoragePermission()async{
    PermissionStatus checkStatus;
     if(await Permission.photos.isGranted || await Permission.videos.isGranted || await Permission.audio.isGranted){
       checkStatus=PermissionStatus.granted;
     }else if (await Permission.photos.isDenied || await Permission.videos.isDenied || await Permission.audio.isDenied){
       checkStatus = PermissionStatus.denied;
     }else{
       checkStatus = PermissionStatus.permanentlyDenied;
     }

      if(checkStatus == PermissionStatus.permanentlyDenied){
        Get.dialog(StoragePermissionDialogBox(),);
      }else if (checkStatus == PermissionStatus.denied){
        await Permission.photos.request();
        await Permission.videos.request();
        await Permission.audio.request();
        checkStoragePermission();
      }

  }

  static Future<bool> requestPermission() async {
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }

    var result = await Permission.photos.request();
    if (result.isGranted) return true;

    result = await Permission.storage.request();
    return result.isGranted;
  }

}