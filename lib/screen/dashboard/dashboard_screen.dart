import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/screen/dashboard/report_screen.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_image.dart';
import 'package:posku/util/style/my_decoration.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/widget/my_text.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var heightTop = 0.0;

  _dialogLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Konfirmasi"),
        content: new Text("Keluar akun?"),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              await MyPref.logout();
              Get.back();
              Get.offNamed(loginScreen);
            },
            child: Text("Ya", style: TextStyle(color: MyColor.mainRed),),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: Text("Tidak", style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    heightTop = size.height * 0.24;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
                expandedHeight: heightTop,
                primary: true,
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration:
                        MyDecoration.decorationGradient(top2bottom: true),
                    child: Stack(
                      children: <Widget>[
                        SafeArea(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                MyText.textBlackSmall('PT. Sinergi Informatika',
                                    isBold: true),
                                MyDivider.spaceDividerLogin(custom: 4),
                                MyText.textBlackSmall(
                                    'Jalan Tubanan Barat\nGresik\nJawa Timur'),
                                MyDivider.spaceDividerLogin(custom: 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.all(0),
                  title: Container(
                    height: heightTop,
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Hero(
                              tag: 'logoForcaPoS',
                              child: Image.asset(
                                kAvatar,
                                width: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child:
                        MyText.textWhite('Keluar', fontSize: FontSize.medium),
                      onPressed: _dialogLogout,
                  ),
                ]),
            new SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              primary: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      MyColor.gradient2,
                      Colors.white,
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  )),
                ),
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  margin: EdgeInsets.all(8),
                  child: Card(
                    elevation: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <List<String>>[
                        [kIconSale, 'Penjualan'],
                        [kIconDelivery, 'Pengiriman'],
                        [kIconPurchase, 'Pemesanan'],
                        [kIconMaster, 'Master'],
                      ].map((List<String> data) {
                        return Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  data[0],
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                                Text(data[1]),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ReportScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
