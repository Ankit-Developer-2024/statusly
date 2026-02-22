import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper{
 static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<int> androidDeviceVersion()async{
    AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
    return int.parse(androidInfo.version.release);
  }
}