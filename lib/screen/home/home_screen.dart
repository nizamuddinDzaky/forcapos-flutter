import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/dashboard/dashboard_screen.dart';
import 'package:posku/screen/goodreceived/good_received_screen.dart';
import 'package:posku/screen/masterdata/master_data_screen.dart';
import 'package:posku/screen/salebooking/sale_booking_screen.dart';
import 'package:posku/util/resource/my_color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: MyColor.mainBlue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Beranda"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Penerimaan"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              title: Text("Penjualan"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text("Data"),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 1:
              return GoodReceiveScreen();
              break;
            case 2:
              return SalesBookingScreen();
              break;
            case 3:
              return MasterDataScreen();
              break;
            default:
              return DashboardScreen();
              break;
          }
        });
  }
}
