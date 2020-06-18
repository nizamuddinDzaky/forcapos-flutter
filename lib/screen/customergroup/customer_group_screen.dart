import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/screen/customergroup/customer_group_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';

class CustomerGroupScreen extends StatefulWidget {
  @override
  _CustomerGroupScreenState createState() => _CustomerGroupScreenState();
}

class _CustomerGroupScreenState extends CustomerGroupViewModel {
  @override
  Widget build(BuildContext context) {
    return isFirst
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: listCustomerGroup.length == 0
                ? LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: Center(
                            child: Text('Data Kosong'),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    physics: ClampingScrollPhysics(),
//      controller: isFilter? null : _controller,
                    itemBuilder: (c, i) => _listItem(listCustomerGroup[i], i),
                    itemCount: listCustomerGroup.length,
                  ),
          );
  }

  Widget _listItem(CustomerGroup cg, int index) {
    GlobalKey _keyMore = GlobalKey();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 8,
      child: InkWell(
        onTap: () {
          dynamic moreState = _keyMore.currentState;
          moreState?.showButtonMenu();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: MyColor.blueDio,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text('PoS',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              cg?.name ?? '~',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          if (cg?.id != '1')
                          PopupMenuButton<int>(
                            key: _keyMore,
                            onSelected: (int idx) {
                              print('cek $idx ${cg.name} ${cg.id}');
                              Future.delayed(Duration(milliseconds: 300)).then((value) {
                                if (idx == 2) {
                                  goToAddCustomerToCG(cg);
                                } else if (idx == 1) {
                                  goToEditCustomerGroup(cg);
                                }
                              });
                            },
                            child: Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                //enabled: cg?.id != '1',
                                height: 50,
                                child: const Text('Tambah Pelanggan ke Kel. Pelanggan'),
                                value: 2,
                              ),
                              PopupMenuItem<int>(
                                height: 30,
                                child: const Text('Ubah Rincian Kel. Pelanggan'),
                                value: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        MyNumber.toNumberRpStr(cg?.kreditLimit ?? '0'),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
