import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/screen/profile/profile_screen.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class ProfileViewModel extends State<ProfileScreen> {
  bool isFirst = true;
  Company company;
  String gender;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionGetProfile() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlProfile,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        if (baseResponse?.data?.company != null && baseResponse?.data?.user != null) {
          company = baseResponse?.data?.company;
          company?.user = baseResponse?.data?.user;
          gender = company?.user?.gender;
          MyPref.setCompany(company);
        }
      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {
        setState(() {});
      },
    );
    setState(() {
      status.execute();
    });
    return null;
  }

  actionPutProfile(Map body) async {
    var params = {
      MyString.KEY_ID_USER: company?.user?.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlProfileUpdate,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pembaruan Akun', 'Berhasil ubah profil');
        Get.back(result: 'updateProfile');
        actionGetProfile();
      },
      onFailed: (title, message) {
        var errorData = BaseResponse.fromJson(jsonDecode(message));
        print('cek error ${errorData.toJson()}');
        CustomDialog.showAlertDialog(context,
            title: title,
            message: 'Kode error: ${errorData?.code}',
            leftAction: CustomDialog.customAction());
      },
      onError: (title, message) {
        CustomDialog.showAlertDialog(context,
            title: title,
            message: message,
            leftAction: CustomDialog.customAction());
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      company = MyPref.getCompany();
      gender = company?.user?.gender;
      isFirst = false;
      actionGetProfile();
    }
  }
}
