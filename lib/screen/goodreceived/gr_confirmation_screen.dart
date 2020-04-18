import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/goodreceived/gr_confirmation_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';

class GRConfirmationScreen extends StatefulWidget {
  @override
  _GRConfirmationScreenState createState() => _GRConfirmationScreenState();
}

class _GRConfirmationScreenState extends GRConfirmationViewModel {
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
             LoadingButton(onPressed: actionBtnReceive, title: 'Terima'),
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
                      inputFormatters: [
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
                      inputFormatters: [
                        NumericTextFormatter()
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: new InputDecoration(
                        suffixText: '${gr.uom}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
