import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DeviceKeyManager {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Generate device-specific key
  Future<String> generateDeviceSpecificKey() async {
    // Get device info (for example, Android or iOS)
    var deviceInfo = await _deviceInfo.deviceInfo;
    String deviceIdentifier = "";

    if (deviceInfo is AndroidDeviceInfo) {
      deviceIdentifier = deviceInfo.fingerprint;
    } else if (deviceInfo is IosDeviceInfo) {
      deviceIdentifier = deviceInfo.identifierForVendor!; // Unique ID for iOS
    }

    // You can apply additional logic here for combining the device ID with something else

    // Generate a hashed key from the device identifier
    var key = _generateHashKey(deviceIdentifier);

    // Store the key securely
    await _secureStorage.write(key: 'device_key', value: key);

    return key;
  }

  // Retrieve the stored key
  Future<String?> getStoredKey() async {
    return await _secureStorage.read(key: 'device_key');
  }

  // Generate a hashed key (SHA256 for example)
  String _generateHashKey(String deviceIdentifier) {
    var bytes = utf8.encode(deviceIdentifier); // Convert the string to bytes
    var hash = sha256.convert(bytes); // Generate SHA256 hash
    return hash.toString();
  }
}
