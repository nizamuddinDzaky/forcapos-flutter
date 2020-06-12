import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/screen/salebooking/edit_sb_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class EditSBProductScreen extends StatefulWidget {
  @override
  _EditSBProductScreenState createState() => _EditSBProductScreenState();
}

class _EditSBProductScreenState extends State<EditSBProductScreen> {
  final searchController = TextEditingController();

  Widget _body(EditSBController vm) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
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
            child: _layoutProduct(vm),
          ),
        ],
      ),
    );
  }

  Widget _layoutProduct(EditSBController vm) {
    var listProducts = vm.getListProducts();
    if (listProducts == null)
      return Center(child: CupertinoActivityIndicator());

    if (listProducts.length == 0) return Center(child: Text('Produk Kosong'));

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (bc, idx) {
        var p = listProducts[idx];
        return Card(
          margin: EdgeInsets.all(0),
          elevation: 0,
          child: InkWell(
            onTap: () async {
              vm.addProduct(p);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: IntrinsicHeight(
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
                    Expanded(
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
                              if (p.minOrder != null)
                                Text(p.minOrder.toNumId()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Icon(
                        vm.checkItemIsExist(p)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (bc, idx) {
        return MyDivider.lineDivider(thickness: 1);
      },
      itemCount: listProducts.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditSBController>(
      init: EditSBController(),
      builder: (vm) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Kembali',
            middle: Text(
              'Tambah Item',
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.all(0.0),
              onPressed: null,
              child: Text('${vm.salesItem?.length ?? 0} Item'),
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
