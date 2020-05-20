import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/payment/add_payment_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                constraints: BoxConstraints(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: MyColor.mainRed),
                ),
                fillColor: MyColor.mainRed,
                onPressed: () {},
                child: Text(
                  'Tunai',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
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
                    style: Theme.of(context).textTheme.subtitle,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                    style: Theme.of(context).textTheme.subtitle,
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
                print('save: ${MyNumber.strIDToDouble(amountController.text)}');
                print('save: ${noteController.text}');
                print('save: ${date.toStr()}');
                await Future.delayed(Duration(seconds: 2));
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
