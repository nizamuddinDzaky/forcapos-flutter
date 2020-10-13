import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:posku/helper/custom_expandable_button.dart';
import 'package:posku/screen/filter/filter_state.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/my_util.dart';
import 'package:provider/provider.dart';

class CardPayment extends StatelessWidget {
  ExpandableController _controller;

  ExpandableController get controller => _controller;

  set controller(ExpandableController controller) {
    if (_controller == null) {
      _controller = controller;
    }
  }

  String title = 'Status Pembayaran';

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
                        title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        state.selectedPayment[0],
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
                    // ...state.statusPayment.mapIndexed((data, idx) {
                    //   return Text('tes');
                    // }).toList(),
                    ...state.statusPayment.mapIndexed((data, index) {
                      return CustomExpandableButton.custom(
                        shareController: (newController) =>
                            controller = newController,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: MyColor.mainRed),
                          ),
                          onPressed: () {
                            state.changeStatusPayment(index);
                            controller.toggle();
//                            setState(() {
//                            });
                          },
                          color: state.getStatusPayment(index)
                              ? MyColor.mainRed
                              : Colors.white,
                          child: Text(
                            data[0],
                            style: TextStyle(
                              color: state.getStatusPayment(index)
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
