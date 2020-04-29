import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/salebooking/sb_detail_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_image.dart';
import 'package:posku/util/widget/my_divider.dart';

class SBDetailScreen extends StatefulWidget {
  @override
  _SBDetailScreenState createState() => _SBDetailScreenState();
}

class _SBDetailScreenState extends SBDetailViewModel {
  Widget tileInfo({Map<int, dynamic> data = const {}}) {
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
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[0] ?? '',
                  style: TextStyle(color: MyColor.txtBlack),
                ),
                Text(
                  data[1] ?? '',
                  style: TextStyle(
                      color: MyColor.txtBlack, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[2] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
                Text(
                  data[3] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionDO({String noDo}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.book
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Produk',
            style: TextStyle(
                color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget sectionTotalDetail(String key, String value, {color}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key ?? '',
            style:
            TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
          Text(
            '${MyNumber.toNumberIdStr(value)}',
            style:
            TextStyle(color: color ?? MyColor.txtField, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget sectionTotal({String totalItem}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: <Widget>[
          sectionTotalDetail('Diskon Pesanan (Rp)', '10000', color: MyColor.mainGreen),
          sectionTotalDetail('Jumlah (Rp)', '10000'),
          sectionTotalDetail('Dibayar (Rp)', '10000'),
          sectionTotalDetail('Jumlah Akhir (Rp)', '10000'),
        ],
      ),
    );
  }

  Widget sectionDetail() {
    var statusStyle = saleStatus(sb.paymentStatus);
    var deliveryStyle = deliveryStatus(sb.deliveryStatus);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.insert_drive_file
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Referensi',
                            style:
                            TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${sb.referenceNo}',
                            style:
                            TextStyle(color: MyColor.txtBlack, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Tanggal',
                            style:
                            TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${strToDateTimeFormat(sb.createdAt)}',
                            style:
                            TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Status Penjualan',
                            style:
                            TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${statusStyle[0]}',
                            style:
                            TextStyle(color: statusStyle[1], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Status Pengiriman',
                            style:
                            TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${deliveryStyle[0]}',
                            style:
                            TextStyle(color: deliveryStyle[1], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listProductItem({Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Image.asset(
//            kImageDynamix,
//            width: 75,
//          ),
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data[0] ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.mainRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Satuan Harga',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.txtField,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        data[1] ?? '',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColor.mainRed,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        data[4] ?? '',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColor.txtBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                data[2] ?? '',
                style: TextStyle(
                  fontSize: 20,
                  color: MyColor.txtField,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data[3] ?? '',
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: Text(
          'Rincian Pembelian',
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: Container(
              color: MyColor.mainBg,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: <Widget>[
                          tileInfo(data: {
                            0: 'Dipesan Oleh',
                            1: sb.saleStatus,
                            2: sb.saleStatus,
                            3: sb.saleStatus
                          }),
                          MyDivider.lineDivider(),
                          tileInfo(data: {
                            0: 'Distributor',
                            1: sb.saleStatus,
                            2: sb.saleStatus,
                            3: sb.saleStatus
                          }),
                          MyDivider.lineDivider(),
                          tileInfo(data: {
                            0: 'Gudang',
                            1: sb.saleStatus,
                            2: '${sb.saleStatus} - ${sb.saleStatus}',
                            3: sb.saleStatus,
                          }),
                          MyDivider.spaceDividerLogin(),
                          sectionDetail(),
                          MyDivider.spaceDividerLogin(),
                          sectionDO(noDo: sb.saleStatus),
                          MyDivider.lineDivider(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: sbItems.length,
                            itemBuilder: (context, index) {
                              return listProductItem(data: {
                                0: sbItems[index].productName,
                                1: MyNumber.toNumberRpStr(sbItems[index].realUnitPrice),
                                2: MyNumber.toNumberIdStr(sbItems[index].quantity),
                                3: sbItems[index].productUnitCode,
                                4: MyNumber.toNumberRpStr(sbItems[index].unitPrice),
                              });
                            },
                            separatorBuilder: (context, index) {
                              return MyDivider.lineDivider();
                            },
                          ),
                          MyDivider.lineDivider(),
                          sectionTotal(
                              totalItem: MyNumber.toNumberIdStr(sb.grandTotal)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
