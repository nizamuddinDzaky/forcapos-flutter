import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/util/resource/my_color.dart';

class GoodReceiveScreen extends StatefulWidget {
  @override
  _GoodReceiveScreenState createState() => _GoodReceiveScreenState();
}

class _GoodReceiveScreenState extends State<GoodReceiveScreen>
    with SingleTickerProviderStateMixin {
  int _sliding = 0;
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                transitionBetweenRoutes: false,
                heroTag: 'logoForcaPoS',
                middle: CupertinoSlidingSegmentedControl(
                  children: {
                    0: Container(child: Text('Mengirim')),
                    1: Container(child: Text('Diterima')),
                  },
                  groupValue: _sliding,
                  onValueChanged: (newValue) {
                    setState(() {
                      _sliding = newValue;
                    });
                  },
                ),
                trailing: CupertinoButton(
                  minSize: 16,
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: Icon(
                    Icons.filter_list,
                    size: 32,
                  ),
                ),
                largeTitle: IOSSearchBar(
                  controller: _searchTextController,
                  focusNode: _searchFocusNode,
                  animation: _animation,
                  onCancel: _cancelSearch,
                  onClear: _clearSearch,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return listItem(index);
                    },
                    childCount: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dynamix serbaguna 40 kg',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('200 SAK'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.av_timer, size: 14,),
                    Text(
                      '12 Feb 2020',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('No SO'),
                    Text(
                      'SO/2020/02/0020',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('No DO'),
                    Text(
                      'DO/2020/02/0020',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Lihat Detail',
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: FlatButton(
                  color: MyColor.mainGreen,
                  onPressed: () {},
                  child: Text(
                    'Terima',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
