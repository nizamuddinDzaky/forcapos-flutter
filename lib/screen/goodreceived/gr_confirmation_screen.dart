import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';

class GRConfirmationScreen extends StatefulWidget {
  @override
  _GRConfirmationScreenState createState() => _GRConfirmationScreenState();
}

class _GRConfirmationScreenState extends State<GRConfirmationScreen> {
//  final priceController = TextEditingController(text: MyNumber.toNumberId(double.tryParse('2000')));
//  final qtyController = TextEditingController(text: MyNumber.toNumberId(double.tryParse('1000')));
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  var total = 0.0;
  GoodReceived gr;
  bool isFirst = true;

  void totalPrice() {
    var price = MyNumber.strToDouble(priceController.text);
    var qty = MyNumber.strToDouble(qtyController.text);
    setState(() {
      total = price * qty;
    });
  }

  @override
  void initState() {
    super.initState();
    priceController.addListener(totalPrice);
    qtyController.addListener(totalPrice);
    //WidgetsBinding.instance.addPostFrameCallback((_) => totalPrice());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      gr = GoodReceived.fromJson(arg ?? {});
      var qtyDo = MyNumber.strUSToDouble(gr.qtyDo);
      var total = MyNumber.strUSToDouble(gr.total);
      var price = total / (qtyDo == 0 ? 1 : qtyDo);
      print('cek hitung ${gr.qtyDo} ${gr.total} | $total / $qtyDo = $price');
      priceController.text = MyNumber.toNumberId(price);
      qtyController.text = MyNumber.toNumberId(double.tryParse(gr.qtyDo));
      isFirst = false;
//      print('cek gr $price ${gr.total} ${Get.args(context)}');
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text(
            'Membuat Pembelian',
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFFBEBEBE),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Nomor SPJ',
                      style: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${gr.noSpj}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              listItemGR(),
              Divider(
                height: 2,
                color: Color(0xFFCACACA),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        color: MyColor.txtField,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      MyNumber.toNumberRp(total) ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              Container(
                margin: MyDimen.marginLayout(),
                width: double.maxFinite,
                child: FlatButton(
                  color: MyColor.mainGreen,
                  child: Text(
                    'Terima',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Get.back(result: {"isSuccess": true});
                  },
                ),
              ),
//              CupertinoButton(
//                color: MyColor.mainGreen,
//                borderRadius: BorderRadius.all(Radius.circular(8)),
//                onPressed: () {},
//                child: Text(
//                  'Terima',
//                  style: TextStyle(color: Colors.white),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItemGR() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${gr.namaProduk}'),
          Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Harga'),
                    TextFormField(
                      controller: priceController,
//                      onChanged: (newVal) => totalPrice(newVal),
//                      initialValue: MyNumber.toNumberId(double.tryParse('2000')),
//                      maxLength: 10,
                      inputFormatters: [
                        //WhitelistingTextInputFormatter.digitsOnly
                        NumericTextFormatter()
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(signed: false),
                      decoration: new InputDecoration(
                        prefixText: 'Rp',
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Quantity'),
                    TextFormField(
                      controller: qtyController,
//                      onChanged: (newVal) => totalPrice(newVal),
//                      initialValue: MyNumber.toNumberId(double.tryParse('1000')),
                      inputFormatters: [
                        //WhitelistingTextInputFormatter.digitsOnly
                        NumericTextFormatter()
                      ],
//                      maxLength: 6,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: new InputDecoration(
                        suffixText: '${gr.uom}',
                      ),
                    ),
                  ],
                ),
              ),
//              VerticalDivider(width: 10,),
//              Column(
//                children: <Widget>[
//                  Text(''),
//                  Text('Rp 15.000.000,-'),
//                ],
//              ),
            ],
          )
        ],
      ),
    );
  }

  textField() => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Harga'),
            TextField(
              decoration: new InputDecoration(
                prefixText: 'Rp',
              ),
            ),
          ],
        ),
      );
}
