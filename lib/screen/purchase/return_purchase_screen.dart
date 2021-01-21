import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';
import 'edit_purchase_controller.dart';

class ReturnPurchaseScreen extends StatefulWidget {
  @override
  _ReturnPurChaseScreenState createState() => _ReturnPurChaseScreenState();
}


class _ReturnPurChaseScreenState extends State<ReturnPurchaseScreen> {
  ScrollController _scrollController;
  bool isVisible = false, lastState = false;

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
          Text(
            'Nomor Referensi',
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
                  initialValue: vm.cPurchase?.referenceNo,
                  /*onSaved: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
                  },
                  onChanged: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
                  },
                  onFieldSubmitted: (val) {
                    vm.editPurchase(orderDiscount: val.strDoubleID());
                  },*/
                  readOnly: true,
                  inputFormatters: [NumericTextFormatter()],
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  /*decoration: new InputDecoration(
                    prefixText: 'Rp ',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),*/
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

  Widget _listItem(EditPurchaseController vm, PurchaseItems pi) {
    final qtyReturnController = TextEditingController();
    lastCursorEditText(qtyReturnController, pi.quantityReturn.toDouble());
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
                            /*Text(pi?.productCode ?? ''),*/
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    pi?.productCode ?? '',
                                    style:
                                    Theme.of(Get.context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    "Jumlah : ${MyNumber.toNumberIdStr(pi.quantity)}",
                                    style:
                                    Theme.of(Get.context).textTheme.subtitle2,
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    pi?.netUnitCost?.toRp() ?? '',
                                    style:
                                    Theme.of(Get.context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Diterima : ${MyNumber.toNumberIdStr(pi.quantityReceived)}',
                                    style:
                                    Theme.of(Get.context).textTheme.subtitle2,
                                  ),
                                ]
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
                          onPressed: () => {}/*_showMenu(pi, () {
                            vm.deleteFromCart(pi);
                          })*/,
                          child: Icon(Icons.delete_forever),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyDivider.lineDivider(top: 8),
              Row(
                /*padding: EdgeInsets.symmetric(horizontal: 16),*/
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.only(bottom: 4, left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        //btnMinus
                        CupertinoButton(
                          onPressed: () {
                            vm.qtyMinusReturned(pi);
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
                            controller: qtyReturnController,
//                                          focusNode: listFocus[idx],
                            onSaved: (newValue) {
                                           /*if (!listFocus[idx]
                                               .hasFocus) {
                                             vm.qtyCustomReturned(p, newValue);
                                           }*/
                            },
                            onChanged: (newValue) {
                              vm.qtyEditReturned(qtyReturnController,
                                  qtyStr: newValue);
                              if (newValue.isEmpty) return;
                              vm.qtyCustomReturned(pi, qtyStr: newValue);
                            },
                            onFieldSubmitted: (newValue) {
                              vm.qtyCustomReturned(pi, qtyStr: newValue);
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
                            vm.qtyPlusReturned(pi);
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
              /*_footer(vm),*/
              LoadingButton(
                title: 'Simpan Perubahan',
                noMargin: true,
                shrinkWrap: true,
                onPressed: () async => await vm.actionSubmitReturn(),
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
              'Pembelian Kembali',
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