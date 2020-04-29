import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/screen/salebooking/sb_detail_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class SBDetailScreen extends StatefulWidget {
  @override
  _SBDetailScreenState createState() => _SBDetailScreenState();
}

class _SBDetailScreenState extends SBDetailViewModel {
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
                        Center(child: CupertinoActivityIndicator()),
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

  Widget sectionDO({String noDo}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          Icon(Icons.book),
          SizedBox(
            width: 8,
          ),
          Text(
            'Produk',
            style:
                TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
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
            style: TextStyle(
                color: color ?? MyColor.txtField, fontWeight: FontWeight.bold),
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
          sectionTotalDetail(
            'Diskon Pesanan (Rp)',
            sb.totalDiscount,
            color: MyColor.mainGreen,
          ),
          sectionTotalDetail(
            'Jumlah (Rp)',
            sb.total,
          ),
          sectionTotalDetail(
            'Dibayar (Rp)',
            sb.paid,
          ),
          sectionTotalDetail(
            'Jumlah Akhir (Rp)',
            sb.grandTotal,
          ),
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
          Icon(Icons.insert_drive_file),
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
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${sb.referenceNo}',
                            style: TextStyle(
                                color: MyColor.txtBlack,
                                fontWeight: FontWeight.bold),
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
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${strToDateTimeFormat(sb.createdAt)}',
                            style: TextStyle(
                                color: MyColor.txtField,
                                fontWeight: FontWeight.bold),
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
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${statusStyle[0]}',
                            style: TextStyle(
                                color: statusStyle[1],
                                fontWeight: FontWeight.bold),
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
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Text(
                            '${deliveryStyle[0]}',
                            style: TextStyle(
                                color: deliveryStyle[1],
                                fontWeight: FontWeight.bold),
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

  Widget listProductItem(SalesBookingItem sbi) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sbi.productName ?? '',
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
                      if (MyNumber.strUSToDouble(sbi.discount) > 0)
                        Text(
                          MyNumber.toNumberRpStr(sbi.discount) ?? '',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.mainRed,
                          ),
                        ),
                      if (MyNumber.strUSToDouble(sbi.discount) > 0)
                        SizedBox(
                          width: 8,
                        ),
                      Text(
                        MyNumber.toNumberRpStr(sbi.unitPrice) ?? '',
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
                MyNumber.toNumberIdStr(sbi.quantity) ?? '',
                style: TextStyle(
                  fontSize: 20,
                  color: MyColor.txtField,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sbi.productUnitCode ?? '',
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
                          FutureBuilder(
                            future: getDetailCustomer(sb?.customerId),
                            builder: (context, snapshot) {
                              if (sbItems == null ||
                                  snapshot.connectionState !=
                                      ConnectionState.done) {
                                return tileInfo('Dipesan Oleh', data: null);
                              }

                              var address = [
                                customer?.region,
                                customer?.state,
                                customer?.country
                              ];
                              address.removeWhere((s) => s == null);
                              return tileInfo('Dipesan Oleh', data: {
                                0: 'Dipesan Oleh',
                                1: customer?.name ?? '',
                                2: customer?.address ?? '',
                                3: address.join(' - ')
                              });
                            },
                          ),
                          MyDivider.lineDivider(),
                          FutureBuilder(
                            future: getDetailSupplier(sb?.companyId),
                            builder: (context, snapshot) {
                              if (sbItems == null ||
                                  snapshot.connectionState !=
                                      ConnectionState.done) {
                                return tileInfo('Distributor', data: null);
                              }

                              return tileInfo('Distributor', data: {
                                0: 'Distributor',
                                1: supplier?.name ?? '',
                                2: supplier?.address ?? '',
                                3: supplier?.state ?? ''
                              });
                            },
                          ),
                          MyDivider.lineDivider(),
                          FutureBuilder(
                            future: getDetailWarehouse(sb?.warehouseId),
                            builder: (context, snapshot) {
                              if (sbItems == null ||
                                  snapshot.connectionState !=
                                      ConnectionState.done) {
                                return tileInfo('Gudang', data: null);
                              }

                              return tileInfo('Gudang', data: {
                                0: 'Gudang',
                                1: warehouse?.name ?? '',
                                2: warehouse?.address ?? '',
                              });
                            },
                          ),
                          MyDivider.spaceDividerLogin(),
                          sectionDetail(),
                          MyDivider.spaceDividerLogin(),
                          sectionDO(noDo: sb.saleStatus),
                          MyDivider.lineDivider(),
                          FutureBuilder(
                            future: getSalesBookingItem(sb.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: Center(
                                      child: CupertinoActivityIndicator()),
                                );
                              }
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: sbItems.length,
                                itemBuilder: (context, index) {
                                  return listProductItem(sbItems[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return MyDivider.lineDivider();
                                },
                              );
                            },
                          ),
                          MyDivider.lineDivider(),
                          sectionTotal(),
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
