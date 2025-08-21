import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import "package:hive/hive.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

abstract class Storage {
  Future<void> initStorage();
  Future<String?> getToken();
  Future<void> clearStorage();
  Future<void> saveToken({required String token});

  Future<void> storeData({required String key, dynamic value});
  Future<dynamic> getData({required String key});
}

class StorageImpl implements Storage {
  final secureStorage = const FlutterSecureStorage();

  dynamic encryptionKey;
  dynamic securedKey;

  final String securebox = "secureBox";
  final String deviceBox = "deviceBox";

  final String tokenKey = "tokenKey";

  final String secureStoragekey = "secureStoragekey";

  Future<void> _ensureEncryptionKeyLoaded() async {
    if (encryptionKey == null) {
      final String? getSecuredKey = await secureStorage.read(key: tokenKey);
      if (getSecuredKey == null) throw Exception("Encryption key not found");
      encryptionKey = base64Url.decode(getSecuredKey);
    }
  }

  @override
  Future<String?> getToken() async {
    await _ensureEncryptionKeyLoaded();
    try {
      var encryptedBox = await Hive.openBox(
        securebox,
        encryptionCipher: HiveAesCipher(encryptionKey as List<int>),
      );
      final token = encryptedBox.get(tokenKey);
      return token;
    } catch (e) {
      log("Error fetching token");
      return null;
    }
  }

  @override
  Future<void> initStorage() async {
    if (kIsWeb) return;
    try {
      final appdir = await getApplicationDocumentsDirectory();
      Hive.init(appdir.path);

      var containsEncryptionKey = await secureStorage.containsKey(
        key: tokenKey,
      );
      if (!containsEncryptionKey) {
        securedKey = Hive.generateSecureKey();
        await secureStorage.write(
          key: tokenKey,
          value: base64UrlEncode(securedKey),
        );
      }
      final String? getSecuredKey = await secureStorage.read(key: tokenKey);

      encryptionKey = base64Url.decode(getSecuredKey!);
      log("HIVE INIT");
    } catch (e, s) {
      log("Hive init err $s", name: "hive err");
    }
  }

  @override
  Future<void> saveToken({required String token}) async {
    await _ensureEncryptionKeyLoaded();
    try {
      var encryptedBox = await Hive.openBox(
        securebox,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
      encryptedBox.put(tokenKey, token);
      log("TOKEN SAVED SUCCESSFULLY");
    } catch (e) {
      log("Error saving token");
    }
  }

  @override
  Future<void> clearStorage() async {
    await Future.wait([
      Hive.deleteBoxFromDisk(securebox),
      Hive.deleteBoxFromDisk(deviceBox),
    ]);
  }

  @override
  Future getData({required String key}) async {
    final openBox = await Hive.openBox(deviceBox);
    final value = await openBox.get(key);
    await openBox.close();
    return value;
  }

  @override
  Future<void> storeData({required String key, value}) async {
    final openBox = await Hive.openBox(deviceBox);
    await openBox.put(key, value);
    await openBox.close();
  }
}
