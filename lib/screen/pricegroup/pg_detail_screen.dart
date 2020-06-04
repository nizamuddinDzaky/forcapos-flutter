import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/custom_radio.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/pricegroup/pg_detail_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';

class PGDetailScreen extends StatefulWidget {
  @override
  _PGDetailScreenState createState() => _PGDetailScreenState();
}

class _PGDetailScreenState extends PGDetailViewModel {
  ExpandableController _controller;

  ExpandableController get controller => _controller;

  set controller(ExpandableController controller) {
    if (_controller == null) {
      _controller = controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'K. Harga',
        middle: Text(
          pg?.name ?? 'Detail Kel. Harga',
        ),
      ),
      child: SafeArea(
        child: ExpandableTheme(
          data: const ExpandableThemeData(
              iconColor: Colors.blue, useInkWell: true),
          child: listProductPG == null
              ? Center(child: CupertinoActivityIndicator())
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (c, i) => _listItem(listProductPG[i], i),
                  itemCount: listProductPG.length,
                ),
        ),
      ),
    );
  }

  Widget _listItem(Product product, int index) {
    final priceController = TextEditingController(
      text: MyNumber.toNumberIdStr(product?.price),
    );
    final creditPriceController = TextEditingController(
      text: MyNumber.toNumberIdStr(product?.priceKredit),
    );
    final minOrderController = TextEditingController(
      text: MyNumber.toNumberIdStr(product?.minOrder),
    );
    var isMultiple = product?.isMultiple ?? '0';
    return ExpandableNotifier(
      initialExpanded: index == 0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: false,
                  ),
                  header: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Text('PoS',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: Colors.white)),
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
                                product?.productName ?? '',
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text(
                                product?.productCode ?? '',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  expanded: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Harga'),
                                  TextFormField(
                                    controller: priceController,
                                    inputFormatters: [NumericTextFormatter()],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: false),
                                    decoration: new InputDecoration(
                                      prefixText: 'Rp ',
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Harga Penjualan',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.txtField,
                                    ),
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
                                  Text('Harga Kredit'),
                                  TextFormField(
                                    controller: creditPriceController,
                                    inputFormatters: [NumericTextFormatter()],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: false),
                                    decoration: new InputDecoration(
                                      prefixText: 'Rp ',
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Min Order'),
                                  TextFormField(
                                    controller: minOrderController,
                                    inputFormatters: [NumericTextFormatter()],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: false),
                                    decoration: new InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Pesanan Terkecil',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.txtField,
                                    ),
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
                                  Text('Multiple'),
                                  Container(
                                    padding: EdgeInsets.only(top: 2),
                                    child: CustomRadio(
                                      defaultValue: isMultiple,
                                      callback: (newValue) {
                                        isMultiple = newValue;
                                      },
                                      dataRadioGroup: [
                                        RadioModel(
                                          title: 'Ya',
                                          value: '1',
                                        ),
                                        RadioModel(
                                          title: 'Tidak',
                                          value: '0',
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Berlaku Kelipatan',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: MyColor.txtField,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        LoadingButton(
                          onPressed: () async {
                            var newProduct = product.copyWith(
                              price: MyNumber.strIDToDouble(priceController.text).toString(),
                              priceKredit: MyNumber.strIDToDouble(creditPriceController.text).toString(),
                              minOrder: MyNumber.strIDToDouble(minOrderController.text).toString(),
                              isMultiple: isMultiple,
                            );
                            await actionPutProductPrice(newProduct);
                          },
                          title: 'Simpan',
                          noMargin: true,
                        ),
                      ],
                    ),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
