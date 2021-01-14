import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/purchase/add_purchase_view_model.dart';
import 'package:posku/screen/purchase/purchase_controller.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddPurchaseScreen extends StatefulWidget {
  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends AddPurchaseViewModel {

  Widget _sectionDetail(PurchaseController vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //date
          Text(
            'Tanggal',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${strToDate(vm.currentDate.toString())}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
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
          //warehouse
          Text(
            'Gudang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            child: Row(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            vm.currentWarehouse?.name ?? 'Pilih Gudang',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            'Pemasok',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            child: Row(
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
                        await vm.actionGetSupplier();
                        vm.showSupplierPicker(context);
//                      showCustomerPicker();
                      },
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            vm.currentSupplier?.name ?? 'Pilih Pelanggan', style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                color: (vm.currentWarehouse != null && vm.currentSupplier != null)
                    ? Colors.transparent
                    : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(PurchaseController vm) {
    return Scaffold(
      body: Container(
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 4.0,
                offset: Offset(0.0, 0.75)
            )
          ],
          color: Colors.white,
        ),
        child: LoadingButton(
          title: 'Lanjutkan',
          noMargin: true,
          onPressed: () {
            if (vm.currentWarehouse != null && vm.currentSupplier != null)
              Get.toNamed(addProductPurchase);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Dftr Beli',
        middle: Text(
          //'Tambah Penjualan',
          'Data Pembelian',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      child: Material(
        child: SafeArea(
          child: GetBuilder<PurchaseController>(
            init: PurchaseController(),
            builder: (vm) => _body(vm),
          ),
        ),
      ),
    );
  }
}