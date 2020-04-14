import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/widget/my_logo.dart';
import 'package:posku/util/widget/my_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isShow = false;
  var isRemember = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light,
    ));

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
                    maxLength: 30,
                    obscureText: !isShow,
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
              onPressed: () {},
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
                        Container(
                          height: Get.height * 0.25,
                          child: Center(
                            child: Hero(
                              tag: 'logoForcaPoS',
                              child: MyLogo.logoForcaPoSColor(),
                            ),
                          ),
                        ),
                        formLayout,
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: MyText.textBlackSmall(
                                'Ⓒ 2020 PT SISI, All Right Reserved.'),
                          ),
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
}
