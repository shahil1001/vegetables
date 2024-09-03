import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class Prefs {
  static const String token = "token";
  static const String userToken = "user_id";
  static const String name = "name";
  static const String email = "email";
  static const String address = "address";
  static const String profession = "profession";
  static const String summary = "summary";
  static const String profileUrl = "profileUrl";
  static const String coverUrl = "coverUrl";
  static const String isPremiumUser = "isPremiumUser";
  static const String selectedLangId = "languageType";
  static const String deviceToken = "device_token";

  static read(String key) {
    var box = GetStorage();
    return box.read(key);
  }

  static write(String key, value) {
    var box = GetStorage();
    box.write(key, value);
  }

  static readObj(String key) {
    var box = GetStorage();
    var data = box.read(key);
    return data != null ? json.decode(data) : null;
  }

  static writeObj(String key, value) {
    var box = GetStorage();
    box.write(key, json.encode(value));
  }

  static erase() {
    String tempToken = '';
    var box = GetStorage();
    tempToken = box.read("user_id");
    box.erase();
    box.write("user_id", tempToken);
  }

}
