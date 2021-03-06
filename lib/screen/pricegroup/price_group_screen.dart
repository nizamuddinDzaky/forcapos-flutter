import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/screen/masterdata/master_data_controller.dart';
import 'package:posku/screen/pricegroup/price_group_view_model.dart';
import 'package:posku/util/resource/my_color.dart';

class PriceGroupScreen extends StatefulWidget {
  @override
  _CustomerGroupScreenState createState() => _CustomerGroupScreenState();
}

class _CustomerGroupScreenState extends PriceGroupViewModel {
  @override
  Widget build(BuildContext context) {
    if (MasterDataController.to.isRefresh) {
      MasterDataController.to.refresh(callback: () {
        actionRefresh();
      });
    }
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
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/female_forca.png'),
                                SizedBox(height: 16),
                                Text('Belum ada data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                SizedBox(height: 16),
                                Text('Tarik ke bawah untuk memuat ulang'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                :Container(
                  color: Color(0xffE9E9E9),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    physics: ClampingScrollPhysics(),
//      controller: isFilter? null : _controller,
                    itemBuilder: (c, i) => _listItem(listPriceGroup[i], i),
                    itemCount: listPriceGroup.length,
                  )
                ),
          );
  }

  Widget _listItem(PriceGroup pg, int index) {
    GlobalKey _keyMore = GlobalKey();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      elevation: 0,
      child: InkWell(
        onTap: () {
          dynamic moreState = _keyMore.currentState;
          moreState.showButtonMenu();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                              pg?.name ?? '~',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          PopupMenuButton<int>(
                            key: _keyMore,
                            offset: Offset(0, -24),
                            onSelected: (int idx) {
                              Future.delayed(Duration(milliseconds: 300))
                                  .then((value) async {
                                switch (idx) {
                                  case 0:
                                    Get.toNamed(
                                      pgDetailScreen,
                                      arguments: pg.toJson(),
                                    );
                                    break;
                                  case 2:
                                    Get.toNamed(
                                      addCustomerToPGScreen,
                                      arguments: {
                                        'price_group': pg.toJson(),
                                      },
                                    );
                                    break;
                                  case 1:
                                    Get.toNamed(
                                      addEditPGScreen,
                                      arguments: {
                                        'price_group': pg.toJson(),
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        actionRefresh();
                                      }
                                    });
                                    break;
                                }
                              });
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
                                child: const Text('Ubah Kelompok Harga'),
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
