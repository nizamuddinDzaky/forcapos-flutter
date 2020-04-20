import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
//      localizationsDelegates: [
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
//      ],
      supportedLocales: [
        const Locale('en', 'US'), // American English
//        const Locale('in', 'ID'),
      ],
//      locale: Locale('in', 'ID'),
      navigatorObservers: [
        GetObserver(MiddleWare.observer),
      ],
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
