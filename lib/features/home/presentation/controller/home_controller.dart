import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/utility/helper/device_info_helper.dart';
import 'package:statusly/core/method_channels/status_saf_method_channel.dart';
import 'package:statusly/core/utility/utils.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';
import 'package:statusly/features/home/presentation/view/widgets/dialog_box/allow_access_folder_path_dialog_box.dart';


class HomeController extends FullLifeCycleController with FullLifeCycleMixin{

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  RxBool isFolderPermission=false.obs;

  @override
  void onReady() {
    super.onReady();
    String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
    if(savedUri==null || savedUri.isEmpty){
      isFolderPermission.value=false;
      Get.dialog(AllowAccessFolderPathDialogBox()).then((val){
        String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
        if(savedUri!=null && savedUri.isNotEmpty) isFolderPermission.value=true;
      });
    }else{
      isFolderPermission.value=true;
    }
  }

  void allowFolderAccess()async{
    if(isAndroid()){
      if(await DeviceInfoHelper.androidDeviceVersion()>=11){
        await StatusSafMethodChannel.openFolderPicker().then((val){
          String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
          if(savedUri!=null && savedUri.isNotEmpty) isFolderPermission.value=true;
        });
      }else{
        //version <=10
        await StatusSafMethodChannel.openFolderPicker().then((val){
          String? savedUri= AppPreferences.instance.getValue(StorageKeys.whatsAppUri);
          if(savedUri!=null && savedUri.isNotEmpty) isFolderPermission.value=true;
        });
      }
    }else{
      //IOS
    }
  }

  @override
  void onDetached() {
  }

  @override
  void onHidden() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
    if(Get.isDialogOpen ?? false){
      Get.back();
    }
  }



  }

