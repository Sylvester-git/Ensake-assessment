import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import "package:hive/hive.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

abstract class Storage {
  Future<void> initStorage();
  Future<String?> getToken();
  Future<void> saveToken({required String token});
}

class StorageImpl implements Storage {
  final secureStorage = const FlutterSecureStorage();

  dynamic encryptionKey;
  dynamic securedKey;
  final String securebox = "secureBox";
  final String tokenKey = "tokenKey";
  @override
  Future<String?> getToken() async {
    var encryptedBox = await Hive.openBox(
      securebox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    final token = encryptedBox.get(tokenKey);
    return token;
  }

  @override
  Future<void> initStorage() async {
    if (kIsWeb) return;
    final appdir = await getApplicationDocumentsDirectory();
    Hive.init(appdir.path);

    var containsEncryptionKey = await secureStorage.containsKey(key: tokenKey);
    if (!containsEncryptionKey) {
      securedKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: tokenKey,
        value: base64UrlEncode(securedKey),
      );
    }
    final String? getSecuredKey = await secureStorage.read(key: tokenKey);

    encryptionKey = base64Url.decode(getSecuredKey!);
  }

  @override
  Future<void> saveToken({required String token}) async {
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
}
