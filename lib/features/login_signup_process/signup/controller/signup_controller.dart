import 'dart:developer';
import 'dart:io';

import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
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

  var phoneController = TextEditingController(); // Added phoneController
  var phoneFocusNode = FocusNode().obs; // Added phoneFocusNode
  String phoneErrorMsg = ''; // Added phoneErrorMsg
  RxBool isphoneError = false.obs; // Added isphoneError

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
    phoneFocusNode.value.addListener(() {
      // Added phoneFocusNode listener
      phoneFocusNode.refresh();
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
    emailFocusNode.value.removeListener(() {});
    phoneFocusNode.value
        .removeListener(() {}); // Added phoneFocusNode removeListener
    pwdFocusNode.value.removeListener(() {});
    confirmPwdFocusNode.value.removeListener(() {});

    emailFocusNode.value.dispose();
    phoneFocusNode.value.dispose(); // Dispose phoneFocusNode
    pwdFocusNode.value.dispose();
    fistNameFocusNode.value.dispose();
    lastNameFocusNode.value.dispose();
    confirmPwdFocusNode.value.dispose();

    emailController.dispose();
    phoneController.dispose(); // Dispose phoneController
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
    phoneErrorMsg = ''; // Reset phoneErrorMsg
    confirmPwdErrorMsg = '';
    showPwd.value = false;

    isEmailError.value = false;
    isPwdError.value = false;
    isConfirmPwdError.value = false;
    isFistNameError.value = false;
    isLastNameError.value = false;
    isphoneError.value = false; // Reset isphoneError
  }

  void validate({
    bool onChangeFirstName = false,
    // bool onChangeLastName = false,
    bool onChangeEmail = false,
    bool onChangePhone = false, // Added onChangePhone parameter
    bool onChangePwd = false,
    bool onChangeConPwd = false,
  }) {
    String firstName = fistNameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim(); // Get phone value
    String pwd = pwdController.text.trim();
    String confirmPwd = confirmPwdController.text.trim();

    fistNameErrorMsg = ErrorMessages.firstNameIsEmpty.tr;
    lastNameErrorMsg = ErrorMessages.lastNameIsEmpty.tr;
    emailErrorMsg = ErrorMessages.emailIsEmpty.tr;
    phoneErrorMsg =
        ErrorMessages.phoneIsEmpty.tr; // Default phone error message
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
    }  else if (onChangeEmail) {
      if (email.isNotEmpty) {
        if (isEmailValid(email)) {
          isEmailError.value = false;
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
        }
      } else {
        isEmailError.value = true;
      }
    } else if (onChangePhone) {
      // Validate phone number
      if (phone.isNotEmpty) {
        if (isPhoneValid(phone)) {
          // Assuming isPhoneValid is a validation function
          isphoneError.value = false;
        } else {
          phoneErrorMsg = ErrorMessages.invalidPhoneError.tr;
          isphoneError.value = true;
        }
      } else {
        isphoneError.value = true;
      }
    } else if (onChangePwd) {
      if (pwd.isNotEmpty) {
        if (pwd.length > 7) {
          if (passwordValidate(pwd)) {
            isPwdError.value = false;
          } else {
            pwdErrorMsg = ErrorMessages.invalidPwdError.tr;
            isPwdError.value = true;
          }
        } else {
          pwdErrorMsg = ErrorMessages.pwdLessThanEightError.tr;
          isPwdError.value = true;
        }
      } else {
        pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
        isPwdError.value = true;
      }
    } else if (onChangeConPwd) {
      if (confirmPwd.isNotEmpty) {
        if (confirmPwd == pwd) {
          isConfirmPwdError.value = false;
        } else {
          confirmPwdErrorMsg = ErrorMessages.confirmPwdNotMatchError.tr;
          isConfirmPwdError.value = true;
        }
      } else {
        confirmPwdErrorMsg = ErrorMessages.confirmPwdIsEmpty.tr;
        isConfirmPwdError.value = true;
      }
    } else {
      if (firstName.isEmpty &&
          // lastName.isEmpty &&
          email.isEmpty &&
          phone.isEmpty && // Added phone validation
          pwd.isEmpty &&
          confirmPwd.isEmpty) {
        isFistNameError.value = true;
        isLastNameError.value = true;
        isEmailError.value = true;
        isphoneError.value = true; // Set phone error
        isPwdError.value = true;
        isConfirmPwdError.value = true;
      } else if (firstName.isEmpty) {
        isFistNameError.value = true;
      } else if (email.isEmpty) {
        isEmailError.value = true;
      } else if (phone.isEmpty) {
        // Added phone empty check
        isphoneError.value = true;
      } else {
        if (isEmailValid(email)) {
          if (isPhoneValid(phone)) {
            // Added phone validation check
            if (pwd.isNotEmpty) {
              if (pwd.length > 7) {
                if (passwordValidate(pwd)) {
                  if (confirmPwd.isNotEmpty) {
                    if (confirmPwd == pwd) {
                      isFistNameError.value = false;
                      isLastNameError.value = false;
                      isEmailError.value = false;
                      isphoneError.value = false; // Set phone error to false
                      isPwdError.value = false;
                      isConfirmPwdError.value = false;
                      socialLoginApi(
                        mobile: phone,
                        name: firstName,
                        email: email,
                        pwd: pwd,
                      );
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
              pwdErrorMsg = ErrorMessages.pwdIsEmpty.tr;
              isPwdError.value = true;
            }
          } else {
            phoneErrorMsg = ErrorMessages.invalidPhoneError.tr;
            isphoneError.value = true;
          }
        } else {
          emailErrorMsg = ErrorMessages.invalidEmailError.tr;
          isEmailError.value = true;
        }
      }
    }
  }

  onClickSignUp() {
    dismissKeyboard();
    validate();
  }

  onScreenClick() {
    dismissKeyboard();
  }

  void socialLoginApi({
    required String name,
    required String email,
    required String mobile,
    required String pwd,
  }) async {
    dismissKeyboard();
    isLoading.value = true;

    // Create a request with only the required fields
    var request = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": pwd,
    };

    print("Signup request: $request");

    var formData = dio.FormData.fromMap(request);

    print('Name: $name\nEmail: $email\nMobile: $mobile\nPassword: $pwd');

    SignUpModel? response = await authProvider.signUpRequest(body: formData);
    isLoading.value = false;

    if (response != null && response.data != null) {
      Prefs.write(Prefs.userToken, response.data?.userToken ?? '');

      // Handle success, e.g., navigating to the home screen
      Get.offAllNamed(Routes.homeScreen);
      showToast("Congratulations! Your account is created.");
    } else {
      apiErrorDialog(message: response?.message ?? 'Sign-up failed.');
    }
  }
}
