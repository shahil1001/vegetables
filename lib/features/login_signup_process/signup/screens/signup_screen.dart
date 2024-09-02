import 'package:flutter_api_call_with_mvc/core/common_loader/common_loader.dart';
import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/controller/signup_controller.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/extenstion/signup_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: lightColorPalette.whiteColor,
          appBar: appBar(),
          body: GestureDetector(
            onTap: () => controller.onScreenClick(),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: lightColorPalette.whiteColor),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      signUpTitle(),
                      signUpDecTxt(),
                      fistNameTxtField(),
                      lastNameTxtField(),
                      emailTxtField(),
                      pwdTxtField(),
                      confirmPwdTxtField(),
                      signUpBtn(),
                      signUpGoogle(),
                      signUpApple(),
                      notHaveAccountText(),
                      bottomSpace()
                    ],
                  ),
                )),
          ),
        ),
        Obx(() => CommonLoader(isLoading: controller.isLoading.value)),

      ],
    );
  }
}
