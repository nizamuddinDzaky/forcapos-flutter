import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_style.dart';
import 'package:posku/util/widget/my_text.dart';

class GoodReceiveScreen extends StatefulWidget {
  @override
  _GoodReceiveScreenState createState() => _GoodReceiveScreenState();
}

class _GoodReceiveScreenState extends State<GoodReceiveScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        heroTag: 'logoForcaPoS',
        backgroundColor: MyColor.mainBlue,
        middle: MyText.textWhite('Good Received', fontSize: FontSize.large),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'good receive page',
                style: Styles.productRowItemName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
