import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/payment/add_payment_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/payment_cons.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddPaymentScreen extends StatefulWidget {
  @override
  _AddPaymentScreenState createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends AddPaymentViewModel {
  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        //color: MyColor.mainBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 32,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listPaymentType.length,
                itemBuilder: (ctx, idx) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: RawMaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      constraints: BoxConstraints(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: MyColor.mainRed),
                      ),
                      fillColor: listPaymentType[idx][2] == paymentType[2]
                          ? MyColor.mainRed
                          : Colors.white,
                      onPressed: () {
                        setState(() {
                          paymentType = listPaymentType[idx];
                        });
                      },
                      child: Text(
                        listPaymentType[idx][0],
                        style: TextStyle(
                          color: listPaymentType[idx][2] == paymentType[2]
                              ? Colors.white
                              : MyColor.txtField,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            MyDivider.lineDivider(vertical: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tanggal',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  CupertinoButton(
                    onPressed: () async {
                      DateTime newDateTime = await showRoundedDatePicker(
                        context: context,
                        initialDate: date,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
                      setState(() {
                        date = newDateTime ?? date;
                      });
                    },
                    padding: EdgeInsets.all(0),
                    child: Text('${strToDate(date.toString())}'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Jumlah',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  TextFormField(
                    controller: amountController,
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
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            LoadingButton(
              onPressed: () async {
                var amount = MyNumber.strIDToDouble(amountController.text);
                if (amount > 0) {
                  Map<String, String> body = {
                    'amount_paid': amount.toString(),
                    'note': noteController.text,
                    'date': date.toStr(),
                    'payment_method': paymentType[1],
                  };
                  //print('cek data $body');
                  await actionPostPayment(body);
                } else {
                  Get.defaultDialog(
                    title: 'Mohon Maaf',
                    content: Text('Jumlah tidak boleh kosong/nol'),
                  );
                }
              },
              title: 'Tambah Pembayaran',
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
        previousPageTitle: 'Dftr Byr',
        middle: Text(
          'Tambah Pembayaran',
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
