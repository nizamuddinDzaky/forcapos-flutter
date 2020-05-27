import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/zone.dart';
import 'package:posku/screen/profile/profile_screen.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class ProfileViewModel extends State<ProfileScreen> {
  bool isFirst = true;
  Company company;
  String gender;
  List<Zone> listProvince, listCity, listState;
  Zone province, city, state;
  DetailZone zone;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  actionGetAddress(String key, {String province, String city}) async {
    if (key == 'province' && listProvince != null) return listProvince;
    if (key == 'city' && listCity != null) return listCity;
    if (key == 'state' && listState != null) return listState;
    var params = {
      if (province != null) 'province': province,
      if (city != null) 'city': city,
    };
    var url = ApiConfig.urlListProvince;
    if (key == 'city') url = ApiConfig.urlListCity;
    if (key == 'state') url = ApiConfig.urlListStates;
    List<Zone> zones;
    var status = await ApiClient.methodGet(
      url,
      params: params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        if (data['data'] != null && data['data'] is List) {
          zones = [];
        }
        if (key == 'province' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toProvince())
              .toList());
          listProvince = zones;
        }
        if (key == 'city' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toCity())
              .toList());
          listCity = zones;
        }
        if (key == 'state' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toState())
              .toList());
          listState = zones;
        }
        return zones;
      },
      onFailed: (title, message) {
        Get.snackbar(title, message);
      },
      onError: (title, message) {
        Get.snackbar(title, message);
      },
      onAfter: (status) {},
    );
    await status.execute();
    return Future.value(zones);
  }

  Future<Null> actionGetProfile() async {
    var status = await ApiClient.methodGet(
      ApiConfig.urlProfile,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        if (baseResponse?.data?.company != null &&
            baseResponse?.data?.user != null) {
          company = baseResponse?.data?.company;
          company?.user = baseResponse?.data?.user;
          MyPref.setCompany(company);
          _updateData();
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

  _updateData() {
    gender = company?.user?.gender;
    province = Zone(provinceName: company?.user?.country);
    city = Zone(kabupatenName: company?.user?.city);
    state = Zone(kecamatanName: company?.user?.state);
    province.toProvince();
    city.toCity();
    state.toState();
    zone = DetailZone(province: province, city: city, state: state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      company = MyPref.getCompany();
      _updateData();
      isFirst = false;
      actionGetProfile();
    }
  }
}
