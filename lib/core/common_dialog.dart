import 'package:flutter/material.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/custom_icon_button.dart';
import 'package:flutter_api_call_with_mvc/core/common_functionality/dismiss_keyboard.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/gradient_txt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'text/app_text_widget.dart';
import 'theme/app_color_palette.dart';

Future<void> showCommonAlertSingleButtonDialog(
    {String? title,
      String? subHeader,
      String? buttonTitle,
      bool? barrierDismissible,
      void Function()? okPressed}) async {
  dismissKeyboard();
  print(
      'inside show common alert single button dialog false get is dialog open ${Get.isDialogOpen == null} and Get.ISDloagOpen${Get.isDialogOpen}');
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(

      // barrierColor: lightColorPalette.black.withOpacity(0.9),
        barrierDismissible: barrierDismissible ?? false,
        PopScope(
          canPop: barrierDismissible ?? false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
                  backgroundColor: lightColorPalette.whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: lightColorPalette.whiteColor,
                    ),
                    padding: EdgeInsets.only(
                        top: (title?.isNotEmpty ?? false) == true ? 20.h : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        title?.isNotEmpty == true
                            ? AppTextWidget(
                          textAlign: TextAlign.center,
                          style: CustomTextTheme.bigTitleStyle(
                              height: 1,
                              textSize: 15.sp,
                              fontWeight: FontWeight.w600),
                          text: title ?? '',
                        )
                            : const SizedBox(),
                        subHeader != null
                            ? AppTextWidget(
                          textAlign: TextAlign.center,
                          style: CustomTextTheme.normalTextStyle(
                              height: 1.3.h),
                          text: subHeader,
                        ).paddingOnly(
                            left: 16.w,
                            right: 16.w,
                            bottom: 16.w,
                            top: title?.isNotEmpty == true ? 5.w : 16.w)
                            : SizedBox(),
                        Container(
                          width: double.infinity,
                          height: 0.6.w,
                          color: lightColorPalette.grey,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CommonInkwell(
                                  onTap: okPressed ?? () => Get.back(),
                                  child: GradientTextTwo(
                                    textAlign: TextAlign.center,
                                    buttonTitle ?? AppStrings.ok.tr,
                                    style: CustomTextTheme.bigTitleStyle(
                                        textSize: 15.sp),
                                    gradientType: GradientType.linear,
                                    radius: 2.5,
                                    gradientDirection: GradientDirection.ltr,
                                    colors: lightColorPalette
                                        .reverseCommonGradientColor,
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ).paddingSymmetric(
                                      horizontal: 16.w, vertical: 9.w),
                                ))
                          ],
                        ).paddingSymmetric(vertical: 5.h)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}



showCommonAlertWithTwoActionsDialog(
    {required String title,
      required String subHeader,
      String? leftButtonTitle,
      String? rightButtonTitle,
      bool? barrierDismissible,
      bool showOnlySingleButton = false,
      final VoidCallback? noPressed,
      required Function() yesPressed}) async {
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
        barrierColor: lightColorPalette.black.withOpacity(0.3),
        barrierDismissible: barrierDismissible ?? false,
        Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          backgroundColor: lightColorPalette.transparentColor,
          shadowColor: lightColorPalette.transparentColor,
          surfaceTintColor: lightColorPalette.transparentColor,
          elevation: 0,
          child: PopScope(
              canPop: barrierDismissible ?? false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
                      backgroundColor: lightColorPalette.whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: lightColorPalette.whiteColor,
                        ),
                        padding: EdgeInsets.only(
                            top:
                            (title.isNotEmpty ?? false) == true ? 20.h : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            title.isNotEmpty
                                ? AppTextWidget(
                              textAlign: TextAlign.center,
                              style: CustomTextTheme.bigTitleStyle(
                                  height: 1,
                                  textSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                              text: title,
                            ).paddingOnly(
                                bottom: 10.h, left: 16.w, right: 16.w)
                                : const SizedBox(),
                            AppTextWidget(
                              textAlign: TextAlign.center,
                              style: CustomTextTheme.normalTextStyle(),
                              text: subHeader,
                            ).paddingOnly(
                                bottom: 15.h, left: 16.w, right: 16.w),
                            Container(
                              width: double.infinity,
                              height: 0.6.w,
                              color: lightColorPalette.grey,
                            ),
                            IntrinsicHeight(
                                child: Row(
                                  children: [
                                    showOnlySingleButton
                                        ? const SizedBox()
                                        : Expanded(
                                        child: CommonInkwell(
                                          onTap: noPressed ?? () => Get.back(),
                                          child: GradientTextTwo(
                                            textAlign: TextAlign.center,
                                            leftButtonTitle ??
                                                AppStrings.cancel.tr,
                                            style: CustomTextTheme.bigTitleStyle(
                                                textSize: 15.sp),
                                            gradientType: GradientType.linear,
                                            radius: 2.5,
                                            gradientDirection:
                                            GradientDirection.rtl,
                                            colors: lightColorPalette
                                                .reverseCommonGradientColor,
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ).paddingSymmetric(
                                              horizontal: 16.w, vertical: 14.w),
                                        )),
                                    Container(
                                      width: 0.6.w,
                                      height: double.infinity,
                                      color: lightColorPalette.grey,
                                    ),
                                    Expanded(
                                        child: CommonInkwell(
                                          onTap: yesPressed,
                                          child: GradientTextTwo(
                                            textAlign: TextAlign.center,
                                            rightButtonTitle ?? AppStrings.ok.tr,
                                            style: CustomTextTheme.bigTitleStyle(
                                                textSize: 15.sp),
                                            gradientType: GradientType.linear,
                                            radius: 2.5,
                                            gradientDirection: GradientDirection.rtl,
                                            colors: lightColorPalette
                                                .reverseCommonGradientColor,
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ).paddingSymmetric(
                                              horizontal: 16.w, vertical: 14.w),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG, // Duration of the toast
      gravity: ToastGravity.BOTTOM,    // Position of the toast
      timeInSecForIosWeb: 1,           // Duration in seconds for iOS and web
      backgroundColor: Colors.black,   // Background color of the toast
      textColor: Colors.white,          // Text color of the toast
      fontSize: 16.0                    // Font size of the toast text
  );
}