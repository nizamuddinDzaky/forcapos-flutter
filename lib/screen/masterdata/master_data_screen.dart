import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_style.dart';
import 'package:posku/util/widget/my_text.dart';

class MasterDataScreen extends StatefulWidget {
  @override
  _MasterDataScreenState createState() => _MasterDataScreenState();
}

class _MasterDataScreenState extends State<MasterDataScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        heroTag: 'logoForcaPoS',
        backgroundColor: MyColor.mainBlue,
        middle: MyText.textWhite('Master Data', fontSize: FontSize.large),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'master data page',
                style: Styles.productRowItemName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
