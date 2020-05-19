import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/screen/pricegroup/price_group_view_model.dart';
import 'package:posku/util/resource/my_color.dart';

class PriceGroupScreen extends StatefulWidget {
  @override
  _CustomerGroupScreenState createState() => _CustomerGroupScreenState();
}

class _CustomerGroupScreenState extends PriceGroupViewModel {
  @override
  Widget build(BuildContext context) {
    return isFirst
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: listPriceGroup.length == 0
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
                    itemBuilder: (c, i) => _listItem(listPriceGroup[i], i),
                    itemCount: listPriceGroup.length,
                  ),
          );
  }

  Widget _listItem(PriceGroup pg, int index) {
    GlobalKey _keyMore = GlobalKey();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 8,
      child: InkWell(
        onTap: () {
          dynamic moreState = _keyMore.currentState;
          moreState.showButtonMenu();
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
                            .title
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            pg?.name ?? '~',
                            style: Theme.of(context).textTheme.title,
                          ),
                          PopupMenuButton<int>(
                            key: _keyMore,
                            onSelected: (int idx) {
                              switch (idx) {
                                case 0:
                                  Get.toNamed(
                                    pgDetailScreen,
                                    arguments: pg.toJson(),
                                  );
                                  break;
                              }
                            },
                            child: Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                height: 30,
                                child: const Text(
                                    'Tambah Pelanggan ke Kel. Harga'),
                                value: 2,
                              ),
                              PopupMenuItem<int>(
                                height: 30,
                                child: const Text('Ubah Rincian Kel. Harga'),
                                value: 1,
                              ),
                              PopupMenuItem<int>(
                                height: 30,
                                child: const Text('Lihat Rincian'),
                                value: 0,
                              ),
                            ],
                          ),
                        ],
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
