import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/util/purchase_cons.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';
import 'edit_purchase_controller.dart';

class EditPurchaseScreen extends StatefulWidget {
  @override
  _EditPurChaseScreenState createState() => _EditPurChaseScreenState();
}

class _EditPurChaseScreenState extends State<EditPurchaseScreen> {
  bool isVisible = false, lastState = false;
  ScrollController _scrollController;

  Widget _header(EditPurchaseController vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //date
          Text(
            'Tanggal',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.date_range,
                  size: 16,
                  color: MyColor.blueDio,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CupertinoButton(
                    minSize: 0,
                    onPressed: () async {
                      var date = vm.cPurchase?.date?.toDateTime();
                      DateTime newDateTime = await showRoundedDatePicker(
                        context: context,
                        initialDate: date,
                        locale: Locale('in', 'ID'),
                        borderRadius: 16,
                      );
                      setState(() {
                        vm.cPurchase?.date = newDateTime?.toStr() ?? date?.toStr();
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${strToDate(vm.cPurchase?.date)}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
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
          //warehouse
          Text(
            'Gudang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Expanded(
                child: CupertinoButton(
                  minSize: 0,
                  onPressed: (vm.cWarehouse != null &&
                      vm.purchase.status == 'reserved') ? null : () async {
                    await vm.actionGetWarehouse();
                    vm.showWarehousePicker(context);
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(vm.cWarehouse?.name ?? 'Pilih Gudang',
                        style: TextStyle(fontSize: 16),),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
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
              'Pemasok',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
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
              Expanded(
                child: CupertinoButton(
                  minSize: 0,
                  onPressed: () async {
                    await vm.actionGetSupplier();
                    vm.showSupplierPicker(context);
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(vm.cSupplier?.name ?? 'Pilih Pelanggan',
                        style: TextStyle(fontSize: 16),),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
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
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
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
              ...statusPurchase
                  .where((element) => element[1] != 'returned')
                  .mapIndexed((data, index) {
                return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: MyColor.mainRed),
                  ),
                  onPressed: () {
                    setState(() {
                      vm.purchase?.status = data[1];
                      if(data[1] != 'pending'){
                        vm.isReceived = true;
                      }else{
                        vm.isReceived = false;
                      }
                    });
                  },
                  color: vm.cPurchase?.status == data[1]
                      ? MyColor.mainRed
                      : Colors.white,
                  child: Text(
                    data[0],
                    style: TextStyle(
                      color: vm.cPurchase?.status == data[1]
                          ? Colors.white
                          : MyColor.txtField,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(EditPurchaseController vm) {
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (bctx, index) {
                  var sbi = vm.cPurchaseItems[index];
                  return _listItem(vm, sbi);
                },
                separatorBuilder: (bctx, index) {
                  return MyDivider.lineDivider(thickness: 2);
                },
                itemCount: vm.cPurchaseItems?.length ?? 0,
              ),
              /*Center(
                child: LoadingButton(
                  title: 'TAMBAH (PRODUK) ITEM',
                  noMargin: true,
                  isActionNavigation: true,
                  onPressed: () async {
                    await vm.actionGetProduct();
                  },
                ),
              ),*/
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

  Widget _footer(EditPurchaseController vm) {
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
                  initialValue: vm.cPurchase?.orderDiscount?.toNumId() ?? '0',
                  onSaved: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
                  },
                  onChanged: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
                  },
                  onFieldSubmitted: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
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
                  initialValue: vm.cPurchase?.shipping?.toNumId() ?? '0',
                  onSaved: (val) {
                    vm.editPurchase(shipping: val.strDoubleID());
                  },
                  onChanged: (val) {
                    vm.editPurchase(shipping: val.strDoubleID());
                  },
                  onFieldSubmitted: (val) {
                    vm.editPurchase(shipping: val.strDoubleID());
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
                  initialValue: vm.cPurchase?.paymentTerm?.toNumId(),
                  onSaved: (value) {
                    vm.editPurchase(
                        paymentTerm: value.isEmpty
                            ? ''
                            : value?.tryIDtoDouble()?.toString());
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
            'No Nama Penerima',
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
                  initialValue: vm.cPurchase?.receiver,
                  onSaved: (val) {
                    vm.editPurchase(receiver: val);
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
                  initialValue: vm.cPurchase?.note,
                  onSaved: (val) {
                    vm.editPurchase(note: val);
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
          Text(
            'No DO',
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
                  initialValue: vm.cPurchase?.sinoDo,
                  onSaved: (val) {
                    vm.editPurchase(sinoDo: val);
                  },
                  decoration: new InputDecoration(
                    hintText: 'No DO',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'No SPJ',
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
                  initialValue: vm.cPurchase?.sinoSpj,
                  onSaved: (val) {
                    vm.editPurchase(sinoSpj: val);
                  },
                  decoration: new InputDecoration(
                    hintText: 'No SPJ',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'No Tagihan',
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
                  initialValue: vm.cPurchase?.sinoBilling,
                  onSaved: (val) {
                    vm.editPurchase(sinoDo: val);
                  },
                  decoration: new InputDecoration(
                    hintText: 'No Tagihan',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listItem(EditPurchaseController vm, PurchaseItems pi) {
    final qtyController = TextEditingController();
    final qtyReceivedController = TextEditingController();
    lastCursorEditText(qtyController, pi.quantity.toDouble());
    lastCursorEditText(qtyReceivedController, pi.quantityReceived.toDouble());
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
                              pi?.productName ?? '',
                              style: Theme.of(Get.context).textTheme.headline6,
                            ),
                            Text(pi?.productCode ?? ''),
                            Text(
                              pi?.netUnitCost?.toRp() ?? '',
                              style:
                              Theme.of(Get.context).textTheme.subtitle2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: <Widget>[
                                      //btnMinus
                                      CupertinoButton(
                                        onPressed: () {
                                          vm.qtyMinus(pi);
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
                                            if (newValue.isEmpty) return;
                                            vm.qtyCustom(pi, qtyStr: newValue);
                                          },
                                          onFieldSubmitted: (newValue) {
                                            vm.qtyCustom(pi, qtyStr: newValue);
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
                                          vm.qtyPlus(pi);
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
                                if(vm.isReceived)
                                Container(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: <Widget>[
                                      //btnMinus
                                      CupertinoButton(
                                        onPressed: () {
                                          vm.qtyMinusReceived(pi);
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
                                          controller: qtyReceivedController,
//                                          focusNode: listFocus[idx],
                                          onSaved: (newValue) {
//                                            if (!listFocus[idx]
//                                                .hasFocus) {
//                                              vm.qtyCustom(p, newValue);
//                                            }
                                          },
                                          onChanged: (newValue) {
                                            vm.qtyEditReceived(qtyReceivedController,
                                                qtyStr: newValue, pi: pi);
                                            if (newValue.isEmpty) return;
                                            vm.qtyCustomReceived(pi, qtyStr: newValue);
                                          },
                                          onFieldSubmitted: (newValue) {
                                            vm.qtyCustomReceived(pi, qtyStr: newValue);
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
                                          vm.qtyPlusReceived(pi);
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
                          onPressed: () => _showMenu(pi, () {
                            vm.deleteFromCart(pi);
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
                  await vm.toEditItem(pi);
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
                              vm.totalPurchaseItem(pi).toRp(),
                              style: Theme.of(Get.context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        /*Row(
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
                        ),*/
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

  _showMenu(PurchaseItems sbi, VoidCallback callback) {
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
    if(EditPurchaseController.to.cPurchase.status != "pending"){
      EditPurchaseController.to.isReceived = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPurchaseController>(
      init: EditPurchaseController(),
      builder: (vm) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Dt Pembelian',
            middle: Text(
              'Ubah Pembelian',
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: /*isVisible
                ? null
                :*/ LoadingButton(
              title: 'Simpan',
              isActionNavigation: true,
              noMargin: true,
              noPadding: true,
              onPressed: () async => {},
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