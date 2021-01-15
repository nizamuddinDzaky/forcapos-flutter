import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/screen/purchase/purchase_detail_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class PurchaseDetailScreen extends StatefulWidget {
  @override
  _PurchaseDetailState createState() => _PurchaseDetailState();
}

class _PurchaseDetailState extends PurchaseDetailViewModel {

  Widget tileInfo(String title, IconData icon, {Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: MyColor.blueDio,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: MyColor.txtBlack, fontSize: 16),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[2]?.toString()?.trim() ?? '',
                            style: TextStyle(
                                color: MyColor.txtField, fontSize: 16),
                          ),
                          if (data[3] != null)
                            Text(
                              data[3] ?? 'tes',
                              style: TextStyle(
                                  color: MyColor.txtField, fontSize: 16),
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

  Widget sectionDetail() {
    debugPrint("status purchase : ${purchase.status}");
    var statusStyle = purchaseStatus(purchase.status);
    var deliveryStyle = paymentStatus(purchase.paymentStatus);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.insert_drive_file, color: Colors.blue,),
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
                            style: TextStyle(color: MyColor.txtField,
                                fontSize: 16),
                          ),
                          Text(
                            '${purchase.referenceNo}',
                            style: TextStyle(
                                color: MyColor.txtBlack,
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                            style: TextStyle(color: MyColor.txtField,
                                fontSize: 16),
                          ),
                          Text(
                            '${strToDateTimeFormat(purchase.date)}',
                            style: TextStyle(
                              color: MyColor.txtField,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Status Pembelian',
                            style: TextStyle(color: MyColor.txtField,
                                fontSize: 16),
                          ),
                          Text(
                            '${statusStyle[0]}',
                            style: TextStyle(
                                color: statusStyle[1],
                                fontSize: 16,
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
                            'Status Pembayaran',
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

  Widget widgetDetail() {
    return SingleChildScrollView(
      //padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: getDetailCustomer(purchase?.companyId),
            builder: (context, snapshot) {
              if (purchaseItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
                return tileInfo('Dipesan Oleh',Icons.water_damage, data: null);
              }

              var address = [
                customer?.region,
                customer?.state,
                customer?.country
              ];
              address.removeWhere((s) => s == null);
              return tileInfo('Dipesan Oleh', Icons.water_damage,  data: {
                0: 'Dipesan Oleh',
                1: customer?.name ?? '',
                2: customer?.address ?? '',
                3: address.join(' - ')
              });
            },
          ),
          MyDivider.lineDivider(),
          FutureBuilder(
            future: getDetailSupplier(purchase?.supplierId),
            builder: (context, snapshot) {
              if (purchaseItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
                return tileInfo('Pemasok', Icons.water_damage,  data: null);
              }

              /*var company = MyPref.getCompany();*/
              return tileInfo('Pemasok ',Icons.water_damage, data: {
                0: 'Pemasok',
                1: supplier?.name ?? '',
                2: supplier?.address ?? '',
              });
            },
          ),

          MyDivider.lineDivider(),
          FutureBuilder(
            future: getDetailWarehouse(purchase?.warehouseId),
            builder: (context, snapshot) {
              if (purchaseItems == null ||
                  snapshot.connectionState != ConnectionState.done) {
                return tileInfo('Gudang', Icons.account_balance_rounded,  data: null);
              }

              /*var company = MyPref.getCompany();*/
              return tileInfo('Gudang ',Icons.account_balance_rounded, data: {
                0: 'Pemasok',
                1: warehouse?.name ?? '',
                2: warehouse?.address ?? '',
              });
            },
          ),
          MyDivider.spaceDividerLogin(),
          sectionDetail(),
          MyDivider.spaceDividerLogin(),
          sectionDO(),
          /*MyDivider.spaceDividerLogin(),*/
          /*sectionDO(noDo: purchase.saleStatus),*/
          MyDivider.spaceDividerSmooth(),
          FutureBuilder(
            future: getPurchaseItem(purchase.id),
            builder: (context, snapshot) {
              if (purchaseItems == null ||
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
                itemCount: purchaseItems?.length ?? 0,
                itemBuilder: (context, index) {
                  return listProductItem(purchaseItems[index]);
                },
                separatorBuilder: (context, index) {
                  return MyDivider.lineDivider();
                },
              );
            },
          ),
          MyDivider.lineDivider(),
          sectionTotal(),
          MyDivider.spaceDividerLogin(),
          sectionNote(),
        ],
      ),
    );
  }

  Widget sectionNote() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.note),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Note',
                  style:
                  TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
                ),
                Text(
                  purchase?.note ?? '',
                  style:
                  TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionDO() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.widgets,
            color: Colors.black,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Produk',
            style: TextStyle(
                color: MyColor.txtBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget sectionTotal({String totalItem}) {
    var newGrandTotal = MyNumber.strUSToDouble(purchase.total) -
        MyNumber.strUSToDouble(purchase.paid) +
        MyNumber.strUSToDouble(purchase.shipping) -
        MyNumber.strUSToDouble(purchase.totalDiscount);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: <Widget>[
          sectionTotalDetail(
            'Jumlah (Rp)',
            purchase.total,
          ),
          sectionTotalDetail(
            'Diskon Pesanan (Rp)',
            purchase.totalDiscount,
            color: MyColor.mainGreen,
          ),
          sectionTotalDetail(
            'Dibayar (Rp)',
            purchase.paid,
          ),
          sectionTotalDetail(
            'Biaya Pengiriman (Rp)',
            purchase.shipping,
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
            TextStyle(color: MyColor.txtField,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Text(
            '${MyNumber.toNumberIdStr(value)}',
            style: TextStyle(
                color: color ?? MyColor.txtField,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget listProductItem(PurchaseItems purchaseItem) {
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
                    purchaseItem.productName ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.mainRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Satuan Harga',
                    // textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.txtField,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      if (MyNumber.strUSToDouble(purchaseItem.discount) > 0)
                        Text(
                          MyNumber.toNumberRpStr(purchaseItem.discount) ?? '',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.mainRed,
                          ),
                        ),
                      if (MyNumber.strUSToDouble(purchaseItem.discount) > 0)
                        SizedBox(
                          width: 8,
                        ),
                      Text(
                        MyNumber.toNumberRpStr(purchaseItem.unitCost) ?? '',
                        // textScaleFactor: 1.0,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                MyNumber.toNumberIdStr(purchaseItem.quantity) ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: MyColor.txtField,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 3,),
              Text(
                purchaseItem.productUnitCode ?? '',
                style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColor.txtField,),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget body() {
    switch (sliding) {
      case 1:
        return Text("asd");
      default:
        return widgetDetail();
    }
  }

  Widget _actionButton() {
    var isEdit =
        oldPo?.status != 'returned';
    /*var isClose = (newPo ?? oldPo)?.status == 'returned';*/
    /*var isEnable = isClose || !isEdit;*/
    if (sliding == 0)
      return CupertinoButton(
        minSize: 0,
        padding: EdgeInsets.all(0.0),
        onPressed: isEdit ? () => showOptionMenu(isEdit) : null,
        child: Text('Opsi'),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: CupertinoSlidingSegmentedControl(
          children: {
            0: Container(child: Text('Rincian')),
            1: Container(child: Text('Bayar')),
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