import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recrutment_blueray/app/core/core.dart';

enum KeyStorage {
  token,
  user,
}

mixin class StorageProvider {
  static late Box? mainBox;
  static Future<void> initHive() async {
    await Hive.initFlutter();
    mainBox = await Hive.openBox(Constants.get.storageName);
  }

  Future<void> addData<T>(KeyStorage key, T value) async {
    await mainBox?.put(key.name, value);
  }

  Future<void> removeData(KeyStorage key) async {
    await mainBox?.delete(key.name);
  }

  T getData<T>(KeyStorage key) => mainBox?.get(key.name) as T;

  Future<void> logoutBox() async {
    removeData(KeyStorage.token);
    removeData(KeyStorage.user);
  }

  Future<void> closeBox() async {
    try {
      if (mainBox != null) {
        await mainBox?.close();
        await mainBox?.deleteFromDisk();
      }
    } catch (e, stackTrace) {
      debugPrint(
        "Hive Error:\n"
        "Error: ${e.toString()}\n"
        "Stacktrace: $stackTrace",
      );
    }
  }
}
