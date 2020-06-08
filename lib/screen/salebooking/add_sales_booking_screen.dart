import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/salebooking/sb_order_controller.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddSalesBookingScreen extends StatefulWidget {
  @override
  _AddSalesBookingScreenState createState() => _AddSalesBookingScreenState();
}

class _AddSalesBookingScreenState extends State<AddSalesBookingScreen> {
  Widget _sectionDetail(SBOrderController vm) {
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
                        initialDate: vm.currentDate,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
                      vm.setDate(newDateTime);
//                      setState(() {
//                        currentDate = newDateTime ?? currentDate;
//                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('${strToDate(vm.currentDate.toString())}'),
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
//                      await actionGetWarehouse(vm);
                      await vm.actionGetWarehouse();
                      vm.showWarehousePicker(context);
//                      showWarehousePicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      vm.currentWarehouse?.name ?? 'Pilih Gudang',
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
                Icons.perm_identity,
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
//                      await actionGetCustomer(vm);
                      await vm.actionGetCustomer();
                      vm.showCustomerPicker(context);
//                      showCustomerPicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      vm.currentCustomer?.name ?? 'Pilih Pelanggan',
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
          Center(
            child: Text(
              'Semua kolom wajib terisi',
              style: TextStyle(
                color: (vm.currentWarehouse != null && vm.currentCustomer != null)
                    ? Colors.transparent
                    : Colors.red,
              ),
            ),
          ),
          LoadingButton(
            title: 'Lanjutkan',
            noMargin: true,
            onPressed: () {
              if (vm.currentWarehouse != null && vm.currentCustomer != null)
                Get.toNamed(salesBookingOrderScreen);
            },
          ),
        ],
      ),
    );
  }

  Widget _body(SBOrderController vm) {
    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  _sectionDetail(vm),
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
          //'Tambah Penjualan',
          'Data Pemesanan',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      child: Material(
        child: SafeArea(
          child: GetBuilder<SBOrderController>(
            init: SBOrderController(),
            builder: (vm) => _body(vm),
          ),
        ),
      ),
    );
  }
}
