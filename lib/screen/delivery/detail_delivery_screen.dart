import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/delivery/detail_delivery_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class DetailDeliveryScreen extends StatefulWidget {
  @override
  _DetailDeliveryScreenState createState() => _DetailDeliveryScreenState();
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
                    style: TextStyle(
                      color: MyColor.txtBlack,
                      fontWeight: FontWeight.bold,
                    ),
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
                                    color: MyColor.txtField,
                                  ),
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
    var deliveryStyle = saleDeliveryStatus(delivery.status);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                sectionDetailItem(data: {
                  0: 'Tanggal',
                  1: strToDateTimeFormat(delivery.date),
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
                  1: strToDateTimeFormat(delivery.createdAt),
                  2: null
                }),
                sectionDetailItem(
                    data: {0: 'Pengiriman', 1: delivery.saleId, 2: null}),
                MyDivider.lineDivider(top: 8),
                tileInfo('Alamat', data: {
                  1: delivery.address,
                  2: delivery.emailCustomer,
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
                        .subtitle2
                        .copyWith(color: Colors.black)),
              ],
            ),
          ),
          MyDivider.lineDivider(),
          if (deliveryItems == null)
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(child: CupertinoActivityIndicator()),
            ),
          if (deliveryItems != null)
            ...deliveryItems.map((data) {
              return Container(
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(
                        child: Text('PPC',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data.productName ?? '',
                              style:
                                  Theme.of(context).textTheme.headline6.copyWith()),
                          Text(data.productCode ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: MyColor.txtField)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              '${MyNumber.toNumberIdStr(data.quantitySent)} ${data.productUnitCode}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: MyColor.txtField)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          if (deliveryItems != null) MyDivider.lineDivider(),
          if (deliveryItems != null)
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
                              .subtitle2
                              .copyWith(color: MyColor.mainRed)),
                      RichText(
                        textAlign: TextAlign.left,
                        softWrap: true,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: MyNumber.toNumberId(deliveryItems
                                  .map((data) {
                                    return MyNumber.strUSToDouble(
                                        data.badQuantity);
                                  })
                                  .toList()
                                  .fold<double>(
                                      0,
                                      (previous, current) =>
                                          previous + current)),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: MyColor.txtField)),
                          TextSpan(
                              text:
                                  ' ' + deliveryItems.first?.productUnitCode ??
                                      '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: MyColor.txtField)),
                        ]),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Baik',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: MyColor.mainGreen)),
                      RichText(
                        textAlign: TextAlign.left,
                        softWrap: true,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: MyNumber.toNumberId(deliveryItems
                                  .map((data) {
                                return MyNumber.strUSToDouble(
                                    data.goodQuantity);
                              })
                                  .toList()
                                  .fold<double>(
                                  0,
                                      (previous, current) =>
                                  previous + current)),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: MyColor.txtField)),
                          TextSpan(
                              text:
                              ' ' + deliveryItems.first?.productUnitCode ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: MyColor.txtField)),
                        ]),
                      ),
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
