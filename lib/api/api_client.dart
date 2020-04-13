import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

var dio = Dio();

typedef APISuccessCallback = dynamic Function(Map<String, dynamic> jsonResponse);
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
          MyPref.setForcaToken(jsonResponse['data']['token']);
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

  static methodGet(String url,
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

  static methodPost(String url,
      dynamic body,
      Map<String, dynamic> params, {
        APISuccessCallback onSuccess,
        APIErrorCallback onError,
        APIFailedCallback onFailed,
      }) {
    dio
        .post<String>(url,
        data: body,
        queryParameters: params,
        options: Options(contentType: Headers.jsonContentType))
        .then((response) {
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
}
