import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class GRDetailScreen extends StatefulWidget {
  @override
  _GRDetailScreenState createState() => _GRDetailScreenState();
}

abstract class GRDetailViewModel extends State<GRDetailScreen> {}

class _GRDetailScreenState extends GRDetailViewModel {
  Widget tileInfo({Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: MyColor.mainRed,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[0] ?? '',
                  style: TextStyle(color: MyColor.txtBlack),
                ),
                Text(
                  data[1] ?? '',
                  style: TextStyle(
                      color: MyColor.txtBlack, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[2] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
                Text(
                  data[3] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionDO({String noDo}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'DO',
                style: TextStyle(
                    color: MyColor.txtField, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  noDo ?? '',
                  style: TextStyle(
                      color: MyColor.txtBlack, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Text(
              'Salin',
              style: TextStyle(
                  fontSize: 14,
                  color: MyColor.mainRed,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTotal({String totalItem}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Total All Item (Rp)',
            style:
                TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
          Text(
            totalItem ?? '',
            style:
                TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget sectionDetail() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Detail',
            style:
                TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
          Text(
            '',
            style:
                TextStyle(color: MyColor.txtField, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget sectionDetailItem({Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data[0] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
                Text(
                  data[1] ?? '',
                  style: TextStyle(color: MyColor.txtField),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          CupertinoButton(
            minSize: 20,
            padding: EdgeInsets.all(0),
            onPressed: data[2] == null ? null : () {},
            child: Text(
              'Salin',
              style: TextStyle(
                  fontSize: 14,
                  color: data[2] == null ? Colors.white : MyColor.mainRed,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget listProductItem({Map<int, dynamic> data = const {}}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.image,
            size: 75,
            color: Colors.lightBlueAccent,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data[0] ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.mainRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data[1] ?? '',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColor.txtBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                data[2] ?? '',
                style: TextStyle(
                  fontSize: 20,
                  color: MyColor.txtField,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data[3] ?? '',
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text(
            'Rincian Pembelian',
          ),
        ),
        child: SafeArea(
          child: Container(
            color: MyColor.mainBg,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: <Widget>[
                  tileInfo(data: {0: 'From', 1: '', 2: '', 3: ''}),
                  MyDivider.lineDivider(),
                  tileInfo(data: {0: 'To', 1: '', 2: '', 3: ''}),
                  MyDivider.spaceDividerLogin(),
                  sectionDO(),
                  MyDivider.lineDivider(),
                  listProductItem(),
                  MyDivider.lineDivider(),
                  sectionTotal(),
                  MyDivider.spaceDividerLogin(),
                  sectionDetail(),
                  MyDivider.lineDivider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ...[
                          {0: 'No. PP', 1: '1000092928', 2: true},
                          {0: 'Date PP', 1: '1000092928', 2: null},
                          {0: 'No. SO', 1: '1000092928', 2: true},
                          {0: 'Tanggal SO', 1: '1000092928', 2: null},
                          {0: 'No. Transaksi', 1: '1000092928', 2: true},
                          {0: 'Tipe Pemesanan', 1: '1000092928', 2: null},
                        ].map((data) {
                          return sectionDetailItem(data: data);
                        }),
                      ],
                    ),
                  ),
                  MyDivider.lineDivider(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ...[
                          {0: 'No. SPJ', 1: '1000092928', 2: true},
                          {0: 'Tanggal SPJ', 1: '1000092928', 2: null},
                          {0: 'No. Polisi', 1: '1000092928', 2: true},
                          {0: 'Nama Pengemudi', 1: '1000092928', 2: null},
                          {0: 'Kode Pabrik', 1: '1000092928', 2: null},
                          {0: 'Ket. Pabrik', 1: '1000092928', 2: null},
                        ].map((data) {
                          return sectionDetailItem(data: data);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
