import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/salebooking/sales_booking_controller.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class SalesBookingOrderScreen extends StatefulWidget {
  @override
  _SalesBookingOrderScreenState createState() =>
      _SalesBookingOrderScreenState();
}

class _SalesBookingOrderScreenState extends State<SalesBookingOrderScreen> {
  final searchController = TextEditingController();
  double tempQty;
  bool isDelete;

  lastCursorQty(TextEditingController qtyController, double newQty) {
    var newValue = MyNumber.toNumberId(newQty);
    qtyController.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.length),
      ),
    );
  }

  Widget _bottomSheetQty(SalesBookingController vm, Product p, {title}) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      final qtyController = TextEditingController();
      lastCursorQty(qtyController, tempQty);
      return Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(14.0),
                topRight: const Radius.circular(14.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CupertinoButton(
                  onPressed: () => Get.back(),
                  child: Text('Batal'),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 48,
                  child: Text(
                    title ?? 'Masukkan Jumlah',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: LoadingButton(
                    onPressed: () async {
                      vm.addToCart(p, customQty: tempQty);
                      Get.back();
                    },
                    title: 'Selesai',
                    noMargin: true,
                    isActionNavigation: true,
                  ),
                ),
              ],
            ),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: MyColor.blueDio,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Text('PPC',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(p?.name ?? ''),
            Text(p?.code ?? ''),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Harga',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: MyColor.txtField)),
                      Text(p.price.toRp(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: MyColor.txtField)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Jumlah Pesan',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: MyColor.txtField)),
                      Container(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: <Widget>[
                            //btnMinus
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  tempQty -= 1.0;
                                  if (tempQty < 1) tempQty = 1;
                                });
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
                              width: 75,
                              child: TextFormField(
                                controller: qtyController,
                                onChanged: (newValue) {
                                  if (newValue.isEmpty) return;
                                  tempQty = newValue.toDoubleID();
                                  if (tempQty < 1) {
                                    tempQty = 1;
                                    lastCursorQty(qtyController, tempQty);
                                  }
                                },
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: MyColor.blueDio),
                                inputFormatters: [NumericTextFormatter()],
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false),
                                decoration: new InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
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
                                setState(() {
                                  tempQty += 1.0;
                                  print('cek $tempQty');
                                });
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
            if (p.minOrder != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: p.minOrder != null && isDelete,
                    onChanged: (status) {
                      setState(() {
                        isDelete = p.minOrder != null && status;
                      });
                    },
                  ),
                  RaisedButton(
                    onPressed: !isDelete
                        ? null
                        : () {
                            vm.deleteFromCart(p);
                          },
                    color: MyColor.mainRed,
                    child: Text(
                      'Hapus dari keranjang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _layoutProduct(SalesBookingController vm) {
    var listProducts = vm.getListProducts();
    if (listProducts == null)
      return Center(child: CupertinoActivityIndicator());

    if (listProducts.length == 0) return Center(child: Text('Produk Kosong'));

    return ListView.separated(
      itemBuilder: (bc, idx) {
        var p = listProducts[idx];
        return Card(
          margin: EdgeInsets.all(0),
          elevation: 0,
          child: InkWell(
            onTap: () async {
              isDelete = false;
              tempQty = p.minOrder.toDouble();
              if (tempQty == 0) tempQty = 1.0;
              await showModalBottomSheet<String>(
                  context: context,
                  isDismissible: false,
                  isScrollControlled: true,
                  builder: (builder) {
                    return _bottomSheetQty(vm, p);
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      child: Text('PPC',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          p.name ?? '',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(p.code ?? ''),
                        Row(
                          children: <Widget>[
                            Text(p.price?.toRp() ?? ''),
                            if (p.unitName != null)
                              SizedBox(
                                width: 8,
                              ),
                            if (p.unitName != null) Text(p.unitName ?? ''),
                            if (p.minOrder != null) Text(' x '),
                            if (p.minOrder != null) Text(p.minOrder.toNumId()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (bc, idx) {
        return MyDivider.lineDivider();
      },
      itemCount: listProducts.length,
    );
  }

  Widget _body(SalesBookingController vm) {
    return Container(
      color: MyColor.mainBg,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_drive_file,
                      size: 16,
                      color: MyColor.blueDio,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Data Pemesanan',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: MyColor.txtField),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                              Flexible(
                                child: CupertinoButton(
                                  minSize: 0,
                                  onPressed: () async {
                                    vm.showWarehousePicker(context);
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    vm.currentWarehouse?.name ?? 'Pilih Gudang',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                              Flexible(
                                child: CupertinoButton(
                                  minSize: 0,
                                  onPressed: () async {
                                    vm.showCustomerPicker(context);
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    vm.currentCustomer?.name ??
                                        'Pilih Pelanggan',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: TextFormField(
              controller: searchController,
              onChanged: (txtSearch) async {
                await vm.actionSearch(txtSearch);
              },
              decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 24,
                ),
                hintText: 'Cari atas produk/kode',
//                suffixIcon: vm.listSearch == null
                suffixIcon: searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          searchController.clear();
                          FocusScope.of(context).requestFocus(new FocusNode());
                          vm.cancelSearch();
                        },
                        icon: Icon(Icons.clear),
                      ),
              ),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              color: Colors.white,
              child: _layoutProduct(vm),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Jumlah',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: MyColor.txtField),
                    ),
                    Text(
                      //MyNumber.toNumberRp(0.0),
                      vm.getTotal(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: MyColor.txtField),
                    ),
                  ],
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesBookingController>(
      init: SalesBookingController(),
      builder: (vm) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Dt Pemesanan',
          middle: Text(
            'Pemesanan',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.all(0),
            onPressed: () {
              if ((vm.cartList?.length ?? 0) > 0)
                Get.toNamed(salesBookingCartScreen);
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: (vm.cartList?.length != null)
                        ? EdgeInsets.only(
                            right: 8,
                          )
                        : null,
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  if ((vm.cartList?.length ?? 0) > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          vm.cartList.length.toMax(symbol: '!!'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        child: Material(
          child: SafeArea(
            child: _body(vm),
          ),
        ),
      ),
    );
  }
}

extension IntExtension on int {
  String toMax({int max = 99, String symbol}) {
    return this > max
        ? (symbol == null ? max.toString() : symbol)
        : this.toString();
  }

  bool isNull() {
    return this == null;
  }
}
