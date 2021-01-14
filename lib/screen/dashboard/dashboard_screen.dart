import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/my_screen.dart';
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
            child: Text(
              "Ya",
              style: TextStyle(color: MyColor.mainRed),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Tidak",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screen = MyScreen(MediaQuery.of(context).size);
    var company = MyPref.getCompany();
    var address = [
      company?.user?.address,
      company?.user?.state,
      company?.user?.city,
      company?.user?.country,
    ].where((data) => data != null).join(', ');
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
                expandedHeight: screen.hp(25),
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
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  MyText.textBlackSmall(company?.company ?? '',
                                      isBold: true),
                                  MyDivider.spaceDividerLogin(custom: 4),
                                  MyText.textBlackSmall(address ?? ''),
                                  MyDivider.spaceDividerLogin(custom: 4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.all(0),
                  centerTitle: true,
                  title: Container(
                    height: screen.hp(27),
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Hero(
                              tag: 'logoForcaPoS',
                              child: CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  await Get.toNamed(profileScreen);
                                  setState(() {});
                                },
                                child: Image.asset(
                                  kAvatar,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Container(),
              ),
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
                        [kIconSale, 'Pembelian', listPurchase],
                        [kIconDelivery, 'Pengiriman', null],
                        [kIconPurchase, 'Pemesanan', null],
                        [kIconMaster, 'Master', null],
                      ].map((List<String> data) {
                        return Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if(data[2] != null)
                              Get.toNamed(
                                data[2],
                              );
                              /*if(data[1].toLowerCase() == 'pembelian')
                              debugPrint("asdasd" + data[1]);*/
                            },
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
