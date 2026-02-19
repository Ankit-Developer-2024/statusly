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
      "grant_permission":"Grant Permission",
      "internal":"Internal >",
      "android":"Android > ",
      "media":"media",
      "use_this_folder_uppercase":"USE THIS FOLDER",
      "use_this_folder":"Use This Folder",
      "find_and_click":"Find and Click ",
      "allow_access_statuses":"Allow access to view , download & save statuses",
      "allow_access":"Allow access",

    },
    'hi_IN':{
      'statusly': 'Statusaaaaa a a ',
      'download_save_story': 'ewfwf',
    }

  };



}