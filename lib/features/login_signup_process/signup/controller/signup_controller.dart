import 'dart:developer';
import 'dart:io';


import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';

import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/dio_exceptions.dart';
import 'package:flutter_api_call_with_mvc/core/auth_provider/auth_provider.dart'
as provider;
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';

import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/core/utils/ui_utils.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/model/sign_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class SignUpController extends GetxController {
  provider.AuthProvider authProvider = provider.AuthProvider();

  var fistNameController = TextEditingController();
  var fistNameFocusNode = FocusNode().obs;
  String fistNameErrorMsg = '';
  RxBool isFistNameError = false.obs;

  var lastNameController = TextEditingController();
  var lastNameFocusNode = FocusNode().obs;
  String lastNameErrorMsg = '';
  RxBool isLastNameError = false.obs;

  var emailController = TextEditingController();
  var emailFocusNode = FocusNode().obs;
  String emailErrorMsg = '';
  RxBool isEmailError = false.obs;

  var pwdController = TextEditingController();
  var pwdFocusNode = FocusNode().obs;
  String pwdErrorMsg = '';
  RxBool isPwdError = false.obs;
  RxBool showPwd = false.obs;

  var confirmPwdController = TextEditingController();
  var confirmPwdFocusNode = FocusNode().obs;
  String confirmPwdErrorMsg = '';
  RxBool isConfirmPwdError = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fistNameFocusNode.value.addListener(() {
      fistNameFocusNode.refresh();
    });
    lastNameFocusNode.value.addListener(() {
      lastNameFocusNode.refresh();
    });
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
    pwdFocusNode.value.addListener(() {
      pwdFocusNode.refresh();
    });
    confirmPwdFocusNode.value.addListener(() {
      confirmPwdFocusNode.refresh();
    });

    super.onInit();
  }

  @override
  void onClose() {
    disposeInitialization();
    super.onClose();
  }

  disposeInitialization() {
    fistNameFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
    confirmPwdFocusNode.value.removeListener(() {});
    pwdFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    emailFocusNode.value.dispose();
    pwdFocusNode.value.dispose();
    fistNameFocusNode.value.dispose();
    lastNameFocusNode.value.dispose();
    confirmPwdFocusNode.value.dispose();

    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    fistNameController.dispose();
    lastNameController.dispose();
    disableFocus();
  }

  void disableFocus() {
    emailErrorMsg = '';
    pwdErrorMsg = '';
    fistNameErrorMsg = '';
    lastNameErrorMsg = '';
    confirmPwdErrorMsg = '';
    showPwd.value = false;
    // showConfirmPwd.value = false;
    isEmailError.value = false;
    isPwdError.value = false;

    isConfirmPwdError.value = false;
    isFistNameError.value = false;
    isLastNameError.value = false;
  }

  onScreenClick() {
    dismissKeyboard();
  }

  onClickSignUp() {
    dismissKeyboard();
    validate();
  }

  void validate(
      {bool onChangeFirstName = false,
      bool onChangeLastName = false,
      bool onChangeEmail = false,
      bool onChangePwd = false,
      bool onChangeConPwd = false}) {
    String firstName = fistNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();
    String confirmPwd = confirmPwdController.text.trim();

    fistNameErrorMsg = ErrorMessages.firstNameIsEmpty.tr;
    lastNameErrorMsg = ErrorMessages.lastNameIsEmpty.tr;
    emailErrorMsg = ErrorMessages.emailIsEmpty.tr;
    if (!onChangePwd && !onChangeConPwd) {
      pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
      confirmPwdErrorMsg = ErrorMessages.confirmPwdIsEmpty.tr;
    }

    if (onChangeFirstName) {
      if (firstName.isNotEmpty) {
        isFistNameError.value = false;
      } else {
        isFistNameError.value = true;
      }
    } else if (onChangeLastName) {
      if (lastName.isNotEmpty) {
        isLastNameError.value = false;
      } else {
        isLastNameError.value = true;
      }
    } else if (onChangeEmail) {
      if (email.isNotEmpty) {
        if (isEmailValid(email)) {
          isEmailError.value = false;
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
          isEmailError.refresh();
        }
      } else {
        isEmailError.refresh();
        isEmailError.value = true;
      }
    } else if (onChangePwd) {
      if (pwd.isNotEmpty) {
        if (pwd.length > 7) {
          if (passwordValidate(pwd)) {
            isPwdError.value = false;
          } else {
            pwdErrorMsg = ErrorMessages.invalidPwdError.tr;
            isPwdError.value = true;
            isPwdError.refresh();
          }
        } else {
          pwdErrorMsg = ErrorMessages.pwdLessThanEightError.tr;
          isPwdError.value = true;
          isPwdError.refresh();
        }
      } else {
        pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
        isPwdError.value = true;
        isPwdError.refresh();
      }
    } else if (onChangeConPwd) {
      if (confirmPwd.isNotEmpty) {
        if (confirmPwd == pwd) {
          isConfirmPwdError.value = false;
        } else {
          confirmPwdErrorMsg = ErrorMessages.confirmPwdNotMatchError.tr;
          isConfirmPwdError.value = true;
          isConfirmPwdError.refresh();
        }
      } else {
        confirmPwdErrorMsg = ErrorMessages.confirmPwdIsEmpty.tr;
        isConfirmPwdError.value = true;
        isConfirmPwdError.refresh();
      }
    } else {
      if (firstName.isEmpty &&
          lastName.isEmpty &&
          email.isEmpty &&
          pwd.isEmpty &&
          confirmPwd.isEmpty) {
        isFistNameError.value = true;
        isLastNameError.value = true;
        isEmailError.value = true;
        isPwdError.value = true;
        isConfirmPwdError.value = true;
      } else if (firstName.isEmpty) {
        isFistNameError.value = true;
      } else if (lastName.isEmpty) {
        isLastNameError.value = true;
      } else if (email.isEmpty) {
        isEmailError.value = true;
      } else {
        if (isEmailValid(email)) {
          if (pwd.isNotEmpty) {
            if (pwd.length > 7) {
              if (passwordValidate(pwd)) {
                if (confirmPwd.isNotEmpty) {
                  if (confirmPwd == pwd) {
                    isFistNameError.value = false;
                    isLastNameError.value = false;
                    isEmailError.value = false;
                    isPwdError.value = false;
                    isConfirmPwdError.value = false;
                    socialLoginApi(
                        firstName: firstName,
                        lastName: '${lastName}',
                        name: '${firstName} ${lastName}',
                        email: email,
                        pwd: pwd,
                        socialId: "",
                        is_social_signup: '',
                        social_type: '');
                  } else {
                    confirmPwdErrorMsg =
                        ErrorMessages.confirmPwdNotMatchError.tr;
                    isConfirmPwdError.value = true;
                  }
                } else {
                  confirmPwdErrorMsg = ErrorMessages.confirmPwdIsEmpty.tr;
                  isConfirmPwdError.value = true;
                }
              } else {
                pwdErrorMsg = ErrorMessages.invalidPwdError.tr;
                isPwdError.value = true;
              }
            } else {
              pwdErrorMsg = ErrorMessages.pwdLessThanEightError.tr;
              isPwdError.value = true;
            }
          } else {
            isEmailError.value = false;
            isPwdError.value = true;
            pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
          }
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
        }
      }
    }
  }
  void onLoginWithGoogleClick() async {
    dismissKeyboard();

  }

  setLoader({bool value = false}){
    isLoading.value = value;
    isLoading.refresh();
  }

  void onLoginWithApple() async {
    dismissKeyboard();


  }

  void socialLoginApi(
      {required String firstName,
      required String lastName,
      required String name,
      required String email,
      required String social_type,
        required socialId,
        required String is_social_signup,
      required String pwd}) async {
    dismissKeyboard();


    setLoader(value: true);
    var request = {
      "username": "",
      "full_name": '${firstName} ${lastName}',
      "email": email,
      "password": pwd,
      "device_type": isIos ? '1' : '0',
      "social_type": social_type,
      "is_social_signup": is_social_signup,
      "city_id": '',
      "state_id": '',
      "country_code": '',
      "mobile_number": '',
    };

    if(social_type == "apple"){
      request["apple_user_id"] = socialId;
    }

    print("signup request : ${request}");

    var formData = dio.FormData.fromMap(request);
    String deviceToken = Prefs.read(Prefs.deviceToken);
    if (Platform.isIOS) {
      formData.fields.add(MapEntry(
          'ios_token',await deviceToken));
    } else if(Platform.isAndroid) {
      formData.fields.add(MapEntry(
          'android_token', await deviceToken));
    }
    print(
        'userName->""\nfull_name->${firstName}${lastName}\nemail->${email}\npassword->${pwd}\device_type->${name}\nsocial_type->${social_type}\nis_social_signup->${is_social_signup}\n');
    SignUpModel? response = await authProvider.signUpRequest(body: formData);
    setLoader(value: false);
    print('response email ${response?.data?.emailVerified}');
    if (response?.success == true) {
      Prefs.write(Prefs.token, response?.data?.token ?? '');
      if (response?.data?.emailVerified is String &&
          response?.data?.emailVerified == '1') {
        Prefs.write(Prefs.userId, response?.data?.loginId ?? 0);
        Get.offAllNamed(Routes.homeScreen);
      } else if (response?.data?.emailVerified is int &&
          response?.data?.emailVerified == 1) {
        Prefs.write(Prefs.userId, response?.data?.loginId ?? 0);
        Get.offAllNamed(Routes.homeScreen);
      } else {
      /*  Get.toNamed(Routes.otpVerificationScreen, parameters: {
          'mail': emailController.text.trim(),
          'fromSignUp': 'true',
          'loginId': response?.data?.loginId ?? ''
        });*/
      }
    }else{
      apiErrorDialog(message: response?.text??'');
    }
  }
}
