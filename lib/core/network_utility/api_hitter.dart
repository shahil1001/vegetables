import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/app_end_points.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/dio_exceptions.dart';
import 'package:flutter_api_call_with_mvc/core/network_utility/network_check.dart';
import 'package:flutter_api_call_with_mvc/core/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiHitter {
  static Dio dio = Dio();
  static CancelToken cancelToken = CancelToken();
  final GlobalKey key = GlobalKey();
  NetworkCheck networkCheck = NetworkCheck();
  Duration timeOutDuration = const Duration(seconds: 50);

  postApii({
    required String endPoint,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool isCancelToken = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headersParm,
    String? pathVariable,
    bool directListResponse = false,
    bool threeDMap = false,
  }) async {
    try {
      String url='';
      if(threeDMap){
        url   = "${EndPoints.baseUrl}$endPoint";
      }else{
        url   = "${EndPoints.baseUrl}$endPoint";
      }
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      print("URL $endPoint >> $url");
      print("POST $endPoint >> $body");
      print("POST $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        String token = await Prefs.read(Prefs.token) ?? "";
        log("token>>>>>>> $token");

        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        if (token != 'null' && token.isNotEmpty) {
          headers['authorization'] = "Token $token";
        }
        log("headers>> $headers");
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        log("headers>> headers:$headers url:$url body:$body queryParameters: $queryParameters  cancelToken$cancelToken options$options");
        var response = await dio.post(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        ).timeout(timeOutDuration);
        if (kDebugMode) {
          print('getting response is ${response.data}');
        }
        return response;
      } else {
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      print('inside catch error $e');

      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  putApi(
      {required String endPoint,
        Object? body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters,
        String? pathVariable}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      log("URL $endPoint >> $url");
      log("PUT $endPoint >> $body");
      if (await networkCheck.hasNetwork()) {
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': "Token $token",
        };
        log("headers : $headers");
        log("token : $token");
        Options options = Options(headers: headers);

        var response = await dio
            .put(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        )
            .timeout(timeOutDuration);
        (response.data as Map<String, dynamic>)
            .addAll({'status': response.statusCode ?? 1000});
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  patchApi(
      {required String endPoint,
        Object? body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        bool isCancelToken = false,
        Map<String, dynamic>? queryParameters,
        String? pathVariable}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      log("URL $endPoint >> $url");
      log("Patch $endPoint >> $body");
      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': "Token $token",
        };
        log("headers : $headers");
        log("token : $token");
        Options options = Options(headers: headers);

        var response = await dio
            .patch(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        )
            .timeout(timeOutDuration);
        (response.data as Map<String, dynamic>)
            .addAll({'status': response.statusCode ?? 1000});
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  getApii({
    required String endPoint,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool isCancelToken = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headersParm,
    String? pathVariable,
    bool directListResponse = false
  }) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      log("URL $endPoint >> $url");
      log("GET >>>>>> $endPoint >> $queryParameters");

      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        String token = await Prefs.read(Prefs.token) ?? "";
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': "Token $token",
        };
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        Response response = await dio.get(
          url,
          options: options,
          data: body,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        ).timeout(timeOutDuration);

        // Log raw response for debugging
        log("Response status: ${response.statusCode}");
        log("Response headers: ${response.headers}");
        log("Response data: ${response.data}");

        if (directListResponse) {
          List<dynamic>? temp = response.data as List<dynamic>?;
          var responseSecond = {
            "data": temp ?? [],
            "status": response.statusCode ?? 1000,
          };
          log('get response is direct $responseSecond');
          return responseSecond;
        } else {
          (response.data as Map<String, dynamic>)
              .addAll({'status': response.statusCode ?? 1000});
          log('get response is ${response.data}');

          return response;
        }
      } else {
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error occurred: ${e.message}");
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        log("Unknown error occurred: $e");
        throw Exception("Error $e");
      }
    }
  }


  multiPart(
      {required String endPoint,
        Object? body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        bool isCancelToken = false,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headersParm,
        bool showErrorDialog = true}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      log("URL $endPoint >> $url");
      log("MultiPart $endPoint >> $body");
      log("MultiPart $endPoint >> $queryParameters");

      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        Map<String, String> headers = {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        };
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        var response = await dio
            .post(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        )
            .timeout(timeOutDuration);
        print("response.statusCode -> ${response.data}");

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.data);
         // log("response.data -> ${data.toString()}");

          if (data.containsKey('success') && data['success'] == true) {
            log('------ inise 200 succ true');
            return response;
          } else if (showErrorDialog) {
            log('------ inise 200 succe else if');

            var msg = '';
            if (data.containsKey('success') &&
                data['success'] == false &&
                data.containsKey('text')) {
              msg = data['text'];
            }
            apiErrorDialog(message: msg);
            return response;
          } else {
            log('------ inise 200 succ else');

            return response;
          }
        }else {
          return response;
        }
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }

    }
  }

  deleteApi(
      {required String endPoint,
        Object? body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headersParm,
        String? pathVariable}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      log("URL $endPoint >> $url");
      log("Delete $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': "Token $token",
        };
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        log("headers : $headers");
        Response response = await dio
            .delete(
          url,
          options: options,
          data: body,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        )
            .timeout(timeOutDuration);
        if (response.data is Map<String, dynamic>) {
          (response.data as Map<String, dynamic>)
              .addAll({'status': response.statusCode ?? 1000});
          return response;
        } else if (response.data == null || response.data is String?) {
          var tempResponse = {};
          tempResponse = {'status': response.statusCode ?? 1000};
          return tempResponse;
        } else if (response.data == null || response.data?.isBlank == true) {
          var tempResponse = {};
          tempResponse = {'status': response.statusCode ?? 1000};
          return tempResponse;
        } else {
          return response;
        }
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  getGoogleAddressApi(
      {required String endPoint,
        Object? body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headersParm}) async {
    try {
      String url = endPoint;

      if (await networkCheck.hasNetwork()) {
        Response response = await dio
            .get(
          url,
        )
            .timeout(timeOutDuration);
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }
  searchPostApi({
    required String endPoint,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool isCancelToken = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headersParm,
    String? pathVariable,
    bool directListResponse = false,
  }) async {
    try {
      String url = "$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      print("URL $endPoint >> $url");
      print("POST $endPoint >> $body");
      print("POST $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        String token = await Prefs.read(Prefs.token) ?? "";
        log("token>>>>>>> $token");

        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        if (token != 'null' && token.isNotEmpty) {
          headers['authorization'] = "Token $token";
        }
        log("headers>> $headers");
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        log("headers>> headers:$headers url:$url body:$body queryParameters: $queryParameters  cancelToken$cancelToken options$options");
        var response = await dio.post(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        ).timeout(timeOutDuration);
        if (kDebugMode) {
          print('getting response is ${response.data}');
        }
        return response;
      } else {
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      print('inside catch error $e');

      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  searchGetApi({
    required String endPoint,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool isCancelToken = false,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headersParm,
    String? pathVariable,
    bool directListResponse = false,
  }) async {
    try {
      String url = "$endPoint";
      if (pathVariable != null && pathVariable.isNotEmpty) {
        url += pathVariable;
      }
      print("URL $endPoint >> $url");
      print("POST $endPoint >> $body");
      print("POST $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        if (isCancelToken) {
          cancelToken.cancel();
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
        }
        String token = await Prefs.read(Prefs.token) ?? "";
        log("token>>>>>>> $token");

        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        if (token != 'null' && token.isNotEmpty) {
          headers['authorization'] = "Token $token";
        }
        log("headers>> $headers");
        headers.addAll(headersParm ?? {});
        Options options = Options(headers: headers);
        log("headers>> headers:$headers url:$url body:$body queryParameters: $queryParameters  cancelToken$cancelToken options$options");
        var response = await dio.get(
          url,
          options: options,
          data: body,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        ).timeout(timeOutDuration);
        if (kDebugMode) {
          print('getting response is ${response.data}');
        }
        return response;
      } else {
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      print('inside catch error $e');

      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error $e");
      }
    }
  }

  Future<bool> cancelRequests() async {
    cancelToken.cancel();
    return cancelToken.isCancelled;
  }
}
