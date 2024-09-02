import 'dart:convert';
import 'dart:developer';

import 'package:flutter_api_call_with_mvc/core/network_utility/api_hitter.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/app_end_points.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/model/login_model.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/model/sign_up_model.dart';

class AuthProvider{
  var apiHitter = ApiHitter();

  Future<LoginModel?> loginRequest({required var body}) async {
    try {
      log("body---${body}");
      var response = await apiHitter.postApii(
          endPoint: EndPoints.login,
          body: body
      );
      return LoginModel.fromJson(response.data);
    } catch (e) {
      log("Error>> ${e.toString()}");
      return null;

    }
  }
  Future<SignUpModel?> signUpRequest({required var body,bool showError=true}) async {
    try {
      var response = await apiHitter.multiPart(
          endPoint: EndPoints.register,
          body: body,
        showErrorDialog: showError
      );
      return SignUpModel.fromJson(jsonDecode(response.data));
    } catch (e) {
      log("Error>> ${e.toString()}");
      return null;

    }
  }

}