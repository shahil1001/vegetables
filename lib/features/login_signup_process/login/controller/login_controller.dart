import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api_call_with_mvc/core/auth_provider/auth_provider.dart'
    as provider;
import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/dio_exceptions.dart';
import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/core/utils/ui_utils.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/model/login_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../core/routes/app_routes.dart';

class LoginController extends GetxController {
  provider.AuthProvider authProvider = provider.AuthProvider();

  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var emailFocusNode = FocusNode().obs;
  var pwdFocusNode = FocusNode().obs;
  RxBool showPwd = false.obs;
  String emailErrorMsg = '';
  String pwdErrorMsg = '';
  RxBool isEmailError = false.obs;
  RxBool isPwdError = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
    pwdFocusNode.value.addListener(() {
      pwdFocusNode.refresh();
    });
    super.onInit();
  }

  @override
  void onClose() {
    disposeInitialization();
    super.onClose();
  }

  disposeInitialization() {
    pwdFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    disableFocus();
  }

  void cleanFields() {
    emailController.clear();
    pwdController.clear();
  }

  void disableFocus() {
    emailErrorMsg = '';
    pwdErrorMsg = '';
    showPwd.value = false;
    isEmailError.value = false;
    isPwdError.value = false;
  }

  onScreenClick() {
    // dismissKeyboard();
  }

  onDontHaveAccountClick() {
    Get.toNamed(Routes.signUpScreen);
  }

  onClickLoginBtn() {
    dismissKeyboard();
    validate();
  }

  void validate({bool onChangeEmail = false, bool onChangePwd = false}) {
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();
    emailErrorMsg = ErrorMessages.emailIsEmpty.tr;
    pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
    if (onChangeEmail) {
      if (email.isNotEmpty) {
        if (isEmailValid(email)) {
          isEmailError.value = false;
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
        }
        isEmailError.refresh();
      } else {
        isEmailError.value = true;
        isEmailError.refresh();
      }
    } else if (onChangePwd) {
      if (pwd.isNotEmpty) {
        isPwdError.value = false;
      } else {
        isPwdError.value = true;
      }
    } else {
      if (email.isEmpty && pwd.isEmpty) {
        isEmailError.value = true;
        isPwdError.value = true;
      } else if (email.isEmpty) {
        isEmailError.value = true;
      } else {
        if (isEmailValid(email)) {
          if (pwd.isNotEmpty) {
            isEmailError.value = false;
            isPwdError.value = false;
            loginApi();
          } else {
            isEmailError.value = false;
            isPwdError.value = true;
          }
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
        }
      }
    }
  }

  void loginApi() async {
    dismissKeyboard();

    var formData = dio.FormData.fromMap({
      "email": emailController.text.trim(),
      "password": pwdController.text.trim(),
      // Add device tokens if necessary
    });

    isLoading.value = true;

    // API call
    LoginModel? response = await authProvider.loginRequest(body: formData);
    log("response----${response?.data}");

    isLoading.value = false;

    if (response?.data != null) {
      // Success login condition
      Prefs.write(Prefs.token, response?.data?.userToken ?? '');

      // Email verification logic
      if (response?.data?.email != null) {
        Prefs.write(Prefs.userId, response?.data?.id ?? '');
        Get.offAllNamed(Routes.homeScreen);
      } else {
        var errorMsg = response?.message ?? 'Email not verified';
        apiErrorDialog(message: errorMsg);
      }
    } else {
      // Failed login condition
      var errorMsg = response?.message ?? 'Login failed';
      apiErrorDialog(message: errorMsg);
    }
  }


  void onLoginWithGoogleClick() async {
    dismissKeyboard();
    if (!isLoading.value) {
      isLoading.value = true;

    }
  }

  setLoader({bool value = false}) {
    isLoading.value = value;
    isLoading.refresh();
  }

  void onLoginWithApple() async {
    dismissKeyboard();

  }

  onForgotPwdClick() {
    // Get.toNamed(Routes.forgotScreen);
  }

  void socialLoginApi(
      {required String firstName,
      required String lastName,
      required String name,
      required String email,
      required String social_type,
      required String is_social_signup,
      required socialId,
      required String pwd}) async {

  }
}
