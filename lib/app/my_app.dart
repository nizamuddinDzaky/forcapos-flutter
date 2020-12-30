import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:posku/app/middle_ware.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/main.dart';
import 'package:posku/util/resource/my_color.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POSku',
      theme: ThemeData(
        primaryColor: MyColor.mainBlue,
        accentColor: MyColor.mainRed,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      navigatorKey: Get.key,
      initialRoute: "/",
      supportedLocales: [
        const Locale('en', 'US'), // American English
        const Locale('in', 'ID'),
      ],
      localizationsDelegates: [
        CustomMaterialLocalizations(),
        CustomCupertinoLocalizations(),
        CustomWidgetsLocalizations(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('in', 'ID'),
      navigatorObservers: [
        GetObserver(MiddleWare.observer),
      ],
      onGenerateRoute: MyRouter.generateRoute,
    );

    if (isProd == false || kDebugMode) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'QP',
          location: BannerLocation.bottomEnd,
          child: materialApp,
        ),
      );
    }

    return materialApp;
  }
}

class CustomMaterialLocalizations
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();

  @override
  bool shouldReload(_) => false;
}

class CustomCupertinoLocalizations
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async =>
      DefaultCupertinoLocalizations();

  @override
  bool shouldReload(_) => false;
}

class CustomWidgetsLocalizations
    extends LocalizationsDelegate<WidgetsLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) async =>
      DefaultWidgetsLocalizations();

  @override
  bool shouldReload(_) => false;
}
