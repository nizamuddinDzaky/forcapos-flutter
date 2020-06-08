import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/salebooking/sb_order_controller.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class SalesBookingOrderScreen extends StatefulWidget {
  @override
  _SalesBookingOrderScreenState createState() =>
      _SalesBookingOrderScreenState();
}

class _SalesBookingOrderScreenState extends State<SalesBookingOrderScreen> {
  Widget _body(SBOrderController vm) {
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
                                    vm.currentCustomer?.name ?? 'Pilih Pelanggan',
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
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.white,
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
                      MyNumber.toNumberRp(0.0),
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
    return GetBuilder<SBOrderController>(
      init: SBOrderController(),
      builder: (vm) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Kembali',
          middle: Text(
            'Pemesanan',
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.all(0),
            onPressed: () {
              vm.addProduct();
//              setState(() {
//                cartList.add(Product());
//              });
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: (vm.cartList.length > 0)
                        ? EdgeInsets.only(
                            right: 8,
                          )
                        : null,
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  if (vm.cartList.length > 0)
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
}
