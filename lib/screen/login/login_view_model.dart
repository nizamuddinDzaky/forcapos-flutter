import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/model/login.dart';
import 'package:posku/screen/login/login_screen.dart';
import 'package:posku/util/my_pref.dart';

abstract class LoginViewModel extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isShow = false;
  var isRemember = false;
  Login currentData = Login();

  @override
  void initState() {
    _getPrefLogin();
    super.initState();
  }

  void _getPrefLogin() {
    isRemember = MyPref.getRemember();
    currentData.username = MyPref.getUsername();
    currentData.password = MyPref.getPassword();
  }

  void _actionLogin() async {
    var status = await ApiClient.methodPost(
        ApiConfig.urlLogin, currentData.toJson(), {}, onBefore: (status) {
      Get.back();
    }, onSuccess: (data) {
      if (data.containsKey('data') && data['data'].containsKey('token')) {
        MyPref.setForcaToken(data['data']['token']);
      }
      Get.offNamed(homeScreen);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
      if (status == ResponseStatus.success)
        MyPref.setRemember(isRemember, currentData);
    });
    status.execute();
  }

  bool _validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _actionSubmit() async {
    if (_validateAndSave()) {
      print("berhasil $currentData");
      _actionLogin();
    } else {
      Get.back();
      print("gagal");
    }
  }

  showDialogProgress() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[CupertinoActivityIndicator()],
            ),
          );
        });
    await _actionSubmit();
  }
}
