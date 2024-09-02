import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_api_call_with_mvc/core/common_dialog.dart';
import 'package:flutter_api_call_with_mvc/core/constants/app_strings.dart';
import 'package:flutter_api_call_with_mvc/core/routes/app_routes.dart';
import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter_api_call_with_mvc/features/login_signup_process/login/controller/login_controller.dart';
import 'package:get/get.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError({required dio.DioException dioError}) {
    switch (dioError.type) {
      case dio.DioExceptionType.cancel:
        break;
      case dio.DioExceptionType.connectionTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.receiveTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.connectionError:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case dio.DioExceptionType.badResponse:
        dio.Response? response = dioError.response;

        var data = response?.data;

        int statusCode = response?.statusCode is String
            ? int.parse(response?.statusCode as String? ?? '1000')
            : response?.statusCode ?? 0;
        print('Error status code is $statusCode and data ${response?.data}');
        log('response is ${response?.data} and $response');
        var statusMessage =
            response?.statusMessage ?? AppStrings.strSometingWentWrong.tr;

        if (statusCode == 413) {
          apiErrorDialog(
            message: statusMessage,
            okButtonPressed: () {
              Get.back();
            },
          );
        } else if (statusCode == 401) {
          apiErrorDialog(
            message: statusMessage,
            okButtonPressed: () {
              Prefs.erase();
              if (Get.currentRoute != Routes.loginScreen) {
                if (Get.isRegistered<LoginController>()) {
                  var controller = Get.find<LoginController>();
                  Get.until(
                    (route) => route.settings.name == Routes.loginScreen,
                  );
                  controller.cleanFields();
                } else {
                  Get.offAllNamed(Routes.loginScreen);
                }
              } else {
                Get.back();
              }
            },
          );
        } else {
          String? message;
          if (data != null &&
              data is Map &&
              data.containsKey('detail') &&
              data["detail"] is String?) {
            message = data["detail"];
          } else if (data != null &&
              data is Map &&
              data.containsKey('email') &&
              data["email"] is List? &&
              ((data["email"] as List?)?.length ?? 0) >= 1) {
            message = data["email"][0];
          } else if (data != null &&
              data is Map &&
              data.containsKey('name') &&
              data["name"] is List? &&
              ((data["name"] as List?)?.length ?? 0) >= 1) {
            message = data["name"][0];
          } else {
            message = statusMessage;
          }
          // var message = data["error"];
          // var message = data["message"];
          if (statusCode == 401) {
            // logoutFunctionality();
            apiErrorDialog(
              message: message ?? AppStrings.strSometingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          } else {
            print('inside else part $message');
            apiErrorDialog(
              message: message ?? AppStrings.strSometingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          }
        }
        break;

      case dio.DioExceptionType.sendTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.unknown:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      default:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
    }
  }
}

apiErrorDialog(
    {String? title, required String message, Function()? okButtonPressed}) {
  showCommonAlertSingleButtonDialog(
      title: title ?? AppStrings.strError.tr,
      subHeader: message,
      okPressed: () {
        (okButtonPressed != null) ? okButtonPressed() : Get.back();
      },
      buttonTitle: AppStrings.ok.tr);
}
