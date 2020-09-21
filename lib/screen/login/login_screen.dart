import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/screen/login/login_view_model.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/widget/my_logo.dart';
import 'package:posku/util/widget/my_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginViewModel {
  bool isDebug = false;

  Widget _more(Widget child) {
    return PopupMenuButton<int>(
      onSelected: (int idx) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          Map<String, String> data = {};
          switch (idx) {
            case 1:
              data['username'] = 'admgudang@sbi.com';
              data['password'] = 'Dynamix1';
              forceLogin(data);
              break;
            case 2:
              data['username'] = 'gudang3@sbi.com';
              data['password'] = 'Dynamix1';
              forceLogin(data);
              break;
            case 3:
              data['username'] = 'developersisi2@gmail.com';
              data['password'] = '12345678';
              forceLogin(data);
              break;
            default:
              data['username'] = 'jabar@sbi.com';
              data['password'] = 'Dynamix1';
              forceLogin(data);
              break;
          }
        });
      },
      child: child,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          child: const Text('Super Admin'),
          value: 0,
        ),
        PopupMenuItem<int>(
          child: const Text('Admin Gudang'),
          value: 1,
        ),
        PopupMenuItem<int>(
          child: const Text('Kasir'),
          value: 2,
        ),
        PopupMenuItem<int>(
          child: const Text('Devsisi2'),
          value: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget logoForcaPoS = Container(
      height: Get.height * 0.25,
      child: Center(
        child: Hero(
          tag: 'logoForcaPoS',
          child: MyLogo.logoForcaPoSColor(),
        ),
      ),
    );

    if (isDebug) {
      logoForcaPoS = _more(logoForcaPoS);
    }

    var formLayout = Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: MyDimen.marginLayout(),
                  child: TextFormField(
                    onSaved: (userName) => currentData.username = userName,
                    initialValue: currentData.username,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: 'Nama Pengguna',
                      labelStyle: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.txtField),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.lineTxtField),
                      ),
                      errorText: 'Maksimal 30 karakter',
                      errorStyle: TextStyle(
                        color: MyColor.txtField,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                MyDivider.spaceDividerLogin(),
                Container(
                  padding: MyDimen.marginLayout(),
                  child: TextFormField(
                    onSaved: (password) => currentData.password = password,
                    initialValue: currentData.password,
                    maxLength: 30,
                    obscureText: !isShow,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (val) {
                      showDialogProgress();
                    },
                    decoration: InputDecoration(
                      contentPadding: MyDimen.paddingTxtField(),
                      labelText: 'Kata Sandi',
                      labelStyle: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.txtField),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.lineTxtField),
                      ),
                      errorText: 'Maksimal 30 karakter',
                      errorStyle: TextStyle(
                        color: MyColor.txtField,
                        fontStyle: FontStyle.italic,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isShow ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: MyDimen.paddingRememberPass(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Checkbox(
                            activeColor: MyColor.lineTxtField,
                            value: isRemember,
                            onChanged: (bool value) {
                              setState(() {
                                isRemember = value;
                              });
                            },
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                isRemember = !isRemember;
                              });
                            },
                            child: new Text(
                              'Ingat Saya',
                              style: new TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      CupertinoButton(
                        child: Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            color: MyColor.mainBlue,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(forgotPasswordScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: MyDimen.marginLayout(),
            width: double.maxFinite,
            child: FlatButton(
              color: MyColor.mainGreen,
              child: Text(
                'MASUK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: showDialogProgress,
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Belum punya akun? '),
                CupertinoButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: MyColor.mainBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: EmptyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: SafeArea(
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        logoForcaPoS,
                        formLayout,
                        Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: MyText.textBlackSmall(
                                    'Ⓒ 2020 PT SISI, All Right Reserved.'),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    assert(() {
      isDebug = true;
      return true;
    }());
    super.initState();
  }
}
