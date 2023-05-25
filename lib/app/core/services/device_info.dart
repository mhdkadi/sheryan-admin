import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:sheryan_admin/app/core/helpers/data_helper.dart';

class DeviceInfo {
  DeviceInfo._();
  static DeviceInfo instance = DeviceInfo._();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return jsonEncode({
        "Platform": "Android",
        "Brand": androidInfo.brand,
        "Model": androidInfo.model,
        "Device": androidInfo.device,
        "OSVersionSdk": androidInfo.version.sdkInt.toString(),
        "OSVersionRelease": androidInfo.version.release,
        "DeviceType": androidInfo.isPhysicalDevice ? "Physical" : "Virtual",
        "AppVersion": DataHelper.packageInfo.version,
        "AppVersionCode": DataHelper.packageInfo.buildNumber,
      });
    } else {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return jsonEncode({
        "Platform": "IOS",
        "Brand": "Apple",
        "Model": iosInfo.model,
        "Device": "IPhone",
        "OSVersionSdk": "---",
        "OSVersionRelease": iosInfo.systemVersion,
        "DeviceType": iosInfo.isPhysicalDevice ? "Physical" : "Virtual",
        "AppVersion": DataHelper.packageInfo.version,
        "AppVersionCode": DataHelper.packageInfo.buildNumber,
      });
    }
  }
}
