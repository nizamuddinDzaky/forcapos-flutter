import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

var dio = Dio();

enum ResponseStatus { progress, success, failed, error, done }

typedef APIBeforeCallback = dynamic Function(ResponseStatus status);
typedef APIAfterCallback = dynamic Function(ResponseStatus status);
typedef APISuccessCallback = dynamic Function(Map<String, dynamic> data);
typedef APIErrorCallback = dynamic Function(String title, String message);
typedef APIFailedCallback = dynamic Function(String title, String message);

class ApiClient {
  static addInterceptor() {
    dio.interceptors.add(
        LogInterceptor(request: true, responseBody: true, requestBody: true));
  }

/*
  static addInterceptor() {
//    dio.interceptors.add(LogInterceptor(request: true, responseBody: true, requestBody: true));
//    dio.interceptors.add(LogInterceptor(request: false, requestBody: false, requestHeader: false, responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (options.uri.toString().contains('auth/login') == false) {
        var token = MyPref.getForcaToken();
//        var token = '';
//            options.headers.addAll({MyString.forcaToken: 'MHZDeWprTXJMVkg1d0hwTUtyRUtNL3pENnlOMUkwWCtTL2VxMDdxNXNUbz06Oq6JsfLg3cMucEM64dSy3pc6OoeQ8IgrX7Tsh7sGMw=='});
        options.headers.addAll(
            {MyString.forcaToken: token?.isNotEmpty == true ? token : ''});
      }
      return options;
    }, onResponse: (Response response) async {
      var statusCode = response.statusCode;
      if (statusCode == 401) {
        return null;
      } else if (statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);
        if (response.request.uri.toString().contains('auth/login') == true &&
            jsonResponse.containsKey('data') &&
            jsonResponse['data'].containsKey('token')) {
//          MyPref.setForcaToken(jsonResponse['data']['token']);
        }
      }
      return response;
    }, onError: (DioError e) async {
      var isLogin = e.request.uri.toString().contains('auth/login');
      var statusCode = e.response.statusCode;
      if (statusCode == 401 && !isLogin) {
        MyPref.setForcaToken(null);
//        Get.toNamed(root);
        return null;
      }
      return e;
    }));
  }
*/

  static methodGet(
    String url,
    Map<String, dynamic> params, {
    APISuccessCallback onSuccess,
    APIErrorCallback onError,
    APIFailedCallback onFailed,
  }) {
    dio.get<String>(url, queryParameters: params).then((response) {
      var statusCode = response.statusCode;
      var jsonResponse = jsonDecode(response.data);
      if (onSuccess != null && statusCode == 200) {
        onSuccess(jsonResponse);
      } else if (onFailed != null) {
        onFailed('', response.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) {
        onError('', error.toString());
      }
    });
  }

  static Future<ApiResponse> methodPost(
    String url,
    dynamic body,
    Map<String, dynamic> params, {
    APIBeforeCallback onBefore,
    APISuccessCallback onSuccess,
    APIErrorCallback onError,
    APIFailedCallback onFailed,
    APIAfterCallback onAfter,
    bool customHandle = false,
  }) async {
    var responseApi = ApiResponse(
      ResponseStatus.progress,
      onBefore,
      onSuccess,
      onFailed,
      onError,
      onAfter,
    );
    try {
      await dio
          .post<String>(url,
              data: body,
              queryParameters: params,
              options: Options(contentType: Headers.jsonContentType))
          .then((response) {
        var statusCode = response.statusCode;
        if (onSuccess != null && statusCode == 200) {
          var data = jsonDecode(response.data);
          responseApi._setSuccess(data);
        } else if (onFailed != null) {
          responseApi._setFailed('', response.statusMessage);
        }
      });
    } on DioError catch (error) {
      var title = 'Komunikasi gagal';
      if (error.type == DioErrorType.DEFAULT) {
        responseApi._setError(title, 'Cek koneksi kemudian coba lagi.');
      } else if (customHandle) {
        responseApi._setFailed(
            error.response.statusCode.toString(), error.response.toString());
      } else {
        var statusCode = error.response.statusCode;
        if (statusCode == 405) {
          responseApi._setFailed(title, 'Akses informasi tidak valid.');
        } else if (statusCode == 400) {
          responseApi._setFailed(
              title, 'Periksa Nama Pengguna & Kata Sandi, kemudian ulangi');
        } else {
          print('error gan $error ${error.response}');
        }
      }
    }
    return responseApi;
  }
}

class ApiResponse {
  ResponseStatus responseStatus;
  Map<String, dynamic> dataResponse;
  String title;
  String message;
  APIBeforeCallback onBefore;
  APISuccessCallback onSuccess;
  APIErrorCallback onError;
  APIFailedCallback onFailed;
  APIAfterCallback onAfter;

  ApiResponse(this.responseStatus, this.onBefore, this.onSuccess, this.onFailed,
      this.onError, this.onAfter,
      {this.dataResponse, this.title, this.message});

  _setSuccess(Map<String, dynamic> dataResponse) {
    this.responseStatus = ResponseStatus.success;
    this.dataResponse = dataResponse;
  }

  _setFailed(String title, String message) {
    this.responseStatus = ResponseStatus.failed;
    this.title = title;
    this.message = message;
  }

  _setError(String title, String message) {
    this.responseStatus = ResponseStatus.error;
    this.title = title;
    this.message = message;
  }

  execute() async {
    if (onBefore != null) onBefore(responseStatus);
    if (responseStatus == ResponseStatus.success) {
      if (onSuccess != null) await onSuccess(dataResponse);
    } else if (responseStatus == ResponseStatus.failed) {
      if (onFailed != null) onFailed(title, message);
    } else if (responseStatus == ResponseStatus.error) {
      if (onError != null) onError(title, message);
    }
    if (onAfter != null) onAfter(responseStatus);
  }
}
