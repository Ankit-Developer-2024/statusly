import 'dart:io';

import 'package:flutter/services.dart';
import 'package:statusly/core/utility/constants/storage_keys.dart';
import 'package:statusly/core/wrapper/preferences/app_preferences.dart';

class StatusSafService {
  static const _channel = MethodChannel('status_saf_channel');

  static Future<void> openFolderPicker() async {
    final uri = await _channel.invokeMethod("openFolderPicker");
    AppPreferences.instance.putValue(StorageKeys.whatsAppUri,uri);
  }

  static Future<List<String>> readStatuses(String uri) async {
    final files = await _channel.invokeMethod(
      "readStatuses",
      {"uri": uri},
    );

    return List<String>.from(files);
  }

   static Future<Uint8List?> getImageBytes(String uri) async {
    final bytes = await _channel.invokeMethod<Uint8List>(
      'getImageBytes',
      {"uri": uri},
    );
    return bytes;
  }

  static Future<String> copyUriToFile(String uri, {required String type}) async {
    final String path = await _channel.invokeMethod(
      'copyContentUriToFile',
      {
        'uri': uri,
        "type":type,
      },

    );
    return path;
  }

  static Future<bool> saveUriVideo(String uri) async {
    final bool isSaved = await _channel.invokeMethod(
      'saveUriVideo',
      {
        'uri': uri,
      },

    );
    return isSaved;
  }

}
