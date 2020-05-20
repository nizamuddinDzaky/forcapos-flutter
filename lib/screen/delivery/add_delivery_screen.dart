import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/delivery_item.dart';
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
    List<DeliveryItem> deliveryItems = [
      DeliveryItem(),
    ];
    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(vertical: 8),
//        padding: EdgeInsets.only(bottom: 16),
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
                    style: Theme.of(context).textTheme.subtitle,
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
                          //controller: noteController,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                          //controller: noteController,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                          //controller: noteController,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                          //controller: noteController,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                          //controller: noteController,
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
                ...deliveryItems.map((data) {
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
                                        .title
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith()),
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
                                          .subtitle
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Belum Terkirim',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(color: MyColor.mainRed)),
                                Row(
                                  children: <Widget>[
                                    Text('100',
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(color: MyColor.mainRed)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('SAK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
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
                                        .subtitle
                                        .copyWith(color: MyColor.mainGreen)),
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: Row(
                                    children: <Widget>[
                                      CupertinoButton(
                                        onPressed: () {},
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
                                      Text('100',
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: MyColor.mainRed)),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      CupertinoButton(
                                        onPressed: () {},
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
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: DottedBorder(
                      padding: EdgeInsets.all(8),
                      color: MyColor.lineDivider,
                      strokeWidth: 1,
                      dashPattern: [8, 8],
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
                                      .subtitle
                                      .copyWith(color: MyColor.blueDio)),
                              Text(' file untuk upload',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(color: MyColor.txtField)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Catatan',
                    style: Theme.of(context).textTheme.subtitle,
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
                    onPressed: () {},
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
          style: Theme.of(context).textTheme.title,
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
