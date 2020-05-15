import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/screen/customer/customer_screen.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_style.dart';
import 'package:posku/util/widget/my_text.dart';
import 'package:provider/provider.dart';

class MasterDataScreen extends StatefulWidget {
  @override
  _MasterDataScreenState createState() => _MasterDataScreenState();
}

class _MasterDataScreenState extends State<MasterDataScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int sliding = 0;
  bool isSearch = false;
  List<bool> isFirst = [true, true, true];
  List<String> listSearch;

  void cancelSearch({HomeState homeState, bool notify}) {}

  void onUpdate(String update) {}

  void onSubmit(String submit) {}

  void clearSearch() {
    searchTextController.clear();
  }

  FocusNode initSearch({FocusNode searchFocusNode, HomeState homeState}) {
    if (searchFocusNode.hasListeners == false) {
      searchFocusNode?.addListener(() async {
        if (!animationController.isAnimating) {
          animationController.forward();
        }
      });
    }
    return searchFocusNode;
  }

  FocusNode initFocus({HomeState homeState}) {
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() async {
      isSearch = true;
      homeState.changeSearch(true);
      await Future.delayed(Duration(milliseconds: 100));
      searchFocusNode?.requestFocus();
    });
    return focusNode;
  }

  Future<Null> actionRefresh() async {
    return null;
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    animation = new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
//    searchTextController.add
//    showSearch();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    actionRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeState>(
      builder: (context, homeState, _) {
        if (homeState.isBack) {
          homeState.isBack = false;
          cancelSearch(homeState: homeState, notify: false);
        }

        return CupertinoPageScaffold(
          child: Scaffold(
            appBar: EmptyAppBar(),
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (ctx, innerBoxIsScrolled) {
                  return [
                    CupertinoSliverNavigationBar(
                      transitionBetweenRoutes: false,
                      heroTag: 'logoForcaPoS',
                      middle: CupertinoSlidingSegmentedControl(
                        children: {
                          0: Container(child: Text('Pelanggan')),
                          1: Container(child: Text('K. Pelanggan')),
                          2: Container(child: Text('K. Harga')),
                        },
                        groupValue: sliding,
                        onValueChanged: (newValue) {
                          setState(() {
                            sliding = newValue;
                          });
                        },
                      ),
                      trailing: CupertinoButton(
                        minSize: 16,
                        padding: EdgeInsets.all(0.0),
                        onPressed: () async {},
                        child: Icon(
                          Icons.filter_list,
                          size: 32,
                        ),
                      ),
                      largeTitle: IOSSearchBar(
                        animation: animationController,
                        controller: TextEditingController(),
                        focusNode: initFocus(homeState: homeState),
                      ),
                    ),
                  ];
                },
                body: _body(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    switch (sliding) {
      case 1:
        return CustomerScreen();
      default:
        return CustomerScreen();
    }
  }

  Widget _contentSearch() {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: actionRefresh,
      child: (listSearch == null || listSearch.isEmpty)
          ? LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Center(
                      child: Text(
                        listSearch == null
                            ? 'Mau cari apa nih?'
                            : 'Tidak menemukan hasil',
                      ),
                    ),
                  ),
                );
              },
            )
          : _body(),
    );
  }
}
