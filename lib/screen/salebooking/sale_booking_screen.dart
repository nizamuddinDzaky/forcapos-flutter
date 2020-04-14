import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_style.dart';
import 'package:posku/util/widget/my_text.dart';

class SalesBookingScreen extends StatefulWidget {
  @override
  _SalesBookingScreenState createState() => _SalesBookingScreenState();
}

class _SalesBookingScreenState extends State<SalesBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        heroTag: 'logoForcaPoS',
        backgroundColor: MyColor.mainBlue,
        middle: MyText.textWhite('Sale Booking', fontSize: FontSize.large),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'sale booking page',
                style: Styles.productRowItemName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
