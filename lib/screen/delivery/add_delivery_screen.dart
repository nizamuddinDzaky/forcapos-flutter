import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/delivery/add_delivery_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddDeliveryScreen extends StatefulWidget {
  @override
  _AddDeliveryScreenState createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends AddDeliveryViewModel {
  Widget _body() {
    List<List<String>> statusDeliveries = [];
    statusDeliveries.addAll([
      ['Sedang Dikemas', 'packing'],
      ['Dalam Pengiriman', 'delivering'],
      ['Sudah Diterima', 'done'],
    ]);
    refNoController.text = sb.referenceNo;
    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Referensi Nomor Penjualan',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: refNoController,
                          decoration: new InputDecoration(
                            isDense: true,
                            hintText: sb?.referenceNo ?? 'SALE/2020/...',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Tanggal',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: <Widget>[
                          CupertinoButton(
                            minSize: 0,
                            onPressed: () async {
                              DateTime newDateTime =
                                  await showRoundedDatePicker(
                                context: context,
                                initialDate: date,
                                locale: Locale('in', 'ID'),
                                borderRadius: 16,
                              );
                              setState(() {
                                date = newDateTime ?? date;
                              });
                            },
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('${strToDate(date.toString())}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MyDivider.lineDivider(
                    customColor: MyColor.txtBlack,
                    left: 24,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 16 / 3,
                    children: <Widget>[
                      ...statusDeliveries.mapIndexed((data, index) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: MyColor.mainRed),
                          ),
                          onPressed: () {
                            setState(() {
                              statusDelivery = data[1];
                            });
                          },
                          color: statusDelivery == data[1]
                              ? MyColor.mainRed
                              : Colors.white,
                          child: Text(
                            data[0],
                            style: TextStyle(
                              color: statusDelivery == data[1]
                                  ? Colors.white
                                  : MyColor.txtField,
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Dikirim oleh',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: deliveredController,
                          //initialValue: company.name,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Diterima oleh',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: receivedController,
//                          initialValue: customer.name,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Pelanggan',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: customerController,
//                          initialValue: customer.company,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Alamat',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: MyColor.blueDio,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: addressController,
//                          initialValue: customer.address,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MyDivider.spaceDividerLogin(custom: 6),
            Column(
              children: <Widget>[
                ...sbItems.map((sbi) {
                  var qtyUnsent = MyNumber.strUSToDouble(sbi.quantity) -
                      MyNumber.strUSToDouble(sbi.sentQuantity);
                  final qtyController = TextEditingController(
                      text: MyNumber.toNumberIdStr(
                    sbi.unitQuantity,
                  ));
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: MyColor.blueDio,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
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
                                  Text(sbi.productName ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith()),
                                  Text(sbi.productCode ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(color: MyColor.txtField)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      '${MyNumber.toNumberIdStr(sbi.quantity)} ${sbi.productUnitCode}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(color: MyColor.txtField)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Belum Terkirim',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: MyColor.txtField)),
                                Row(
                                  children: <Widget>[
                                    Text('${MyNumber.toNumberId(qtyUnsent)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(color: MyColor.mainRed)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('${sbi.productUnitCode}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(color: MyColor.mainRed)),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('Jumlah Kirim',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: MyColor.txtField)),
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
//                                  decoration: BoxDecoration(
//                                      border: Border(
//                                    bottom: BorderSide(
//                                      color: Colors.black,
//                                      width: 1.0,
//                                    ),
//                                  )),
                                  child: Row(
                                    children: <Widget>[
                                      //btnMinus
                                      CupertinoButton(
                                        onPressed: () {
                                          var newQty = MyNumber.strUSToDouble(
                                                sbi.unitQuantity,
                                              ) -
                                              1;
                                          if (newQty < 0) newQty = 0;
                                          setState(() {
                                            sbi.unitQuantity =
                                                newQty.toString();
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: MyColor.mainRed,
                                        ),
                                        minSize: 0,
                                        padding: EdgeInsets.all(0),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      //labelQty
                                      Container(
                                        width: 75,
                                        child: TextFormField(
                                          controller: qtyController,
                                          onChanged: (newValue) {
                                            var newQty = MyNumber.strIDToDouble(newValue);
                                            sbi.unitQuantity =
                                                newQty.toString();
                                            if (newQty > qtyUnsent) {
                                              qtyController.text =
                                                  MyNumber.toNumberId(qtyUnsent);
                                              sbi.unitQuantity =
                                                  qtyUnsent.toString();
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(color: MyColor.blueDio),
                                          inputFormatters: [
                                            NumericTextFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: false),
                                          decoration: new InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      //btnPlus
                                      CupertinoButton(
                                        onPressed: () {
                                          var newQty = MyNumber.strUSToDouble(
                                                sbi.unitQuantity,
                                              ) +
                                              1;
                                          if (newQty > qtyUnsent)
                                            newQty = qtyUnsent;
                                          setState(() {
                                            sbi.unitQuantity =
                                                newQty.toString();
                                          });
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: MyColor.mainGreen,
                                        ),
                                        minSize: 0,
                                        padding: EdgeInsets.all(0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
            MyDivider.lineDivider(customColor: MyColor.txtField),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lampiran',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: DottedBorder(
                      padding: EdgeInsets.all(8),
                      color: MyColor.lineDivider,
                      strokeWidth: 1,
                      dashPattern: [8, 8],
                      child: CupertinoButton(
                        onPressed: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Icon(
                                Icons.insert_drive_file,
                                size: 48,
                                color: MyColor.blueDio,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Telusuri',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: MyColor.blueDio)),
                                Text(' file untuk upload',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: MyColor.txtField)),
                              ],
                            ),
                          ],
                        ),
                        minSize: 0,
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Catatan',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  TextFormField(
                    //controller: noteController,
                    decoration: new InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  LoadingButton(
                    title: 'KIRIM',
                    onPressed: () async {
                      var body = {
                        'date': date.toStr(),
                        'sale_reference_no': sb.referenceNo,
                        'customer': customerController.text,
                        'address': addressController.text,
                        'status': statusDelivery,
                        'delivered_by': deliveredController.text,
                        'received_by': receivedController.text,
                        'note': noteController.text,
                        'products': sbItems.map((sbi) {
                          return {
                            'sale_items_id': sbi.id,
                            'sent_quantity': sbi.unitQuantity,
                          };
                        }).toList(),
                      };
                      //print('new delivery $body');
                      await actionPostDelivery(body);
                    },
                    noMargin: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Dftr Krm',
        middle: Text(
          'Tambah Pengiriman',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      child: Material(
        child: SafeArea(
          child: _body(),
        ),
      ),
    );
  }
}
