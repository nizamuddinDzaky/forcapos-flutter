import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/custom_expandable_button.dart';
import 'package:posku/screen/filter/card_payment.dart';
import 'package:posku/screen/filter/card_shipment.dart';
import 'package:posku/screen/filter/filter_state.dart';
import 'package:posku/screen/filter/multi_date_range_picker.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Future<bool> _willPopCallback(Map result) async {
    //if (newGr != null) Get.back(result: newGr.toJson());
    //return newGr == null ? true : false;
//    if (Navigator.of(context).canPop()) Get.back(result: result);
//    return !Navigator.of(context).canPop();
    Get.back(result: result);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> firstData;
    String page = '';
    if (Get.arguments != null) {
      firstData = Get.arguments as Map<String, String>;
      if (firstData.containsKey('page')) page = firstData['page'];
    }
    return ChangeNotifierProvider(
      create: (_) => FilterState(firstFilter: firstData),
      child: Consumer<FilterState>(
        builder: (context, filterState, _) {
          return WillPopScope(
            onWillPop: () => _willPopCallback(filterState.resultFilter(page)),
            child: Material(
              child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  previousPageTitle: 'Balik',
                  middle: Text(
                    'Filter',
                  ),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    onPressed: filterState.onReset,
                    child: Text('Hapus'),
                  ),
                ),
                child: SafeArea(
                  child: ExpandableTheme(
                    data: const ExpandableThemeData(
                        iconColor: Colors.blue, useInkWell: true),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        if (page == 'sb')
                          CardShipment(),
                        if (page == 'sb')
                          CardPayment(),
                        if (page == 'gr')
                          Card1(),
                        Card2(),
                        Card3(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class Card1 extends StatelessWidget {
  ExpandableController _controller;

  ExpandableController get controller => _controller;

  set controller(ExpandableController controller) {
    if (_controller == null) {
      _controller = controller;
    }
  }

  String title(String page) {
    switch(page) {
      case 'sb':
        return 'Status Penjualan';
      case 'gr':
        return 'Status Pembelian';
      default:
        return 'Status';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterState>(context);
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        title(state.currentPage),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        state.selectedStatus[0],
                        style: TextStyle(color: MyColor.mainRed),
                      ),
                    ],
                  ),
                ),
                collapsed: Container(
                  child: Row(
                    children: <Widget>[],
                  ),
                ),
                expanded: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 16 / 4,
                  children: <Widget>[
                    ...state.statusDelivery.mapIndexed((data, index) {
                      return CustomExpandableButton.custom(
                        shareController: (newController) =>
                            controller = newController,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: MyColor.mainRed),
                          ),
                          onPressed: () {
                            state.changeStatus(index);
                            controller.toggle();
//                            setState(() {
//                            });
                          },
                          color: state.getStatus(index)
                              ? MyColor.mainRed
                              : Colors.white,
                          child: Text(
                            data[0],
                            style: TextStyle(
                              color: state.getStatus(index)
                                  ? Colors.white
                                  : MyColor.txtField,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Card2 extends StatelessWidget {
//class Card2 extends StatefulWidget {
//  @override
//  _Card2State createState() => _Card2State();
//}
//
//class _Card2State extends State<Card2> {
  List<Widget> buildColumn(List<List<DateTime>> intervals, hint) {
    final List<Widget> list = [];

    for (final interval in intervals) {
      list.add(Text(dateToDate(interval[0]) + " - " + dateToDate(interval[1])));
      if (interval != intervals.last)
        list.add(SizedBox(
          height: 8,
        ));
    }
    if (list.isEmpty) {
      var status =
          hint == null ? 'Mulai tanggal berapa?' : 'Sampai tanggal berapa?';
      list.add(Text(status));
    }

    return list;
  }

//  List<List<DateTime>> intervals = [];
//  String differenceDate;
//  int hint;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterState>(context);
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rentang tanggal',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        state.differenceDate ?? '',
                        style: TextStyle(color: MyColor.mainRed),
                      ),
                    ],
                  ),
                ),
                collapsed: state.differenceDate == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Center(
                          child: Column(
                            children: buildColumn(state.intervals, state.hint),
                          ),
                        ),
                      ),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      MultiDateRangePicker(
                        onlyOne: true,
                        initialValue: state.intervals,
                        onChanged: (List<List<DateTime>> intervals) {
                          state.changeIntervals(intervals, notify: true);
//                          setState(() {
//                            print('cek1 ${this.intervals} $intervals');
//                            this.intervals = intervals;
//                            print('cek2 ${this.intervals} $intervals');
//                            if (intervals.length == 1) {
//                              differenceDate = differenceDateTime(
//                                  intervals.first[0], intervals.first[1]);
//                            }
//                            hint = 0;
//                          });
                        },
                        selectionColor: Colors.lightBlueAccent,
                        buttonColor: Colors.lightBlueAccent,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 16.0),
                                child: Column(
                                  children:
                                      buildColumn(state.intervals, state.hint),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Card3 extends StatelessWidget {
//class Card3 extends StatefulWidget {
//  @override
//  _Card3State createState() => _Card3State();
//}
//
//class _Card3State extends State<Card3> {
/*
  String isAsc = 'desc';
  int indexSort = 0;
  List<String> sortData = ['Tanggal Transaksi', 'Total Harga', 'Status'];
*/

//  List<List<String>> sortData = [
//    ['Tanggal Transaksi#date', 'date'],
//    ['Total Harga#total', 'grand_total'],
//    ['Status#status', 'status'],
//  ];

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<FilterState>(context);
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Urutan',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${state.labelName}: ',
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${state.labelType()}',
                            style: TextStyle(color: MyColor.mainRed),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                expanded: Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.blue),
                          shape: StadiumBorder(),
                          color: Colors.blue,
                          onPressed: () => state.showDataPicker(context),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Data: ',
                                style: TextStyle(
                                  color: MyColor.txtField,
                                ),
                              ),
                              Flexible(
                                  child: Center(
                                child: Text(
                                  state.labelName,
                                ),
                              )),
                              Icon(
                                Icons.arrow_drop_down,
                                color: MyColor.txtField,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: MyColor.mainRed),
                        ),
                        onPressed: state.updateSortType,
                        color: (state.isAsc ?? '') == 'desc'
                            ? MyColor.mainRed
                            : Colors.white,
                        child: Text(
                          state.labelType(),
                          style: TextStyle(
                            color: (state.isAsc ?? '') == 'desc'
                                ? Colors.white
                                : MyColor.txtField,
                          ),
                        ),
                      ),

/*
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: MyColor.mainRed),
                        ),
                        onPressed: () {
                          setState(() {
//                            isAsc = isAsc == 'asc' ? null : 'asc';
                            isAsc = 'asc';
                          });
                        },
                        color: (isAsc ?? '') == 'asc'
                            ? MyColor.mainRed
                            : Colors.white,
                        child: Text(
                          'Asc',
                          style: TextStyle(
                            color: (isAsc ?? '') == 'asc'
                                ? Colors.white
                                : MyColor.txtField,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: MyColor.mainRed),
                        ),
                        onPressed: () {
                          setState(() {
                            //isAsc = isAsc == 'desc' ? null : 'desc';
                            isAsc = 'desc';
                          });
                        },
                        color: (isAsc ?? '') == 'desc'
                            ? MyColor.mainRed
                            : Colors.white,
                        child: Text(
                          'Desc',
                          style: TextStyle(
                            color: (isAsc ?? '') == 'desc'
                                ? Colors.white
                                : MyColor.txtField,
                          ),
                        ),
                      ),
*/
                    ],
                  ),
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
