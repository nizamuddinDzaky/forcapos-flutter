import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/customer/detail_customer_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/style/my_decoration.dart';
import 'package:posku/util/widget/my_divider.dart';

class DetailCustomerScreen extends StatefulWidget {
  @override
  _DetailCustomerScreenState createState() => _DetailCustomerScreenState();
}

class _DetailCustomerScreenState extends DetailCustomerViewModel {
  Widget _listItem(
    String title, {
    String val,
    bool forceShow = true,
    bool isEnd = false,
  }) {
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
                          (val ?? '').isEmpty ? '-' : val,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isEnd) MyDivider.lineDivider(),
              ],
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: Text(
          'Rincian Pelanggan',
        ),
        trailing: CupertinoButton(
          onPressed: () => goToEditCustomer(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      .headline6
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            customer?.name ?? '',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _listItem('Nama Toko', val: customer?.company),
                  _listItem('Kelompok Pelanggan',
                      val: customer?.customerGroupName),
                  _listItem('NPWP', val: customer?.vatNo),
                  _listItem('Deposit (Rp)',
                      val: MyNumber.toNumberIdStr(customer?.depositAmount)),
                  _listItem('Point Pelanggan',
                      val: MyNumber.toNumberIdStr(customer?.awardPoints)),
                  _listItem('Email', val: customer?.email),
                  _listItem('Telp/HP', val: customer?.phone),
                  _listItem('Alamat', val: customer?.address),
                  _listItem('Kecamatan', val: customer?.state),
                  _listItem('Kab./Kota', val: customer?.city),
                  _listItem('Provinsi', val: customer?.country),
                  _listItem('ID BK', val: customer?.cf1, isEnd: true),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Info Gudang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Default Gudang: ${defaultWarehouse?.name ?? '-'}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  ...(listWarehouses ?? [])?.map(
                    (warehouse) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: _listItem(warehouse?.name ?? '', val: ' '),
                    ),
                  )?.toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
