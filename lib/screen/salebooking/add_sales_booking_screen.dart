import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/salebooking/add_sb_view_model.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddSalesBookingScreen extends StatefulWidget {
  @override
  _AddSalesBookingScreenState createState() => _AddSalesBookingScreenState();
}

class _AddSalesBookingScreenState extends AddSBViewModel {
  void showWarehousePicker() {
    DataPicker.showDatePicker(
      context,
      locale: 'id',
      datas: listWarehouse,
      title: 'Pilih Gudang',
      onConfirm: (data) {
        currentWarehouse = data;
        refreshData();
      },
    );
  }

  void showCustomerPicker() {
    DataPicker.showDatePicker(
      context,
      locale: 'id',
      datas: listCustomer,
      title: 'Pilih Pelanggan',
      onConfirm: (data) {
        currentCustomer = data;
        refreshData();
      },
    );
  }

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
          //warehouse
          Text(
            'Gudang',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.store,
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
                      await actionGetWarehouse();
                      showWarehousePicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      currentWarehouse?.name ?? 'Pilih Gudang',
//                      style: TextStyle(
//                        color: currentWarehouse == null ? null : Colors.black,
//                      ),
                    ),
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
          //customer
          Text(
            'Pelanggan',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.store,
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
                      await actionGetCustomer();
                      showCustomerPicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      currentCustomer?.name ?? 'Pilih Pelanggan',
//                      style: TextStyle(
//                        color: currentWarehouse == null ? null : Colors.black,
//                      ),
                    ),
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
            height: 24,
          ),
          LoadingButton(
            title: 'Lanjutkan',
            noMargin: true,
            onPressed: () {
              //Get.to(SalesBookingOrderScreen());
              Get.toNamed(salesBookingOrderScreen);
            },
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
//                  MyDivider.spaceDividerLogin(custom: 6),
//                  Form(
//                    key: formKey,
//                    child: _listDeliveries(),
//                  ),
//                  MyDivider.lineDivider(customColor: MyColor.txtField),
//                  _footer(),
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
        previousPageTitle: 'Dftr Jual',
        middle: Text(
          'Tambah Penjualan',
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

class SalesBookingOrderScreen extends StatefulWidget {
  @override
  _SalesBookingOrderScreenState createState() =>
      _SalesBookingOrderScreenState();
}

class _SalesBookingOrderScreenState extends State<SalesBookingOrderScreen> {
  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          LoadingButton(
            title: 'Kirim',
            noMargin: true,
            onPressed: () {
              Get.until(ModalRoute.withName(homeScreen));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Kembali',
        middle: Text(
          'Pemesanan',
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
