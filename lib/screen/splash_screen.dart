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
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('isLogin');
//    bool isVerified = prefs.getBool('isVerified');
//    print("token $token $isVerified ${token?.isEmpty} ${token?.isNotEmpty}");
    Future.delayed(Duration(seconds: MyDimen.timerSplash), () {
      Get.offNamed(loginScreen);
//      Navigator.of(context).pushReplacement(
////          MaterialPageRoute(builder: (context) => !isVerified ? LoginScreen() : MainScreen()));
////          MaterialPageRoute(builder: (context) => isVerified ? MainScreen() : (token?.isNotEmpty == true ? VerificationScreen() : LoginScreen())));
//          MaterialPageRoute(builder: (context) => isVerified == true ? MainScreen() : LoginScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    MyPref.init();
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
              child: MyLogo.logoForcaPoS(large: true),
            ),
          ],
        ),
      ),
    );
  }
}
