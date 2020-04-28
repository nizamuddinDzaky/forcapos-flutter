import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/middle_ware.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/resource/my_color.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POSku',
      theme: ThemeData(
          primaryColor: MyColor.mainBlue, accentColor: MyColor.mainRed),
      navigatorKey: Get.key,
      initialRoute: "/",
      supportedLocales: [
        const Locale('en', 'US'), // American English
        const Locale('in', 'ID'),
      ],
      localizationsDelegates: [
        CustomMaterialLocalizations(),
        CustomCupertinoLocalizations(),
      ],
      locale: Locale('in', 'ID'),
      navigatorObservers: [
        GetObserver(MiddleWare.observer),
      ],
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}

class CustomMaterialLocalizations extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async => DefaultMaterialLocalizations();

  @override
  bool shouldReload(_) => false;
}

class CustomCupertinoLocalizations extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async => DefaultCupertinoLocalizations();

  @override
  bool shouldReload(_) => false;
}
