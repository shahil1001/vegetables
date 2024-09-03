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
      // Handle cancellation
        break;

      case dio.DioExceptionType.connectionTimeout:
      case dio.DioExceptionType.receiveTimeout:
      case dio.DioExceptionType.connectionError:
      // Handle connection timeout
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case dio.DioExceptionType.badResponse:
        dio.Response? response = dioError.response;
        int statusCode = response?.statusCode ?? 0;
        String statusMessage = response?.statusMessage ?? AppStrings.strSometingWentWrong.tr;

        String? message;

        if (response?.data != null) {
          if (response?.data is Map) {
            // Assuming your API returns the error message in a "message" field
            if (response?.data['message'] != null) {
              message = response?.data['message'];
            } else if (response?.data['error'] != null) {
              message = response?.data['error'];
            } else {
              message = statusMessage;
            }
          } else {
            message = statusMessage;
          }
        } else {
          message = statusMessage;
        }

        if (statusCode == 400) {
          // Handling 400 Bad Request explicitly to show the API's message
          apiErrorDialog(
            message: message ?? AppStrings.strSometingWentWrong.tr,
            okButtonPressed: () {
              Get.back();
            },
          );
        } else if (statusCode == 401) {
          // Handle unauthorized (e.g., logout and redirect to login)
          apiErrorDialog(
            message: message ?? statusMessage,
            okButtonPressed: () {
              Prefs.erase();
              if (Get.currentRoute != Routes.loginScreen) {
                if (Get.isRegistered<LoginController>()) {
                  var controller = Get.find<LoginController>();
                  Get.until((route) => route.settings.name == Routes.loginScreen);
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
          // Handle other status codes
          apiErrorDialog(
            message: message ?? AppStrings.strSometingWentWrong.tr,
            okButtonPressed: () {
              Get.back();
            },
          );
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
