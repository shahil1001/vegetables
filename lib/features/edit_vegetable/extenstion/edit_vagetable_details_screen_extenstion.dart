import 'package:flutter_api_call_with_mvc/core/asset_widget/common_image_widget.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/common_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/custom_icon_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_container/border_container.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/gradient_txt.dart';
import 'package:flutter_api_call_with_mvc/core/image_resources.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/textfields/app_common_text_form_field.dart';
import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter_api_call_with_mvc/core/utils/foundation.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

extension EditVegetableDetailsScreenExtenstion on SignUpScreen {
  AppBar appBar() {
    // return commonAppBarWithLogo(isShowBackButton: true);
    return AppBar();
  }

  Widget signUpTitle() {
    return AppTextWidget(
            text: AppStrings.signUpYrAcc.tr,
            style: CustomTextTheme.bigTitleStyle())
        .paddingOnly(top: 35.h, bottom: 5.h);
  }

  Widget signUpDecTxt() {
    return AppTextWidget(
            text: AppStrings.signUpYrAccDec.tr,
            style: CustomTextTheme.normalTextStyle(
                color: lightColorPalette.txtLiteGrey))
        .paddingOnly(bottom: 30.h);
  }

  Widget fistNameTxtField() {
    return Obx(() => commonTextFieldWidget(
            maxLength: 30,
            title: AppStrings.firstname.tr,
            hint: AppStrings.enterFirstName.tr,
            controller: controller.fistNameController,
            keyboardType: TextInputType.name,
            focusNode: controller.fistNameFocusNode.value,
            nextNode: controller.lastNameFocusNode.value,
            errorMsg: controller.fistNameErrorMsg,
            isError: controller.isFistNameError.value,
            onChanged: (value) => controller.validate(onChangeFirstName: true),
            lastIconPath: ImageResource.userIc)
        .paddingOnly(bottom: 12.h));
  }



  Widget emailTxtField() {
    return Obx(() => commonTextFieldWidget(
            title: AppStrings.mailAddress.tr,
            hint: AppStrings.hintEmail.tr,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode: controller.emailFocusNode.value,
            nextNode: controller.pwdFocusNode.value,
            errorMsg: controller.emailErrorMsg,
            isError: controller.isEmailError.value,
            onChanged: (value) => controller.validate(onChangeEmail: true),
            lastIconPath: ImageResource.mailIc)
        .paddingOnly(bottom: 12.h));
  }

  Widget pwdTxtField() {
    return Obx(() => commonTextFieldWidget(
          disableSpace: true,
          title: AppStrings.pwd.tr,
          hint: AppStrings.hintPwd.tr,
          controller: controller.pwdController,
          keyboardType: TextInputType.text,
          focusNode: controller.pwdFocusNode.value,
          nextNode: controller.confirmPwdFocusNode.value,
          passwordVisible: controller.showPwd.value,
          lastIconPath: ImageResource.lockIc,
          errorMsg: controller.pwdErrorMsg,
          isError: controller.isPwdError.value,
          onChanged: (value) => controller.validate(onChangePwd: true),
        ).paddingOnly(bottom: 12.h));
  }

  Widget confirmPwdTxtField() {
    return Column(
      children: [
        Obx(() => commonTextFieldWidget(
              disableSpace: true,
              title: AppStrings.confirmPassword.tr,
              hint: AppStrings.confirmYourPassword.tr,
              controller: controller.confirmPwdController,
              keyboardType: TextInputType.text,
              focusNode: controller.confirmPwdFocusNode.value,
              passwordVisible: controller.showPwd.value,
              lastIconPath: ImageResource.lockIc,
              errorMsg: controller.confirmPwdErrorMsg,
              isError: controller.isConfirmPwdError.value,
              onChanged: (value) => controller.validate(onChangeConPwd: true),
            )),

        Row(
          children: [
            CustomTapState(
              onTap: () =>
              controller.showPwd.value = !controller.showPwd.value,
              child: Obx(() => AssetWidget(
                asset: Asset(
                    type: AssetType.svg,
                    path: !controller.showPwd.value
                        ? ImageResource.unCheckBox
                        : ImageResource.checkBox),
                boxFit: BoxFit.fill,
                width: 20.w,
                height: 20.w,
              )).paddingOnly(right: 5.w,top: 18.h, bottom: 5.h,left: 2.5.w),
            ),
            AppTextWidget(
                text: AppStrings.showPwd.tr,
                style: CustomTextTheme.headingTextStyle(textSize: 13.sp)).paddingOnly(top: 13.h)
          ],
        ),
      ],
    ).paddingOnly(bottom: 32.h);
  }

  Widget signUpBtn() {
    return CommonButton(
      txt: AppStrings.signup.tr,
      showArrow: true,
      onPress: () => controller.onClickSignUp(),
    ).paddingOnly(bottom: 22.h);
  }

/*  Widget signUpGoogle() {
    return CustomTapState(
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
              text: AppStrings.signUpWithGoogle.tr,
              style: CustomTextTheme.headingTextStyle(),
            )
          ],
        ),
      ).paddingOnly(bottom: isIos?8.h:0),
    );
  }

  Widget signUpApple() {
    return isIos?CustomTapState(
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
              text: AppStrings.signUpWithApple.tr,
              style: CustomTextTheme.headingTextStyle(),
            )
          ],
        ),
      ).paddingOnly(bottom: 18.h),
    ):const SizedBox().paddingOnly(bottom: 18.h);
  }*/

  Widget notHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextWidget(
          text: AppStrings.alreadyHaveAcc.tr,
          style: CustomTextTheme.headingTextStyle(
              textSize: 15.sp, color: lightColorPalette.black),
        ),
        CustomTapState(
          onTap: () => Get.back(),
          child: GradientTextTwo(
            AppStrings.login.tr,
            style: CustomTextTheme.bigTitleStyle(textSize: 15.sp),
            gradientType: GradientType.linear,
            radius: 2.5,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            gradientDirection: GradientDirection.ttb,
            colors: lightColorPalette.commonGradientColor,
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
