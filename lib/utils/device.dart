import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

Future<String> getOrGenerateDeviceId() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'device_id';

  String? storedId = prefs.getString(key);
  if (storedId != null) {
    return storedId;
  }

  String newId = await getDeviceId() ?? const Uuid().v4();

  await prefs.setString(key, newId);
  return newId;
}

Future<String?> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
  } catch (e) {
    debugPrint("Error getting device ID: $e");
  }
  return null;
}