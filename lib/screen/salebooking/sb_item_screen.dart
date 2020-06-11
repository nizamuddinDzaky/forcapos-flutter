import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/salebooking/sales_booking_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/my_util.dart';

class SalesBookingItemScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final discountController = TextEditingController();

  double discountFromPercent(Product p, String val) {
    var percent = val.substring(0, val.length - 1);
    var discount = p.price.toDouble() * percent.toDoubleID() / 100.0;
    return discount;
  }

  void discountToPercent(Product p) {
    var result =
        discountController.text.toDoubleID() / p.price.toDouble() * 100.0;
    print('decimal cek $result');
    discountController.text = '${result.toString().toDecId()}%';
  }

  Widget _body(SalesBookingController vm, Product p) {
    if (discountController.text.isEmpty)
      discountController.text = p.discount.toNumId();
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Nomor Serial
                Text(
                  'Nomor Serial',
                  style: Theme.of(Get.context).textTheme.subtitle2,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.description,
                      size: 16,
                      color: MyColor.blueDio,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        //controller: deliveredController,
                        initialValue: p.code,
                        onSaved: (newValue) {
                          p.code = newValue;
                        },
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
                //Kuantitas
                Text(
                  'Kuantitas',
                  style: Theme.of(Get.context).textTheme.subtitle2,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 16,
                      color: MyColor.blueDio,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        //controller: amountController,
                        initialValue: p.minOrder.toNumId(),
                        onSaved: (newValue) {
                          vm.qtyCustom(p, newValue, isRefresh: false);
                        },
                        inputFormatters: [NumericTextFormatter()],
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
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
                //Satuan Harga
                Text(
                  'Satuan Harga',
                  style: Theme.of(Get.context).textTheme.subtitle2,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: MyColor.blueDio,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        //controller: amountController,
                        initialValue: p.price.toNumId(),
                        onSaved: (newValue) {
                          p.price = newValue.toDoubleID().toString();
                        },
                        inputFormatters: [NumericTextFormatter()],
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
                        decoration: new InputDecoration(
                          prefixText: 'Rp ',
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
                //Diskon
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  var convertDiscount = 0.0;
                  if (discountController.text.endsWith('%')) {
                    convertDiscount =
                        discountFromPercent(p, discountController.text);
                  } else {
                    try {
                      convertDiscount = discountController.text.toDoubleID();
                    } catch(_) {}
                  }
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Diskon',
                            style: Theme.of(Get.context).textTheme.subtitle2,
                          ),
                          Row(
                            children: <Widget>[
                              if (!discountController.text.endsWith('%'))
                                CupertinoButton(
                                  minSize: 0,
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  onPressed:
                                      !discountController.text.endsWith('%')
                                          ? () {
                                              discountToPercent(p);
                                              setState(() {});
                                            }
                                          : null,
                                  child: Text(
                                    'Ubah ke persen',
                                  ),
                                ),
                              if (discountController.text.endsWith('%'))
                                CupertinoButton(
                                  minSize: 0,
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  onPressed:
                                      discountController.text.endsWith('%')
                                          ? () {
                                              var result = discountFromPercent(
                                                  p, discountController.text);
                                              lastCursorEditText(
                                                  discountController, result);
                                              setState(() {});
                                            }
                                          : null,
                                  child: Text(
                                    'Ubah ke rupiah',
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.money_off,
                            size: 16,
                            color: MyColor.blueDio,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: discountController,
                              //initialValue: p.discount.toNumId(),
                              onSaved: (newValue) {
                                p.discount = convertDiscount.toString();
                              },
                              onChanged: (newValue) {
                                setState(() {});
                              },
                              onFieldSubmitted: (val) {
                                if (val.endsWith('%')) {
                                  //p.discount = countDiscount(p, val).toString();
                                } else {
                                  double discount;
                                  try {
                                    discount = val.toDoubleID();
                                  } catch (_) {}
                                  if (discount == null) {
                                    discount = p.discount.toDouble();
                                  }
                                  lastCursorEditText(
                                      discountController, discount);
                                }
                                vm.refresh();
                              },
                              decoration: new InputDecoration(
                                prefixText: p.discount == null
                                    ? null
                                    : (discountController.text.endsWith('%')
                                        ? null
                                        : 'Rp '),
                                suffixText: discountController.text.isNotEmpty
                                    ? ' = ${(p.price.toDouble() - convertDiscount).toString().toRp()}'
                                    : null,
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
                  );
                }),
/*
                Row(
                  children: <Widget>[
                    Text(
                      'Diskon',
                      style: Theme.of(Get.context).textTheme.subtitle2,
                    ),
                    if (discountController.text.endsWith('%'))
                      Text(
                        ': ${p.discount.toRp()}',
                        style: Theme.of(Get.context).textTheme.subtitle2,
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.money_off,
                      size: 16,
                      color: MyColor.blueDio,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: discountController,
                        //initialValue: p.discount.toNumId(),
                        onSaved: (newValue) {
                          p.discount = newValue.toDoubleID().toString();
                          print('cek diskon save $newValue ${p.discount}');
                        },
                        onChanged: (newValue) {},
                        onFieldSubmitted: (val) {
                          if (val.endsWith('%')) {
                            //p.discount = countDiscount(p, val).toString();
                          } else {
                            double discount;
                            try {
                              discount = val.toDoubleID();
                            } catch (_) {}
                            if (discount == null) {
                              discount = p.discount.toDouble();
                            }
                            lastCursorEditText(discountController, discount);
                          }
                          vm.refresh();
                        },
                        decoration: new InputDecoration(
                          prefixText: p.discount == null
                              ? null
                              : (discountController.text.endsWith('%')
                                  ? null
                                  : 'Rp '),
//                          suffixText: p.discount.toDouble() != 0
//                              ? ' = ${(p.price.toDouble() - discountController.text.toDouble()).toString().toRp()}'
//                              : null,
                          suffixText: discountController.text.isNotEmpty
                              ? ' = ${(p.price.toDouble() - countDiscount(p, discountController.text)).toString().toRp()}'
                              : null,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
*/
                SizedBox(
                  height: 16,
                ),
                LoadingButton(
                  noMargin: true,
                  title: 'Simpan Perubahan',
                  onPressed: () {
                    formKey.currentState.save();
                    vm.refresh();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments as Map<String, dynamic>;
    int index = arg['index'];
    return GetBuilder<SalesBookingController>(
      init: SalesBookingController(),
      builder: (vm) {
        var p = vm.cartList[index];
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Keranjang',
            middle: Text(
              'Product',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          child: Material(
            child: SafeArea(
              child: _body(vm, p),
            ),
          ),
        );
      },
    );
  }
}
