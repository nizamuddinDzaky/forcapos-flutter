import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/customer/detail_customer_view_model.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_decoration.dart';
import 'package:posku/util/widget/my_divider.dart';

class DetailCustomerScreen extends StatefulWidget {
  @override
  _DetailCustomerScreenState createState() => _DetailCustomerScreenState();
}

class _DetailCustomerScreenState extends DetailCustomerViewModel {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: Text(
          'Rincian Pelanggan',
        ),
        trailing: CupertinoButton(
          onPressed: () {},
          minSize: 0,
          padding: EdgeInsets.all(0),
          child: Text('Ubah'),
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: MyColor.mainBg,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: MyDecoration.decorationGradient(
                      top2bottom: true,
                      reverse: true,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                              child: Text('PoS',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Nama Pelanggan',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _listItem('Nama Toko', val: 'tes'),
                  _listItem('Kelompok Pelanggan'),
                  _listItem('NPWP'),
                  _listItem('Deposit'),
                  _listItem('Point Pelanggan'),
                  _listItem('Email'),
                  _listItem('Telp/HP'),
                  _listItem('Alamat'),
                  _listItem('Kecamatan'),
                  _listItem('Kab./Kota'),
                  _listItem('Provinsi'),
                  _listItem('ID BK'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItem(String title, {String val, bool forceShow = true}) {
    return val != null || forceShow
        ? Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title ?? ''),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text(
                          val ?? '',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.body2,
                        ),
                      ),
                    ],
                  ),
                ),
                MyDivider.lineDivider(),
              ],
            ),
          )
        : Container();
  }
}
