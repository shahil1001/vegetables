import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_api_call_with_mvc/core/common_button/custom_icon_button.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/text/app_text_widget.dart';
import 'package:flutter_api_call_with_mvc/core/theme/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NetworkCheck {
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  noInternetConnectionDialog() {
    Get.dialog(
        barrierColor: lightColorPalette.black.withOpacity(0.9),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: WillPopScope(
              onWillPop: () async => true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                    decoration: decorationWithElevationOnly(),
                    child: Column(
                      children: [
                        Icon(Icons.wifi_off_rounded,size: 80,),
                        AppTextWidget(
                          textAlign: TextAlign.center,
                          text: AppStrings.connectionLost.tr,
                          style: CustomTextTheme.headingTextStyle(
                              color: lightColorPalette.black),
                        ),
                        SizedBox(height: 10.h),
                        AppTextWidget(
                          textAlign: TextAlign.center,
                          text: AppStrings.connectionLostMSG.tr,
                          style: CustomTextTheme.normalTextStyle(
                              color: lightColorPalette.grey),
                        ),
                        CustomTapState(
                          padding: EdgeInsets.only(top: 20.h),
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: AppTextWidget(
                                  textAlign: TextAlign.center,
                                  style: CustomTextTheme.bigTitleStyle(
                                    textSize:15.sp ,
                                      color: lightColorPalette.black),
                                  text: AppStrings.ok.tr,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: true);
  }

  Future<bool> hasNetwork() async {
    try {
      List<InternetAddress> result = await InternetAddress.lookup('google.com');
      log("Internet connection Status : $result");

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      log("Internet connection Error: $e");
      return false;
    }
  }
}
