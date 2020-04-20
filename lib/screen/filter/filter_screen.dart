import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/screen/filter/multi_date_range_picker.dart';
import 'package:posku/util/resource/my_color.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Future<bool> _willPopCallback() async {
    //if (newGr != null) Get.back(result: newGr.toJson());
    //return newGr == null ? true : false;
    Get.back();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Balik',
            middle: Text(
              'Filter',
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
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
/*
            child: SingleChildScrollView(
              child: Container(
//              child: _rangeDatePicker2(),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: Text(
                          'Status Pengiriman',
                          style: TextStyle(color: MyColor.txtField),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                    ExpandableTheme(
                      data: const ExpandableThemeData(
                          iconColor: Colors.blue, useInkWell: true),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          //Card1(),
                          //Card2(),
                          //Card3(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
*/
          ),
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  @override
  _Card1State createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  List<List<String>> statusDelivery = [
    ['Menunggu', 'pending'],
    ['Dikonfirmasi', 'confirmed'],
    ['Ditutup', 'closed'],
    ['Dipesan', 'receive'],
    ['Dibatalkan', 'cancel'],
  ];
  final empty = ['', ''];
  var selectedStatus;
  ExpandableController _controller;
  ExpandableController get controller => _controller;
  set controller(ExpandableController controller) {
    if (_controller == null) {
      _controller = controller;
    }
  }

  @override
  Widget build(BuildContext context) {

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
/*
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Status Pengiriman",
                      style: Theme.of(context).textTheme.body2,
                    )),
*/
                header: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Status Pengiriman',
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Text(
                        (selectedStatus ?? empty)[0],
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
                    ...statusDelivery.map((data) {
                      return CustomExpandableButton.custom(
                        shareController: (newController) => controller = newController,
//                        shareController: (newContext) => controller = ExpandableController.of(newContext),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: MyColor.mainRed),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedStatus = data;
                              print('controller ${controller.value}');
                              controller.toggle();
                              print('controller ${controller.value}');
                            });
                          },
                          color: (selectedStatus ?? empty)[1] == data[1]
                              ? MyColor.mainRed
                              : Colors.white,
                          child: Text(
                            data[0],
                            style: TextStyle(
                              color: (selectedStatus ?? empty)[1] == data[1]
                                  ? Colors.white
                                  : MyColor.txtField,
                            ),
                          ),
                        ),
//                      return CustomRadioButton(
//                        selectedStatus: selectedStatus,
//                        data: data,
//                        onSelected: (newData) {
//                          setState(() {
//                            selectedStatus = newData;
//                          });
//                        },
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

class Card2 extends StatefulWidget {
  @override
  _Card2State createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  List<Widget> buildColumn() {
    final List<Widget> list = [];

    for (final interval in intervals) {
      list.add(Text(interval[0].toString() + " - " + interval[1].toString()));
      if (interval != intervals.last)
        list.add(SizedBox(
          height: 8,
        ));
    }

    return list;
  }

  List<List<DateTime>> intervals = [];

  Widget _rangeDatePicker2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          MultiDateRangePicker(
            onlyOne: true,
            initialValue: intervals,
            onChanged: (List<List<DateTime>> intervals) {
              setState(() {
                this.intervals = intervals;
              });
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
                      children: buildColumn(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Rentang Tanggal",
                      style: Theme.of(context).textTheme.body2,
                    )),
//                    collapsed: Text(
//                      'loremIpsum',
//                      softWrap: true,
//                      maxLines: 2,
//                      overflow: TextOverflow.ellipsis,
//                    ),
                expanded: _rangeDatePicker2(),
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
  @override
  Widget build(BuildContext context) {
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
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Urutan",
                      style: Theme.of(context).textTheme.body2,
                    )),
//                    collapsed: Text(
//                      'loremIpsum',
//                      softWrap: true,
//                      maxLines: 2,
//                      overflow: TextOverflow.ellipsis,
//                    ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(5))
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'loremIpsum',
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
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

class CustomExpandableButton extends ExpandableButton {
  final Function shareController;
  final Widget child;

  CustomExpandableButton.custom({this.shareController, this.child}) : super(child: child);

  @override
  Widget build(BuildContext context) {
    shareController(ExpandableController.of(context));
    return super.build(context);
  }
}

/*
class CustomExpandableButton extends StatelessWidget {
  final Widget child;
  final Function shareController;

  CustomExpandableButton({@required this.shareController, @required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    final theme = ExpandableThemeData.withDefaults(null, context);
    shareController(controller);

    if (theme.useInkWell) {
      return InkWell(onTap: controller.toggle, child: child);
    } else {
      return GestureDetector(
        onTap: controller.toggle,
        child: child,
      );
    }
  }
}
*/

/*
class CustomRadioButton extends StatefulWidget {
  final List<String> data;
  final List<String> selectedStatus;
  final Function onSelected;

  CustomRadioButton({this.data, this.selectedStatus, this.onSelected});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  final empty = ['', ''];

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: MyColor.mainRed),
      ),
      onPressed: () {
        if (widget.onSelected != null) widget.onSelected(widget.data);
        setState(() {});
        controller.toggle();
      },
      color: (widget.selectedStatus ?? empty)[1] == widget.data[1]
          ? MyColor.mainRed
          : Colors.white,
      child: Text(
        widget.data[0],
        style: TextStyle(
          color: (widget.selectedStatus ?? empty)[1] == widget.data[1]
              ? Colors.white
              : MyColor.txtField,
        ),
      ),
    );
  }
}
*/
