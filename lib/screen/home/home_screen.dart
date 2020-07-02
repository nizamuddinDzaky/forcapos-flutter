import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/dashboard/dashboard_screen.dart';
import 'package:posku/screen/goodreceived/good_received_screen.dart';
import 'package:posku/screen/masterdata/master_data_screen.dart';
import 'package:posku/screen/salebooking/sales_booking_screen.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_string.dart';
import 'package:provider/provider.dart';

class HomeState extends ChangeNotifier {
  bool isBack = false;
  bool _isSearch = false;
  int _roleId;

  bool get isSearch => _isSearch;

  int get roleId => _roleId;

//  int get roleId => MyString.ROLE_SUPER_ADMIN;
//  int get roleId => MyString.ROLE_WAREHOUSE_ADMIN;
//  int get roleId => MyString.ROLE_CASHIER;

  void changeRole(int newRole, {bool isNotify}) {
    _roleId = newRole;
    if (isNotify == true) notifyListeners();
  }

  void changeSearch(bool isSearch, {Function action}) {
    this._isSearch = isSearch;
    if (action != null) action();
    notifyListeners();
  }

  void popBack() {
    isBack = true;
    _isSearch = false;
    notifyListeners();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _willPopCallback(HomeState homeState) async {
    if (homeState.isSearch == true) {
      homeState.popBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeState()..changeRole(MyPref.getRole()),
      child: Consumer<HomeState>(
        builder: (context, homeState, _) {
          return WillPopScope(
            onWillPop: () => _willPopCallback(homeState),
            child: CupertinoTabScaffold(
                tabBar: homeState.isSearch == true
                    ? InvisibleCupertinoTabBar(roleId: homeState.roleId)
                    : CupertinoTabBar(
                        activeColor: MyColor.mainBlue,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            title: Text("Beranda"),
                          ),
                          if (homeState.roleId != MyString.ROLE_CASHIER)
                            BottomNavigationBarItem(
                              icon: Icon(Icons.shopping_cart),
                              title: Text("Penerimaan"),
                            ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.date_range),
                            title: Text("Penjualan"),
                          ),
                          if (homeState.roleId == MyString.ROLE_SUPER_ADMIN)
                            BottomNavigationBarItem(
                              icon: Icon(Icons.dashboard),
                              title: Text("Data"),
                            ),
                        ],
                      ),
                tabBuilder: (context, index) {
                  CupertinoTabView returnValue;
                  switch (index) {
                    case 1:
                      returnValue = CupertinoTabView(builder: (context) {
                        return CupertinoPageScaffold(
                          child: homeState.roleId != MyString.ROLE_CASHIER
                              ? GoodReceiveScreen()
                              : SalesBookingScreen(),
                        );
                      });
                      break;
                    case 2:
                      returnValue = CupertinoTabView(builder: (context) {
                        return CupertinoPageScaffold(
                          child: SalesBookingScreen(),
                        );
                      });
                      break;
                    case 3:
                      returnValue = CupertinoTabView(builder: (context) {
                        return CupertinoPageScaffold(
                          child: MasterDataScreen(),
                        );
                      });
                      break;
                    default:
                      returnValue = CupertinoTabView(builder: (context) {
                        return CupertinoPageScaffold(
                          child: DashboardScreen(),
                        );
                      });
                      break;
                  }
                  return returnValue;
                }),
          );
        },
      ),
    );
  }
}

class InvisibleCupertinoTabBar extends CupertinoTabBar {
  static const dummyIcon = Icon(IconData(0x0020));

  InvisibleCupertinoTabBar({int roleId = MyString.ROLE_CASHIER})
      : super(
          items: [
            if (roleId != MyString.ROLE_CASHIER)
              BottomNavigationBarItem(icon: dummyIcon),
            if (roleId == MyString.ROLE_SUPER_ADMIN)
              BottomNavigationBarItem(icon: dummyIcon),
            BottomNavigationBarItem(icon: dummyIcon),
            BottomNavigationBarItem(icon: dummyIcon),
          ],
        );

  @override
  Size get preferredSize => const Size.square(0);

  @override
  Widget build(BuildContext context) => SizedBox();

  @override
  CupertinoTabBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    double iconSize,
    Border border,
    int currentIndex,
    onTap,
  }) =>
      InvisibleCupertinoTabBar();
}
