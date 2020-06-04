import 'package:posku/model/DataResponse.dart';

class BaseResponse {
  String status;
  int code;
  String message;
  String requestTime;
  String responseTime;
  int rows;
  DataResponse data;

  BaseResponse(
      {this.status,
        this.code,
        this.message,
        this.requestTime,
        this.responseTime,
        this.rows,
        this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    requestTime = json['request_time'];
    responseTime = json['response_time'];
    rows = json['rows'];
    data = json['data'] != null ? new DataResponse.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    data['request_time'] = this.requestTime;
    data['response_time'] = this.responseTime;
    data['rows'] = this.rows;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

abstract class Copyable<T> {
  T copy();
  T copyWith();
}