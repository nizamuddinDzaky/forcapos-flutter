import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/style/my_decoration.dart';
import 'package:posku/util/resource/my_dimen.dart';
import 'package:posku/util/widget/my_logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _changePage() async {
    await MyPref.init();
    var token = MyPref.getForcaToken();
    var isLogin = token != null && token.isNotEmpty;
    print('forcatoken $token');
    Future.delayed(Duration(seconds: MyDimen.timerSplash), () {
      Get.offNamed(isLogin ? homeScreen : loginScreen);
    });
  }

  @override
  void initState() {
    super.initState();
    _changePage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        decoration: MyDecoration.decorationGradient(),
        child: Stack(
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'logoForcaPoS',
                child: MyLogo.logoForcaPoS(large: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
