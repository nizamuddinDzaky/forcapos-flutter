import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/util/my_pref.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiClient.methodGet(ApiConfig.urlProfile, {
      "username": "developersisi2@gmail.com",
      "password": "12345678"
    }, onSuccess: (jsonResponse) {
      print(jsonResponse['data']);
    });
//    );
//    ApiClient.methodPost(
//        ApiConfig.urlLogin,
//        {"username": "developersisi2@gmail.com", "password": "12345678"},
//        {"username": "developersisi2@gmail.com", "password": "12345678"});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      body: SafeArea(
        child: FlatButton(onPressed: () {
          MyPref.setForcaToken(null);
        }, child: Text('Remove Token')),
      ),
    );
  }
}

///
/// {"status":"success","code":200,"message":"You are successfully logged in.","request_time":"2020-04-13 18:29:14","response_time":"2020-04-13 18:29:14","rows":3,"data":{"user_id":"3","company_id":"6","token":"d3VOaXVPc3RDZkR5YXFoK2ZLQlpNWkMwdkdERFBhUlMwVXg2S05rUnNFST06OpMxw+N8WAv1bzFMDIFg//06Orhz5cTixD1/WJlwGg=="}}
///
