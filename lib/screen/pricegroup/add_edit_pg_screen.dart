import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/screen/pricegroup/price_group_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddEditPGScreen extends StatefulWidget {
  @override
  _AddEditPGScreenState createState() => _AddEditPGScreenState();
}

class _AddEditPGScreenState extends State<AddEditPGScreen> {
  PriceGroup oldPG;
  bool isFirst = true;

  Widget _body(PriceGroupController vm) {
    return Form(
      key: vm.formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Price Group Name
            Text(
              'Nama Kelompok',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Icon(
                    Icons.description,
                    size: 16,
                    color: MyColor.blueDio,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: vm.priceGroup?.name,
                    onSaved: (val) {
                      vm.saveForm(name: val);
                    },
                    maxLength: 30,
                    decoration: new InputDecoration(
                      helperText: 'Maksimal 30 Karakter',
                      helperStyle: Theme.of(Get.context)
                          .textTheme
                          .caption
                          .copyWith(fontStyle: FontStyle.italic),
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
                  Expanded(
                    child: CupertinoButton(
                      minSize: 0,
                      onPressed: () async {
                        await vm.actionGetWarehouse();
                        vm.showWarehousePicker(context);
                      },
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            vm.warehouse?.name ?? 'Pilih Gudang',
                            style: TextStyle(fontSize: 16),
    //                      style: TextStyle(
    //                        color: currentWarehouse == null ? null : Colors.black,
    //                      ),
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
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PriceGroupController>(
      init: PriceGroupController(oldPG),
      builder: (vm) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text(
            '${vm.isEdit ? 'Ubah' : 'Tambah'} Kel. Harga',
          ),
        ),
        child: Scaffold(
          body: SafeArea(
            child: _body(vm),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 4.0,
                    offset: Offset(0.0, 0.75))
              ],
              color: Colors.white,
            ),
            child: LoadingButton(
              title: 'Simpan',
              noMargin: true,
              onPressed: () async {
                await vm.actionSubmitAdd();
              },
            ),
          )
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      var pg = getArg('price_group');
      if (pg != null) oldPG = PriceGroup.fromJson(pg);
      isFirst = false;
    }
  }
}
