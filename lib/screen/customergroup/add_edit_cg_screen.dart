import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/NumericTextFormater.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/screen/customergroup/cg_add_edit_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/my_util.dart';

class AddEditCGScreen extends StatefulWidget {
  @override
  _AddEditCGScreenState createState() => _AddEditCGScreenState();
}

class _AddEditCGScreenState extends State<AddEditCGScreen> {
  CustomerGroup oldCG;
  bool isFirst = true;

  Widget _body(CGAddEditController vm) {
    return Form(
      key: vm.formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Customer Group Name
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
                    initialValue: vm.customerGroup?.name,
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
            //Group Percentage
            Text(
              'Persenan Kelompok',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    initialValue: vm.customerGroup?.percent?.toNumId() ?? '0',
                    onSaved: (val) {
                      vm.saveForm(percent: val.trim());
                    },
                    inputFormatters: [NumericTextFormatter()],
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
                    decoration: new InputDecoration(
                      suffixText: ' %',
                      helperText: 'Tanpa tanda persen',
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
            //Credit Limit
            Text(
              'Limit Kredit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
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
                    initialValue:
                        vm.customerGroup?.kreditLimit?.toNumId() ?? '0',
                    onSaved: (val) {
                      vm.saveForm(limit: val.trim());
                    },
                    inputFormatters: [NumericTextFormatter()],
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
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
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CGAddEditController>(
      init: CGAddEditController(oldCG),
      builder: (vm) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text(
            '${vm.isEdit ? 'Ubah' : 'Tambah'} Kel. Pelanggan',
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
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      var cg = getArg('customer_group');
      if (cg != null) oldCG = CustomerGroup.fromJson(cg);
      isFirst = false;
    }
  }
}
