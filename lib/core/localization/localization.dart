import 'dart:ui';

import 'package:get/get.dart';

class AppLocalization  extends Translations{

  static const Locale englishLocale= Locale('en', 'US');
  static const Locale hindiLocale= Locale('hi', 'IN');
  static const Locale fallbackLocale= Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'statusly': 'Statusly',
      'download_save_story': 'Download & Save Story',
      "cancel":"Cancel",
      "permission_required":"Permission Required",
      "folder_path_permission":"To save & download statuses , folder path permission is required",
      "internal":"Internal >",
      "android":"Android > ",
      "media":"media",
      "use_this_folder_uppercase":"USE THIS FOLDER",
      "use_this_folder":"Use This Folder",
      "find_and_click":"Find and Click ",
      "allow_access_statuses":"Allow access to view , download & save statuses",
      "allow_access":"Allow access",
      "whatsapp":"WhatsApp",
      "open_whatsapp":"Open WhatsApp",
      "instagram":"Instagram",
      "snapchat":"SnapChat",
      "status":"Status",
      "repost":"Repost",
      "share":"Share",
      "save":"Save",
      "download":"Download",
      "saved_empty_folder_msg":"Nothing here yet! Add your first status to share moments with friends.",
      "empty_status_msg":"No status update yet—please check story on WhatsApp.",
      "whatsapp_not_installed":"WhatsApp is not installed",
      "image_download_successfully":"Image download successfully",
      "image_save_successfully":"Image save successfully",
      "image_already_saved":"This Image is already saved",
      "video_download_successfully":"Video download successfully",
      "video_save_successfully":"Video save successfully",
      "video_already_saved":"This video is already saved",
    },
    'hi_IN':{
      'statusly': 'Statusaaaaa a a ',
      'download_save_story': 'ewfwf',
    }

  };



}