import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/salebooking/edit_sb_controller.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/sales_cons.dart';
import 'package:posku/util/widget/my_divider.dart';

class EditSalesBookingScreen extends StatefulWidget {
  @override
  _EditSalesBookingScreenState createState() => _EditSalesBookingScreenState();
}

class _EditSalesBookingScreenState extends State<EditSalesBookingScreen> {
  bool isVisible = false, lastState = false;
  ScrollController _scrollController;

  Widget _header() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
//                        initialDate: vm.currentDate,
//                        initialDate: vm.currentDate,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
//                      vm.setDate(newDateTime);
//                      setState(() {
//                        currentDate = newDateTime ?? currentDate;
//                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
//                    child: Text("${strToDate(vm.currentDate.toString())}"),
                    child: Text('Tanggal'),
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
////                      await actionGetWarehouse(vm);
//                      await vm.actionGetWarehouse();
//                      vm.showWarehousePicker(context);
////                      showWarehousePicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "vm.currentWarehouse?.name ?? 'Pilih Gudang'",
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
////                      await actionGetCustomer(vm);
//                      await vm.actionGetCustomer();
//                      vm.showCustomerPicker(context);
////                      showCustomerPicker();
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "vm.currentCustomer?.name ?? 'Pilih Pelanggan'",
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
            height: 4,
          ),
        ],
      ),
    );
  }

  Widget _footer(EditSBController vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Diskon
          Text(
            'Diskon',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                size: 16,
                color: MyColor.blueDio,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  //controller: deliveredController,
                  initialValue: vm.sales?.orderDiscount?.toNumId() ?? '0',
                  onChanged: (val) {
//                    var sale = val.toDoubleID().toString();
//                    vm.sales?.orderDiscount = sale;
//                    vm.refresh();
                  },
                  inputFormatters: [NumericTextFormatter()],
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: new InputDecoration(
                    prefixText: 'Rp ',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          //Biaya Pengiriman
          Text(
            'Biaya Pengiriman',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                size: 16,
                color: MyColor.blueDio,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  //controller: deliveredController,
                  initialValue: vm.sales?.shipping?.toNumId() ?? '0',
                  onChanged: (val) {
//                    var pay = val.toDoubleID().toString();
//                    vm.sales?.shipping = pay;
//                    vm.refresh();
                  },
                  inputFormatters: [NumericTextFormatter()],
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: new InputDecoration(
                    prefixText: 'Rp ',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          //status
          Text(
            'Status',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            padding: EdgeInsets.symmetric(vertical: 8),
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 16 / 3,
            children: <Widget>[
              ...statusSales.mapIndexed((data, index) {
                return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: MyColor.mainRed),
                  ),
                  onPressed: () {
                    setState(() {
//                      vm.sales?.saleStatus = data[1];
                    });
                  },
                  color: vm.sales?.saleStatus == data[1]
                      ? MyColor.mainRed
                      : Colors.white,
                  child: Text(
                    data[0],
                    style: TextStyle(
                      color: vm.sales?.saleStatus == data[1]
                          ? Colors.white
                          : MyColor.txtField,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          //Jangka Waktu Pembayaran
          Text(
            'Jangka Waktu Pembayaran',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                size: 16,
                color: MyColor.blueDio,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  //controller: deliveredController,
                  initialValue: vm.sales?.paymentTerm?.toNumId() ?? '0',
                  onSaved: (newValue) {
                    //p.code = newValue;
                  },
                  decoration: new InputDecoration(
                    suffixText: 'hari',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          //Catatan Pegawai
          Text(
            'Catatan Pegawai',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                size: 16,
                color: MyColor.blueDio,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  //controller: deliveredController,
                  initialValue: vm.sales?.staffNote,
                  onSaved: (newValue) {
                    //p.code = newValue;
                  },
                  decoration: new InputDecoration(
                    hintText: 'Tulis Catatan',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          //Catatan Penjualan
          Text(
            'Catatan Penjualan',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                size: 16,
                color: MyColor.blueDio,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  //controller: deliveredController,
                  initialValue: vm.sales?.note,
                  onSaved: (newValue) {
                    //p.code = newValue;
                  },
                  decoration: new InputDecoration(
                    hintText: 'Tulis Catatan',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _body(EditSBController vm) {
    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            _header(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Produk',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (bctx, index) {
                return _listItem(vm, Product());
              },
              separatorBuilder: (bctx, index) {
                return MyDivider.lineDivider(thickness: 2);
              },
              itemCount: 2,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Jumlah',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    0.0.toString().toRp(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {},
                child: Text('TAMBAH PRODUK'),
              ),
            ),
            _footer(vm),
            /*VisibilityDetector(
              key: Key("unique key"),
              onVisibilityChanged: (VisibilityInfo info) {
                isVisible = info.visibleFraction <= 0.7;
                debugPrint("${info.visibleFraction} of my widget is visible $isVisible");
                if (info.visibleFraction == 0.0 || info.visibleFraction > 0.7) {
                  setState(() {});
                }
              },
              child: Text('ok'),
            ),*/
            LoadingButton(
              title: 'Simpan Perubahan',
              noMargin: true,
              shrinkWrap: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItem(EditSBController vm, Product p) {
    final qtyController = TextEditingController();
    lastCursorEditText(qtyController, p.minOrder.toDouble());
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: MyColor.blueDio,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(
                        child: Text(
                          'PPC',
                          style: Theme.of(Get.context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              p?.name ?? '',
                              style: Theme.of(Get.context).textTheme.headline6,
                            ),
                            Text(p?.code ?? ''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  p?.price?.toRp() ?? '',
                                  style:
                                      Theme.of(Get.context).textTheme.subtitle2,
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: <Widget>[
                                      //btnMinus
                                      CupertinoButton(
                                        onPressed: () {
//                                          vm.qtyMinus(p);
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: MyColor.mainRed,
                                        ),
                                        minSize: 0,
                                        padding: EdgeInsets.all(0),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      //labelQty
                                      Container(
                                        width: 50,
                                        child: TextFormField(
                                          controller: qtyController,
//                                          focusNode: listFocus[idx],
                                          onSaved: (newValue) {
//                                            if (!listFocus[idx]
//                                                .hasFocus) {
//                                              vm.qtyCustom(p, newValue);
//                                            }
                                          },
                                          onChanged: (newValue) {
//                                            vm.qtyEdit(
//                                                newValue, qtyController);
                                          },
                                          onFieldSubmitted: (newValue) {
//                                            vm.qtyCustom(p, newValue);
                                          },
                                          textAlign: TextAlign.center,
                                          style: Theme.of(Get.context)
                                              .textTheme
                                              .headline6
                                              .copyWith(color: MyColor.blueDio),
                                          inputFormatters: [
                                            NumericTextFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: false),
                                          decoration: new InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      //btnPlus
                                      CupertinoButton(
                                        onPressed: () {
//                                          vm.qtyPlus(p);
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: MyColor.mainGreen,
                                        ),
                                        minSize: 0,
                                        padding: EdgeInsets.all(0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CupertinoButton(
                          minSize: 0,
                          padding: EdgeInsets.all(0),
//                          onPressed: () => _showMenu(p, () {
//                            vm.deleteFromCart(p);
//                          }),
                          onPressed: () {},
                          child: Icon(Icons.delete_forever),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyDivider.lineDivider(top: 8),
              InkWell(
                onTap: () {
//                  Get.toNamed(
//                    salesBookingItemScreen,
//                    arguments: {
//                      'index': idx,
//                    },
//                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Sub Total',
                            ),
                            Text(
                              '0.0'.toRp(),
                              style: Theme.of(Get.context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Ubah',
                              style: Theme.of(Get.context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.blueDio),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '(Diskon, dll)',
                              style: Theme.of(Get.context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _actionOnScroll() {
    var max = _scrollController.position.maxScrollExtent - 24;
    isVisible = _scrollController.offset > max;
    if (_scrollController.offset > max && isVisible != lastState) {
      lastState = isVisible;
      setState(() {});
    } else if (_scrollController.offset <= max && isVisible != lastState) {
      lastState = isVisible;
      setState(() {});
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_actionOnScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditSBController>(
      init: EditSBController(),
      builder: (vm) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Dt Penjualan',
            middle: Text(
              'Ubah Penjualan',
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: isVisible
                ? null
                : CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {},
                    child: Text('Simpan'),
                  ),
          ),
          child: Material(
            child: SafeArea(
              child: _body(vm),
            ),
          ),
        );
      },
    );
  }
}
