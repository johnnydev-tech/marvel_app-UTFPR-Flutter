import 'dart:developer';

import 'package:flutter/services.dart';

class DeviceInfoService {
  static const platform = MethodChannel('tech.johnnydev.marvelapp.deviceinfo');

  Future<String> getDeviceInfo() async {
    try {
      final String deviceInfo = await platform.invokeMethod('getDeviceInfo');
      return deviceInfo;
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
      return "Erro: ${e.message}";
    }
  }
}
