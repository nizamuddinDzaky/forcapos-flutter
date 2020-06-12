import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/salebooking/edit_sb_controller.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';

class EditSBItemScreen extends StatefulWidget {
  @override
  _EditSBItemScreenState createState() => _EditSBItemScreenState();
}

class _EditSBItemScreenState extends State<EditSBItemScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController priceController, discountController;

  double discountFromPercent(double price, String val) {
    var percent = val.substring(0, val.length - 1);
    var discount = price * percent.tryIDtoDouble() / 100.0;
    return discount;
  }

  String discountToPercent(String discount, double price) {
    var result = discount.toDoubleID() / price * 100.0;
    return '${result.toDecId()}%';
  }

  Widget _body(EditSBController vm) {
    var sbi = vm.editSBI;

    if (priceController == null) {
      priceController = TextEditingController(text: sbi.netUnitPrice.toNumId());
    }
    if (discountController == null) {
      discountController = TextEditingController(text: sbi.discount.toNumId());
    }
    var price = priceController.text.tryIDtoDouble();

    var convertDiscount = 0.0;
    if (discountController.text.endsWith('%')) {
      convertDiscount = discountFromPercent(price, discountController.text);
    } else {
      convertDiscount = discountController.text.tryIDtoDouble();
    }

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
                        initialValue: sbi?.productCode ?? '',
                        onSaved: (newValue) {
                          sbi.productCode = newValue;
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
                        initialValue: sbi?.quantity?.toNumId() ?? '',
                        onSaved: (newValue) {
                          //vm.qtyCustom(sbi, newValue, isRefresh: false);
                          vm.qtyCustom(sbi, qtyStr: newValue);
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
                        controller: priceController,
                        onChanged: (_) {
                          setState(() {});
                        },
                        onSaved: (newValue) {
                          sbi.netUnitPrice = newValue.toDoubleID().toString();
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
                Column(
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
                                onPressed: !discountController.text
                                        .endsWith('%')
                                    ? () {
                                        discountController.text =
                                            discountToPercent(
                                                discountController.text, price);
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
                                onPressed: discountController.text.endsWith('%')
                                    ? () {
                                        var result = discountFromPercent(
                                            price, discountController.text);
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
                              sbi.discount = convertDiscount.toString();
                            },
                            onChanged: (newValue) {
                              setState(() {
                                print('diskon = $convertDiscount');
                              });
                            },
/*
                            onFieldSubmitted: (val) {
                              if (val.endsWith('%')) {
                                //p.discount = countDiscount(p, val).toString();
                              } else {
                                double discount;
                                try {
                                  discount = val.toDoubleID();
                                } catch (_) {}
                                if (discount == null) {
                                  discount = sbi.discount.toDouble();
                                }
                                lastCursorEditText(
                                    discountController, discount);
                              }
                              vm.refresh();
                            },
*/
                            decoration: new InputDecoration(
                              prefixText: discountController.text.endsWith('%')
                                  ? null
                                  : 'Rp ',
                              suffixText: discountController.text.isNotEmpty
                                  ? ' = ${(price - convertDiscount).toRp()}'
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
                ),
                SizedBox(
                  height: 16,
                ),
                LoadingButton(
                  noMargin: true,
                  title: 'Simpan Perubahan',
                  onPressed: () {
                    formKey.currentState.save();
//                    vm.refresh();
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
    return GetBuilder<EditSBController>(
      init: EditSBController(),
      builder: (vm) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Kembali',
            middle: Text(
              'Ubah Item',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          child: Material(
            child: SafeArea(
              child: _body(vm),
            ),
          ),
        );
      },
    );
  }
}
