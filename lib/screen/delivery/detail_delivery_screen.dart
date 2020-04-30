import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class DetailDeliveryScreen extends StatefulWidget {
  @override
  _DetailDeliveryScreenState createState() => _DetailDeliveryScreenState();
}

abstract class DetailDeliveryViewModel extends State<DetailDeliveryScreen> {
  bool isFirst = true;
  Delivery delivery;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    setState(() {});
    return null;
  }

  actionCopy(String text) async {
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar('Berhasil disalin', text);
    }
  }
}

class _DetailDeliveryScreenState extends DetailDeliveryViewModel {
  Widget sectionDetailItem({Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data[0] ?? '',
                  style: TextStyle(
                    color: MyColor.txtField,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data[1] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
              ],
            ),
          ),
          if (data[2] != null)
            SizedBox(
              width: 16,
            ),
          if (data[2] != null)
            CupertinoButton(
              minSize: 20,
              padding: EdgeInsets.all(0),
              onPressed: data[2] == null ? null : () => actionCopy(data[1]),
              child: Text(
                'Salin',
                style: TextStyle(
                    fontSize: 14,
                    color: data[2] == null ? Colors.white : MyColor.mainRed,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget tileInfo(String title, {Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: MyColor.mainRed,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: MyColor.txtBlack),
                  ),
                  Stack(
                    children: <Widget>[
                      if (data == null)
                        Positioned.fill(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      (data == null)
                          ? Column(
                        children: <Widget>[
                          Text(''),
                          Text(''),
                          Text(''),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[1] ?? '',
                            style: TextStyle(
                                color: MyColor.txtBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[2]?.toString()?.trim() ?? '',
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          if (data[3] != null)
                            Text(
                              data[3] ?? 'tes',
                              style: TextStyle(color: MyColor.txtField),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    var deliveryStyle = deliveryStatus(delivery.status);
    return SingleChildScrollView(
//      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                sectionDetailItem(data: {
                  0: 'Tanggal',
                  1: strToDateTimeFormat(delivery.createdAt),
                  2: null
                }),
                sectionDetailItem(data: {
                  0: 'No. Penjualan',
                  1: delivery.saleReferenceNo,
                  2: null
                }),
                sectionDetailItem(
                    data: {0: 'Pelanggan', 1: delivery.customer, 2: null}),
                sectionDetailItem(
                    data: {0: 'Status', 1: deliveryStyle[0], 2: null}),
                sectionDetailItem(data: {
                  0: 'Tanggal Pengiriman',
                  1: strToDateTimeFormat(delivery.date),
                  2: null
                }),
                sectionDetailItem(
                    data: {0: 'Pengiriman', 1: delivery.saleId, 2: null}),
                MyDivider.lineDivider(top: 8),
                tileInfo('Alamat', data: {
                  1: delivery.address,
                  2: 'delivery.email',
                  3: 'delivery.phone',
                }),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.insert_drive_file,
                  size: 16,
                  color: MyColor.blueDio,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Produk',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.black)),
              ],
            ),
          ),
          MyDivider.lineDivider(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: MyColor.blueDio,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                        Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text('PPC',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(
                            color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('PPC',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith()),
                      Text('2020',
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: MyColor.txtField)),
                      SizedBox(
                        height: 8,
                      ),
                      Text('200 SAK',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: MyColor.txtField)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyDivider.lineDivider(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Buruk',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: MyColor.mainRed)),
                    Text('100 SAK',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: MyColor.txtField)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Baik',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: MyColor.mainGreen)),
                    Text('200 SAK',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: MyColor.txtField)),
                  ],
                ),
              ],
            ),
          ),
          MyDivider.lineDivider(),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      delivery = Delivery.fromJson(arg ?? {});
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        delivery?.toJson();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: Text(delivery?.doReferenceNo ?? 'Rincian Pengiriman'),
      ),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: Container(
              color: MyColor.mainBg,
              child: body(),
            ),
          ),
        ),
      ),
    );
  }
}
