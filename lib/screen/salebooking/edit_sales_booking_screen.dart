import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/sales_booking_item.dart';
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

  Widget _header(EditSBController vm) {
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
                      var date = vm.cSales?.date?.toDateTime();
                      DateTime newDateTime = await showRoundedDatePicker(
                        context: context,
                        initialDate: date,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
                      setState(() {
                        vm.cSales?.date = newDateTime?.toStr() ?? date?.toStr();
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("${strToDate(vm.cSales?.date)}"),
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
                  LoadingButton(
                    title: vm.cWarehouse?.name ?? 'Pilih Gudang',
                    noMargin: true,
                    noPadding: true,
                    isActionNavigation: true,
                    onPressed: () async {
                      await vm.actionGetWarehouse();
                      vm.showWarehousePicker(context);
                    },
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
                  LoadingButton(
                    title: vm.cCustomer?.name ?? 'Pilih Pelanggan',
                    noMargin: true,
                    noPadding: true,
                    isActionNavigation: true,
                    onPressed: () async {
                      await vm.actionGetCustomer();
                      vm.showCustomerPicker(context);
                    },
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
                  initialValue: vm.cSales?.orderDiscount?.toNumId() ?? '0',
                  onSaved: (val) {
                    vm.editSales(orderDiscount: val.strDoubleID());
                  },
                  onChanged: (val) {
                    vm.editSales(orderDiscount: val.strDoubleID());
                  },
                  onFieldSubmitted: (val) {
                    vm.editSales(orderDiscount: val.strDoubleID());
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
                  initialValue: vm.cSales?.shipping?.toNumId() ?? '0',
                  onSaved: (val) {
                    vm.editSales(shipping: val.strDoubleID());
                  },
                  onChanged: (val) {
                    vm.editSales(shipping: val.strDoubleID());
                  },
                  onFieldSubmitted: (val) {
                    vm.editSales(shipping: val.strDoubleID());
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
              ...statusSales
                  .where((element) => element[1] != 'close')
                  .mapIndexed((data, index) {
                return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: MyColor.mainRed),
                  ),
                  onPressed: () {
                    setState(() {
                      vm.sales?.saleStatus = data[1];
                    });
                  },
                  color: vm.cSales?.saleStatus == data[1]
                      ? MyColor.mainRed
                      : Colors.white,
                  child: Text(
                    data[0],
                    style: TextStyle(
                      color: vm.cSales?.saleStatus == data[1]
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
                  initialValue: vm.cSales?.paymentTerm?.toNumId(),
                  onSaved: (val) {
                    vm.editSales(paymentTerm: val.strDoubleID());
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
                  initialValue: vm.cSales?.staffNote,
                  onSaved: (val) {
                    vm.editSales(staffNote: val);
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
                  initialValue: vm.cSales?.note,
                  onSaved: (val) {
                    vm.editSales(note: val);
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
        child: Form(
          key: vm.formKey,
          child: Column(
            children: <Widget>[
              _header(vm),
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
                  var sbi = vm.cSalesItem[index];
                  return _listItem(vm, sbi);
                },
                separatorBuilder: (bctx, index) {
                  return MyDivider.lineDivider(thickness: 2);
                },
                itemCount: vm.cSalesItem?.length ?? 0,
              ),
              Center(
                child: LoadingButton(
                  title: 'TAMBAH (PRODUK) ITEM',
                  noMargin: true,
                  isActionNavigation: true,
                  onPressed: () async {
                    await vm.actionGetProduct();
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Jumlah',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      vm.grandTotal().toRp(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              _footer(vm),
              LoadingButton(
                title: 'Simpan Perubahan',
                noMargin: true,
                shrinkWrap: true,
                onPressed: () async => await vm.actionSubmit(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(EditSBController vm, SalesBookingItem sbi) {
    final qtyController = TextEditingController();
    lastCursorEditText(qtyController, sbi.quantity.toDouble());
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
                              sbi?.productName ?? '',
                              style: Theme.of(Get.context).textTheme.headline6,
                            ),
                            Text(sbi?.productCode ?? ''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  sbi?.netUnitPrice?.toRp() ?? '',
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
                                          vm.qtyMinus(sbi);
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
                                            vm.qtyEdit(qtyController,
                                                qtyStr: newValue);
                                          },
                                          onFieldSubmitted: (newValue) {
                                            vm.qtyCustom(sbi, qtyStr: newValue);
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
                                          vm.qtyPlus(sbi);
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
                          onPressed: () => _showMenu(sbi, () {
                            vm.deleteFromCart(sbi);
                          }),
                          child: Icon(Icons.delete_forever),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyDivider.lineDivider(top: 8),
              InkWell(
                onTap: () async {
                  await vm.toEditItem(sbi);
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
                              vm.totalSaleBookingItem(sbi).toRp(),
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

  _showMenu(SalesBookingItem sbi, VoidCallback callback) {
    final action = CupertinoActionSheet(
      title: Column(
        children: <Widget>[
          Text(
            'Hapus Dari Keranjang',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Text('${sbi.productName} ( ${sbi.productCode} )'),
        ],
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Ya, Hapus!"),
          onPressed: () {
            if (callback != null)
              callback();
            else
              Get.back();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Batal"),
        onPressed: () {
          Get.back();
        },
      ),
    );

    showCupertinoModalPopup(
      context: context,
      builder: (context) => action,
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
                : LoadingButton(
                    title: 'Simpan',
                    isActionNavigation: true,
                    noMargin: true,
                    noPadding: true,
                    onPressed: () async => await vm.actionSubmit(),
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
