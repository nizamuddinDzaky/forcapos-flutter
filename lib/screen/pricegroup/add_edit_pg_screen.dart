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
              style: Theme.of(Get.context).textTheme.subtitle2,
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
                      title: vm.warehouse?.name ?? 'Pilih Gudang',
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
              height: 24,
            ),
            LoadingButton(
              title: 'Simpan',
              noMargin: true,
              onPressed: () async {
                await vm.actionSubmitAdd();
              },
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
