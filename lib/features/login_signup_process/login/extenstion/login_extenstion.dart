
import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/asset_widget/common_image_widget.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/common_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/custom_icon_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_container/border_container.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/gradient_txt.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/textfields/app_common_text_form_field.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_color_palette.dart';

extension LoginScreenExtenstion on LoginScreen {
  AppBar appBar() {
    // return commonAppBarWithLogo();
    return AppBar();
  }

  Widget loginTitle() {
    return AppTextWidget(
            text: AppStrings.loginYrAcc.tr,
            style: CustomTextTheme.bigTitleStyle())
        .paddingOnly(top: 35.h, bottom: 5.h);
  }

  Widget loginDecTxt() {
    return AppTextWidget(
            text: AppStrings.loginYrAccDec.tr,
            style: CustomTextTheme.normalTextStyle(
                color: lightColorPalette.txtLiteGrey))
        .paddingOnly(bottom: 30.h);
  }

  Widget emailTxtField() {
    return Obx(() => commonTextFieldWidget(
            onChanged: (value) => controller.validate(onChangeEmail: true),
            title: AppStrings.mailAddress.tr,
            hint: AppStrings.hintEmail.tr,
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            focusNode: controller.emailFocusNode.value,
            nextNode: controller.pwdFocusNode.value,
            errorMsg: controller.emailErrorMsg,
            isError: controller.isEmailError.value,
            lastIconPath: ImageResource.mailIc)
        .paddingOnly(bottom: 12.h));
  }

  Widget pwdTxtField() {
    return Obx(() => commonTextFieldWidget(
          onChanged: (value) => controller.validate(onChangePwd: true),
          disableSpace: true,
          title: AppStrings.pwd.tr,
          hint: AppStrings.hintPwd.tr,
          keyboardType: TextInputType.text,
          controller: controller.pwdController,
          focusNode: controller.pwdFocusNode.value,
          passwordVisible: controller.showPwd.value,
          lastIconPath: ImageResource.lockIc,
          errorMsg: controller.pwdErrorMsg,
          isError: controller.isPwdError.value,
        ));
  }

  Widget forgotPwdTxt() {
    // return SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTapState(
          onTap: () => controller.showPwd.value = !controller.showPwd.value,
          child: Obx(
            () => AssetWidget(
              asset: Asset(
                  type: AssetType.svg,
                  path: !controller.showPwd.value
                      ? ImageResource.unCheckBox
                      : ImageResource.checkBox),
              boxFit: BoxFit.fill,
              width: 20.w,
              height: 20.w,
            ).paddingOnly(right: 5.w, top: 18.h, bottom: 5.h),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                  text: AppStrings.showPwd.tr,
                  style: CustomTextTheme.headingTextStyle(textSize: 13.sp)),
              CustomTapState(
                onTap: () => controller.onForgotPwdClick(),
                child: GradientTextTwo(
                  AppStrings.forgotPwd.tr,
                  style: CustomTextTheme.bigTitleStyle(textSize: 15.w),
                  gradientType: GradientType.linear,
                  radius: 2.5,
                  gradientDirection: GradientDirection.ttb,
                  colors: lightColorPalette.commonGradientColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            ],
          ).paddingOnly(top: 13.h),
        )
      ],
    ).paddingOnly(left: 2.5.w, right: 2.5.w, bottom: 25.h);
  }

  Widget loginBtn() {
    return CommonButton(
      txt: AppStrings.login.tr,
      showArrow: true,
      onPress: () => controller.onClickLoginBtn(),
    ).paddingOnly(bottom: 22.h);
  }

  Widget signUpGoogle() {
    return GestureDetector(
      onTap: () => controller.onLoginWithGoogleClick(),
      child: BorderContainer(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AssetWidget(
              asset: Asset(type: AssetType.svg, path: ImageResource.googleIc),
              boxFit: BoxFit.fill,
              width: 22.w,
              height: 22.w,
            ).paddingOnly(right: 10.w),
            AppTextWidget(
              text: AppStrings.loginWithGoogle.tr,
              style: CustomTextTheme.headingTextStyle(),
            )
          ],
        ),
      ).paddingOnly(bottom: 8.h),
    );
  }

  Widget signUpApple() {
    return isIos? GestureDetector(
        onTap: () => controller.onLoginWithApple(),
        child: BorderContainer(
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetWidget(
                asset: Asset(type: AssetType.svg, path: ImageResource.appleIc),
                boxFit: BoxFit.fill,
                width: 22.w,
                height: 22.w,
              ).paddingOnly(right: 10.w),
              AppTextWidget(
                text: AppStrings.loginWithApple.tr,
                style: CustomTextTheme.headingTextStyle(),
              )
            ],
          ),
        ).paddingOnly(bottom: 18.h),
      ): SizedBox();

  }

  Widget notHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextWidget(
          text: AppStrings.dontHaveAcc.tr,
          style: CustomTextTheme.headingTextStyle(
              textSize: 15.sp, color: lightColorPalette.black),
        ),
        CustomTapState(
          onTap: () => controller.onDontHaveAccountClick(),
          child: GradientTextTwo(
            AppStrings.signup.tr,
            style: CustomTextTheme.bigTitleStyle(textSize: 15.sp),
            gradientType: GradientType.linear,
            radius: 2.5,
            gradientDirection: GradientDirection.ttb,
            colors: lightColorPalette.commonGradientColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
      ],
    );
  }

  Widget bottomSpace() {
    return SizedBox(
      width: double.infinity,
      height: isIos ? (35 * 2).h : 50.h,
    );
  }
}
