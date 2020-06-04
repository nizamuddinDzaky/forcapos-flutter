import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posku/helper/custom_expandable_button.dart';
import 'package:posku/screen/filter/multi_date_range_picker.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_string.dart';
import 'package:provider/provider.dart';

class _FilterState extends ChangeNotifier {
  String currentPage = '';
  final Map<String, String> firstFilter;

  _FilterState({this.firstFilter}) {
    firstInit(this.firstFilter ?? {});
  }

  void firstInit(Map<String, String> first) {
    if (first.containsKey(MyString.KEY_SORT_BY)) {
      indexSort = sortVal.indexOf(first[MyString.KEY_SORT_BY]);
      isAsc = first[MyString.KEY_SORT_TYPE];
    }
    if (first.containsKey(MyString.KEY_START_DATE)) {
      var startDate = DateTime.tryParse(first[MyString.KEY_START_DATE]);
      var endDate = DateTime.tryParse(first[MyString.KEY_END_DATE]);
      if (startDate != null && endDate != null) {
        changeIntervals([
          [
            startDate,
            endDate,
          ],
        ], notify: false);
      }
    }
    callInitFilter(first['page']);
    if (first.containsKey(MyString.KEY_GR_STATUS)) {
      _selectedStatus = (_statusDelivery.where((data) {
            return data[1] == first[MyString.KEY_GR_STATUS];
          })?.first) ??
          ['', ''];
    }
    if (first.containsKey(MyString.KEY_SALE_STATUS)) {
      _selectedStatus = (_statusDelivery.where((data) {
            return data[1] == first[MyString.KEY_SALE_STATUS];
          })?.first) ??
          ['', ''];
    }
  }

  void _initFilterGR() {
    _statusDelivery.addAll([
      ['Dikirim', 'delivering'],
      ['Diterima', 'received'],
    ]);
  }

  void _initFilterSB() {
    _statusDelivery.addAll([
      ['Menunggu', 'pending'],
      ['Dipesan', 'reserved'],
      ['Selesai', 'closed'],
    ]);
  }

  void callInitFilter(String page) {
    currentPage = page;
    _statusDelivery = [];
    switch(page) {
      case 'gr':
        _initFilterGR();
        break;
      case 'sb':
        _initFilterSB();
        break;
      default:
        _initFilterGR();
        _initFilterSB();
        break;
    }
  }

  //status
  List<List<String>> _statusDelivery = [];
  List<String> _selectedStatus = ['', ''];

  List<String> get selectedStatus => _selectedStatus;

  List<List<String>> get statusDelivery => _statusDelivery;

  bool getStatus(int index) => _selectedStatus == _statusDelivery[index];

  void changeStatus(int index) {
    _selectedStatus = _statusDelivery[index];
    notifyListeners();
  }

  //date range
  List<List<DateTime>> intervals = [];
  String differenceDate;
  int hint;

  void changeIntervals(List<List<DateTime>> intervals, {bool notify}) {
    this.intervals = intervals;
    if (intervals.length == 1) {
      differenceDate =
          differenceDateTime(intervals.first[0], intervals.first[1]);
    }
    hint = 0;
    if (notify == true) notifyListeners();
  }

  //sorting
  String isAsc = 'desc';
  int indexSort = 0;
  List<String> sortData = ['Tanggal Transaksi', 'Total Harga', 'Status'];
  List<String> sortVal = ['date', 'amount', 'status_penerimaan'];

  String get labelName => sortData[indexSort % sortData.length];

  String get _labelVal => sortVal[indexSort % sortVal.length];

  void showDataPicker(BuildContext context) {
    final bool showTitleActions = true;
    DataPicker.showDatePicker(
      context,
      showTitleActions: showTitleActions,
      locale: 'id',
      datas: sortData,
      title: 'Urut berdasarkan',
      onChanged: (_) {},
      onConfirm: (data) {
        indexSort = sortData.indexOf(data);
        notifyListeners();
      },
    );
  }

  void updateSortType() {
    isAsc = isAsc == 'asc' ? 'desc' : 'asc';
    notifyListeners();
  }

  String labelType() {
    switch (indexSort) {
      case 1:
        return isAsc == 'desc' ? 'Tertinggi' : 'Terendah';
      case 2:
        return isAsc == 'desc' ? 'Z - A' : 'A - Z';
      default:
        return isAsc == 'desc' ? 'Terbaru' : 'Awal';
    }
  }

  Map<String, String> resultFilter(page) {
    Map<String, String> result = {};
    if (intervals.isNotEmpty && intervals.first.isNotEmpty) {
      var f = DateFormat('yyyy-MM-dd HH:mm:ss');
      result[MyString.KEY_START_DATE] = f.format(intervals.first[0]);
      result[MyString.KEY_END_DATE] = f.format(intervals.first[1]);
    }
    if (_selectedStatus.isNotEmpty && _selectedStatus[1] != '' && page == 'gr') {
      result[MyString.KEY_GR_STATUS] = _selectedStatus[1];
    }
    if (_selectedStatus.isNotEmpty && _selectedStatus[1] != '' && page == 'sb') {
      result[MyString.KEY_SALE_STATUS] = _selectedStatus[1];
    }
    result[MyString.KEY_SORT_BY] = _labelVal;
    result[MyString.KEY_SORT_TYPE] = isAsc;
    print(result);
    return result;
  }

  void onReset() {
    _selectedStatus = ['', ''];
    intervals = [];
    differenceDate = null;
    indexSort = 0;
    isAsc = 'desc';
    hint = null;
    notifyListeners();
  }
}

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
      create: (_) => _FilterState(firstFilter: firstData),
      child: Consumer<_FilterState>(
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
    final state = Provider.of<_FilterState>(context);
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
                        style: Theme.of(context).textTheme.body2,
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
    final state = Provider.of<_FilterState>(context);
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
                        style: Theme.of(context).textTheme.body2,
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
    final state = Provider.of<_FilterState>(context);
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
                        style: Theme.of(context).textTheme.body2,
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
