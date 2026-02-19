


import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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
