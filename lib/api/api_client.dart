import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

var dio = Dio();

typedef APISuccessCallback = dynamic Function(Map<String, dynamic> data);
typedef APIErrorCallback = dynamic Function(String message);
typedef APIFailedCallback = dynamic Function(String message);

class ApiClient {
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
        onFailed(response.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error.toString());
      }
    });
  }

  static Future<ResponseApi> methodPost(
    String url,
    dynamic body,
    Map<String, dynamic> params, {
    APISuccessCallback onSuccess,
    APIErrorCallback onError,
    APIFailedCallback onFailed,
  }) async {
    var responseApi = ResponseApi(
      ResponseStatus.progress,
      onSuccess,
      onFailed,
      onError,
    );
    await dio
        .post<String>(url,
            data: body,
            queryParameters: params,
            options: Options(contentType: Headers.jsonContentType))
        .then((response) {
      var statusCode = response.statusCode;
      var data = jsonDecode(response.data);
      if (onSuccess != null && statusCode == 200) {
        responseApi._setSuccess(data);
      } else if (onFailed != null) {
        responseApi._setFailed(response.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) {
        responseApi._setError(error.toString());
      }
    });
    return responseApi;
  }
}

enum ResponseStatus { progress, success, failed, error }

class ResponseApi {
  ResponseStatus responseStatus;
  Map<String, dynamic> dataResponse;
  String message;
  APISuccessCallback onSuccess;
  APIErrorCallback onError;
  APIFailedCallback onFailed;

  ResponseApi(this.responseStatus, this.onSuccess, this.onFailed, this.onError,
      {this.dataResponse, this.message});

  _setSuccess(Map<String, dynamic> dataResponse) {
    this.responseStatus = ResponseStatus.success;
    this.dataResponse = dataResponse;
  }

  _setFailed(String message) {
    this.responseStatus = ResponseStatus.failed;
    this.message = message;
  }

  _setError(String message) {
    this.responseStatus = ResponseStatus.error;
    this.message = message;
  }

  execute() {
    if (responseStatus == ResponseStatus.success) {
      onSuccess(dataResponse);
    } else if (responseStatus == ResponseStatus.failed) {
      onFailed(message);
    } else if (responseStatus == ResponseStatus.error) {
      onError(message);
    }
  }
}
