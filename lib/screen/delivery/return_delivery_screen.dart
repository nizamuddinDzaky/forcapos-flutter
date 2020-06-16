import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/delivery/return_delivery_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class ReturnDeliveryScreen extends StatefulWidget {
  @override
  _ReturnDeliveryScreenState createState() => _ReturnDeliveryScreenState();
}

class _ReturnDeliveryScreenState extends ReturnDeliveryViewModel {
  Widget _sectionDetail() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //date
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
                      DateTime newDateTime = await showRoundedDatePicker(
                        context: context,
                        initialDate: currentDate,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
                      setState(() {
                        currentDate = newDateTime ?? currentDate;
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('${strToDate(currentDate.toString())}'),
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
          //refNoDelivery
          Text(
            'Referensi Nomor Pengiriman',
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
                  controller: refNoDeliveryController,
                  enabled: false,
                  decoration: new InputDecoration(
                    isDense: true,
                    hintText: delivery?.doReferenceNo ?? 'DO/2020/...',
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
          //refNo
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
                  enabled: false,
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
          //customerName
          Text(
            'Nama Pelanggan',
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
          //customerAddress
          SizedBox(
            height: 8,
          ),
          Text(
            'Alamat Pelanggan',
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
    );
  }

  Widget _listDeliveries() {
    return Container(
      child: Column(
        children: <Widget>[
          ...deliveryItems.map((di) {
//            var qtyUnsent =
//                di.quantityOrdered.tryToDouble() - di.allSentQty.tryToDouble();
//            var maxQty = qtyUnsent + di.tempQty.tryToDouble();
            var maxQty = di.tempQty.tryToDouble();
            final qtyController = TextEditingController(
              text: di.quantitySent.toNumId(),
            );
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  Row(
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
                            Text(di.productName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith()),
                            Text(di.productCode ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: MyColor.txtField)),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${MyNumber.toNumberIdStr(di.quantityOrdered)} ${di.productUnitCode}',
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
                          Text('Qty Terkirim',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: MyColor.txtField)),
                          Row(
                            children: <Widget>[
                              Text('${di.tempQty.toNumId()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: MyColor.mainRed)),
                              SizedBox(
                                width: 8,
                              ),
                              Text('${di.productUnitCode}',
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
                          Text('Dikembalikan',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: MyColor.txtField)),
                          Container(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: <Widget>[
                                //btnMinus
                                CupertinoButton(
                                  onPressed: () {
                                    var newQty = MyNumber.strUSToDouble(
                                          di.quantitySent,
                                        ) -
                                        1;
                                    if (newQty < 1) newQty = 1;
                                    setState(() {
                                      di.quantitySent = newQty.toString();
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
                                    onSaved: (newValue) {
                                      if (newValue.isNotEmpty) return;
                                      var newQty = MyNumber.toNumberIdStr(
                                          di.quantitySent);
                                      qtyController.text = newQty;
                                    },
                                    onChanged: (newValue) {
                                      if (newValue.isEmpty) return;
                                      var newQty =
                                          MyNumber.strIDToDouble(newValue);
                                      if (newQty > maxQty) {
                                        newQty = maxQty;
                                        lastCursorQty(qtyController, newQty);
                                      }
                                      if (newQty < 1) {
                                        newQty = 1;
                                        lastCursorQty(qtyController, newQty);
                                      }
                                    },
                                    onFieldSubmitted: (newValue) {
                                      var newQty =
                                          MyNumber.strIDToDouble(newValue);
                                      if (newQty > maxQty) newQty = maxQty;
                                      if (newQty < 1) newQty = 1;
                                      setState(() {
                                        di.quantitySent = newQty.toString();
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: MyColor.blueDio),
                                    inputFormatters: [NumericTextFormatter()],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: false),
                                    decoration: new InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
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
                                          di.quantitySent,
                                        ) +
                                        1;
                                    if (newQty > maxQty) newQty = maxQty;
                                    setState(() {
                                      di.quantitySent = newQty.toString();
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
    );
  }

  Widget _footer() {
    return Container(
      child: Column(
        children: <Widget>[
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
                  controller: noteController,
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
                  onPressed: actionSubmit,
                  noMargin: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  _sectionDetail(),
                  MyDivider.spaceDividerLogin(custom: 6),
                  Form(
                    key: formKey,
                    child: _listDeliveries(),
                  ),
                  MyDivider.lineDivider(customColor: MyColor.txtField),
                  _footer(),
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
        previousPageTitle: 'Dt Kirim',
        middle: Text(
          'Retur Pengiriman',
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
