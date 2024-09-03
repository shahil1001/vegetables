import 'package:flutter_api_call_with_mvc/core/extensions/string_extensions.dart';
class SignUpModel {
  String? title;
  String? message;
  UserData? data;

  SignUpModel({this.title, this.message, this.data});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      title: json['title'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userToken;
  int? id;
  String? name;
  String? mobile;
  String? email;

  UserData({this.userToken, this.id, this.name, this.mobile, this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userToken: json['user_token'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_token'] = this.userToken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

