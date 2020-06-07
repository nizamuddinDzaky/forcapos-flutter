import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/screen/salebooking/sb_detail_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_pref.dart';
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
    var newGrandTotal = MyNumber.strUSToDouble(sb.total) -
        MyNumber.strUSToDouble(sb.paid) -
        MyNumber.strUSToDouble(sb.totalDiscount);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: <Widget>[
          sectionTotalDetail(
            'Jumlah (Rp)',
            sb.total,
          ),
          sectionTotalDetail(
            'Diskon Pesanan (Rp)',
            sb.totalDiscount,
            color: MyColor.mainGreen,
          ),
          sectionTotalDetail(
            'Dibayar (Rp)',
            sb.paid,
          ),
          sectionTotalDetail(
            'Jumlah Akhir (Rp)',
            newGrandTotal.toString(),
            color: MyColor.mainBlue,
          ),
        ],
      ),
    );
  }

  Widget sectionDetail() {
    var statusStyle = saleStatus(sb.saleStatus);
//    var deliveryStyle = saleDeliveryStatus(sb.deliveryStatus);
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
//                          Text(
//                            'Status Pengiriman',
//                            style: TextStyle(color: MyColor.txtField),
//                          ),
//                          Text(
//                            '${deliveryStyle[0]}',
//                            style: TextStyle(
//                                color: deliveryStyle[1],
//                                fontWeight: FontWeight.bold),
//                          ),
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
                      .headline6
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

  void _showPopupMenu(Offset offset, Delivery delivery) async {
    double left = offset.dx;
    double top = offset.dy;
    var result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<int>(
          height: 30,
          child: const Text('Lihat Rincian'),
          value: 0,
        ),
        PopupMenuItem<int>(
          height: 30,
          child: const Text('Ubah Pengiriman'),
          value: 1,
        ),
        PopupMenuItem<int>(
          enabled: false,
          height: 30,
          child: const Text('Retur Pengiriman'),
          value: 2,
        ),
      ],
      elevation: 8.0,
    );
    if (result == 1) {
      goToEditDelivery(delivery);
    }
  }

  Widget widgetDetail() {
    return SingleChildScrollView(
      //padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: getDetailCustomer(sb?.customerId),
            builder: (context, snapshot) {
              if (sbItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
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
            future: getDetailWarehouse(sb?.warehouseId),
            builder: (context, snapshot) {
              if (sbItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
                return tileInfo('Gudang', data: null);
              }

              var company = MyPref.getCompany();
              return tileInfo('Gudang ${company.company}', data: {
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
              if (sbItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sbItems?.length ?? 0,
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
    );
  }

  Widget widgetPayment() {
    return listPayment?.length == 0
        ? LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return CustomScrollView(slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: true,
                  fillOverscroll: true,
                  child: IntrinsicHeight(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
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
                                Text('Daftar Pembayaran',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Colors.black)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text('Data Kosong'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            },
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                    Text('Daftar Pembayaran',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.black)),
                  ],
                ),
              ),
              FutureBuilder(
                future: getListPayment(sb.id),
                builder: (buildContext, snapshot) {
                  if (listPayment == null ||
                      snapshot.connectionState != ConnectionState.done) {
                    return Expanded(
                        child: Container(
                      color: Colors.white,
                      child: Center(child: CupertinoActivityIndicator()),
                    ));
                  }

                  if ((listPayment?.length ?? 0) == 0) {
                    return Container();
                  }

                  return Expanded(
                    child: ListView.separated(
//            padding: EdgeInsets.symmetric(vertical: 12),
                      shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Row(
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
                                        child: Text('PoS',
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
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'No Referensi',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: MyColor.txtField,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  listPayment[index]
                                                          .referenceNo ??
                                                      '1234567890',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: MyColor.txtField,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Nominal',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: MyColor
                                                                .txtField,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          MyNumber
                                                              .toNumberRpStr(
                                                                  listPayment[
                                                                          index]
                                                                      .amount),
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: MyColor
                                                                .txtField,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Tipe Pembayaran',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: MyColor
                                                                .txtField,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          paidType(
                                                              listPayment[index]
                                                                  .paidBy)[0],
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: MyColor
                                                                .txtField,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: PopupMenuButton<int>(
                                              onSelected: (idx) =>
                                                  goToEditPayment(
                                                idx,
                                                payment: listPayment[index],
                                              ),
                                              child: Icon(Icons.more_vert),
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<int>>[
                                                PopupMenuItem<int>(
                                                  height: 30,
                                                  child: const Text('Ubah'),
                                                  value: 0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: MyColor.txtField,
                              ),
                              InkWell(
                                onTap: listPayment[index]?.attachment == null
                                    ? null
                                    : goToDetailPayment(listPayment[index]),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 16,
                                            color: MyColor.txtField,
                                          ),
                                          Text(
                                            ' ${strToDate(listPayment[index]?.date)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyColor.txtField),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (listPayment[index]?.attachment != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          'Selengkapnya',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.mainBlue),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (buildContext, index) {
                        return MyDivider.lineDivider(
                          bottom: 12,
                          customColor: MyColor.txtField,
                        );
                      },
                      itemCount: listPayment?.length ?? 0,
                    ),
                  );
                },
              ),
            ],
          );
  }

  Widget widgetDelivery() {
    return listDelivery?.length == 0
        ? LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return CustomScrollView(slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: true,
                  fillOverscroll: true,
                  child: IntrinsicHeight(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
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
                                Text('Daftar Pengiriman',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Colors.black)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text('Data Kosong'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            },
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                    Text('Daftar Pengiriman',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.black)),
                  ],
                ),
              ),
              FutureBuilder(
                future: getListDelivery(sb.id),
                builder: (buildContext, snapshot) {
                  if (listDelivery == null ||
                      snapshot.connectionState != ConnectionState.done) {
                    return Expanded(
                        child: Container(
                      color: Colors.white,
                      child: Center(child: CupertinoActivityIndicator()),
                    ));
                  }

                  if (listDelivery?.length == 0) {
                    return Container();
                  }

                  return Expanded(
                    child: ListView.separated(
//            padding: EdgeInsets.symmetric(vertical: 12),
                      shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        var deliveryStyle =
                            saleDeliveryStatus(listDelivery[index].status);
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: 0,
                                    child: GestureDetector(
                                      onTapDown: (TapDownDetails details) {
                                        _showPopupMenu(
                                          details.globalPosition,
                                          listDelivery[index],
                                        );
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 12),
                                        child: Icon(
                                          Icons.more_vert,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Row(
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
                                            child: Text('Deliv',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'No. DO',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            listDelivery[index]
                                                                .doReferenceNo,
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'No. SO',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            listDelivery[index]
                                                                .saleReferenceNo,
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                            ),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'Status',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            deliveryStyle[0],
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  deliveryStyle[
                                                                      1],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'Nama Pengemudi',
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            listDelivery[index]
                                                                .deliveredBy,
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: MyColor
                                                                  .txtField,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                                color: MyColor.txtField,
                              ),
                              InkWell(
                                onTap: () => goToDetailDelivery(listDelivery[index]),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 16,
                                            color: MyColor.txtField,
                                          ),
                                          Text(
                                            ' ${strToDate(listDelivery[index].date)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyColor.txtField),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        'Selengkapnya',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColor.mainBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (buildContext, index) {
                        return MyDivider.lineDivider(
                          bottom: 12,
                        );
                      },
                      itemCount: listDelivery?.length ?? 0,
                    ),
                  );
                },
              ),
            ],
          );
  }

  Widget body() {
    switch (sliding) {
      case 1:
        return widgetPayment();
      case 2:
        return widgetDelivery();
      default:
        return widgetDetail();
    }
  }

  Widget _actionButton() {
    if (sliding == 0) return null;
    if (sliding == 1 && sb.saleStatus == 'pending') return null;
    if (sliding == 1 && sb.paymentStatus == 'paid') return null;
    if (sliding == 2 && sb.saleStatus != 'reserved') return null;
    if (sliding == 2 && sb.deliveryStatus == 'done') return null;

    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.all(0.0),
      onPressed: sliding == 1
          ? () => goToAddPayment()
          : () => goToAddDelivery(),
      child: Icon(
        Icons.add,
        size: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: CupertinoSlidingSegmentedControl(
          children: {
            0: Container(child: Text('Rincian')),
            1: Container(child: Text('Bayar')),
            2: Container(child: Text('Kirim')),
          },
          groupValue: sliding,
          onValueChanged: (newValue) {
            setState(() {
              sliding = newValue;
//              if (isFirst[sliding]) actionRefresh();
            });
          },
        ),
        trailing: _actionButton(),
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
