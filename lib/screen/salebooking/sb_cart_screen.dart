import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/salebooking/sales_booking_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class SalesBookingCartScreen extends StatefulWidget {
  @override
  _SalesBookingCartScreenState createState() => _SalesBookingCartScreenState();
}

class _SalesBookingCartScreenState extends State<SalesBookingCartScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<FocusNode> listFocus;

  _showMenu(Product p, VoidCallback callback) {
    final action = CupertinoActionSheet(
      title: Column(
        children: <Widget>[
          Text(
            'Hapus Dari Keranjang',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Text('${p.name} ( ${p.code} )'),
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

  Widget _body(SalesBookingController vm) {
    return Form(
      key: formKey,
      child: Container(
        color: MyColor.mainBg,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (bc, idx) {
            var p = vm.cartList[idx];
            final qtyController = TextEditingController();
            lastCursorEditText(qtyController, p.minOrder.toDouble());
            return Card(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                                    style: Theme.of(Get.context)
                                        .textTheme
                                        .headline6,
                                  ),
                                  Text(p?.code ?? ''),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        p?.price?.toRp(),
                                        style: Theme.of(Get.context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: Row(
                                          children: <Widget>[
                                            //btnMinus
                                            CupertinoButton(
                                              onPressed: () {
                                                vm.qtyMinus(p);
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
                                                focusNode: listFocus[idx],
                                                onSaved: (newValue) {
                                                  if (!listFocus[idx]
                                                      .hasFocus) {
                                                    vm.qtyCustom(p, newValue);
                                                  }
                                                },
                                                onChanged: (newValue) {
                                                  vm.qtyEdit(
                                                      newValue, qtyController);
                                                },
                                                onFieldSubmitted: (newValue) {
                                                  vm.qtyCustom(p, newValue);
                                                },
                                                textAlign: TextAlign.center,
                                                style: Theme.of(Get.context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        color: MyColor.blueDio),
                                                inputFormatters: [
                                                  NumericTextFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
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
                                                vm.qtyPlus(p);
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
                                onPressed: () => _showMenu(p, () {
                                  vm.deleteFromCart(p);
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
                      onTap: () {
                        Get.toNamed(
                          salesBookingItemScreen,
                          arguments: {
                            'index': idx,
                          },
                        );
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Text(
                            'Ubah Data Item',
                            style: Theme.of(Get.context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (bc, idx) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
            );
          },
          itemCount: vm.cartList.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesBookingController>(
      init: SalesBookingController(),
      builder: (vm) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Pemesanan',
          middle: Text(
            'Keranjang',
            style: Theme.of(context).textTheme.headline6,
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

  @override
  void initState() {
    super.initState();
    SalesBookingController.to.cartList?.forEach((element) {
      if (listFocus == null) listFocus = [];
      var focusNode = FocusNode();
      listFocus.add(focusNode
        ..addListener(() {
          if (!focusNode.hasFocus) {
            print('unfocus ${focusNode.hasFocus}');
            formKey.currentState.save();
          }
        }));
    });
  }

  @override
  void dispose() {
    listFocus?.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}
