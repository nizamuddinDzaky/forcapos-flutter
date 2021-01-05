import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/customer/customer_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  List<String> addCustomerTabs = ["Pelanggan", "Gudang"];

  Widget _body(CustomerController vm) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //company name
          Text(
            'Nama Perusahaan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.company,
                  onSaved: (val) {
                    vm.saveForm(company: val);
                  },
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //owner name
          Text(
            'Nama Pemilik',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.name,
                  onSaved: (val) {
                    vm.saveForm(name: val);
                  },
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //
          Text(
            'Kelompok Pelanggan',
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
                  onPressed: () async {
                    await vm.actionGetCustomerGroup();
                    vm.showCustomerGroupPicker(context);
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        vm.customer?.customerGroupName ??
                            'Pilih Kelompok Pelanggan',
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
          MyDivider.lineDivider(
            customColor: MyColor.txtBlack,
            left: 24,
            thickness: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Kelompok Harga',
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
                  onPressed: () async {
                    await vm.actionGetPriceGroup();
                    vm.showPriceGroupPicker(context);
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        vm.customer?.priceGroupName ?? 'Pilih Kelompok Harga',
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
          MyDivider.lineDivider(
            customColor: MyColor.txtBlack,
            left: 24,
            thickness: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Email',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.email,
                  onSaved: (val) {
                    vm.saveForm(email: val);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //
          Text(
            'Telp',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.phone,
                  onSaved: (val) {
                    vm.saveForm(phone: val);
                  },
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //
          Text(
            'Alamat',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.address,
                  onSaved: (val) {
                    vm.saveForm(address: val);
                  },
                  maxLines: 2,
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //
          Text(
            'Provinsi',
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
                  onPressed: () async {
                    vm.callAddress(context, 'Provinsi', 'province');
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        vm.province?.txt ?? 'Pilih Provinsi',
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
          MyDivider.lineDivider(
            customColor: MyColor.txtBlack,
            left: 24,
            thickness: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Kabupaten',
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
                  onPressed: () async {
                    vm.callAddress(context, 'Kab. Kota', 'city');
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        vm.city?.txt ?? 'Pilih Kabupaten/Kota',
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
          MyDivider.lineDivider(
            customColor: MyColor.txtBlack,
            left: 24,
            thickness: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Kecamatan',
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
                  onPressed: () async {
                    vm.callAddress(context, 'Kecamatan', 'state');
                  },
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        vm.state?.txt ?? 'Pilih Kecamatan',
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
          MyDivider.lineDivider(
            customColor: MyColor.txtBlack,
            left: 24,
            thickness: 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          //
          Text(
            'Kode Pos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.postalCode,
                  onSaved: (val) {
                    vm.saveForm(postalCode: val);
                  },
                  decoration: new InputDecoration(
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
            height: 15,
          ),
          //
          Text(
            'NPWP',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.vatNo,
                  onSaved: (val) {
                    vm.saveForm(vatNo: val);
                  },
                  decoration: new InputDecoration(
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
            height: 15,
          ),
/*
          //
          Text(
            'ID Bisnis Kokoh',
            style: Theme.of(Get.context).textTheme.subtitle2,
          ),
          Row(
            children: <Widget>[
              Container(
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
                  initialValue: vm.customer?.cf1,
                  onSaved: (val) {
                    vm.saveForm(cf1: val);
                  },
                  decoration: new InputDecoration(
                    hintText: 'IDC-',
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
*/
          //
          Text(
            'Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              ...vm.statusCustomer.mapIndexed((data, index) {
                return RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  onPressed: () {
                    setState(() {
                      vm.checkCustomer?.isActive = data[1];
                    });
                  },
                  color: vm.customer?.isActive == data[1]
                      ? Colors.blue
                      : Color(0xffededed),
                  child: Text(
                    data[0],
                    style: TextStyle(
                      color: vm.customer?.isActive == data[1]
                          ? Colors.white
                          : MyColor.txtField,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _layoutWarehouse(CustomerController vm) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Info Gudang',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Pelanggan dapat terdaftar lebih dari 1 gudang',
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  var warehouse = vm.listWarehouses[index];
                  return ListTile(
                    title: Text("${warehouse?.name ?? ''}"),
                    leading: Checkbox(
                      activeColor: MyColor.blueDio,
                      onChanged: vm.isCheckDefaultWarehouse(warehouse)
                          ? null
                          : (bool value) {
                        vm.onChangeCheckBox(value, warehouse);
                      },
                      value: (vm.listWarehousesSelected ?? []).contains(warehouse),
                    ),
                    trailing: Radio(
                      activeColor: Color(0xff1CA865),
                      value: warehouse.id,
                      groupValue: vm.defaultWarehouse?.id,
                      onChanged: (value) {
                        vm.onChangeRadio(warehouse);
                      },
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider();
                },
                itemCount: vm.listWarehouses?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Dft Pelanggan',
        middle: Text(
          'Tambah Pelanggan',
        ),
/*
        trailing: LoadingButton(
          title: 'Simpan',
          isActionNavigation: true,
          noMargin: true,
          noPadding: true,
          onPressed: () async {
            await CustomerController.to.actionSubmit();
          },
        ),
*/
      ),
      child: GetBuilder<CustomerController>(
        init: CustomerController(),
        builder: (vm) => SafeArea(
          child: Material(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4.0,
                            offset: Offset(0.0, 0.75))
                      ],
                      color: Colors.white,
                    ),
                    child: TabBar(
                      indicatorColor: Color(0xff004C97),
                      labelColor: Color(0xff515151),
                      labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                      tabs: [
                        Tab(text: "Pelanggan"),
                        Tab(text: "Gudang"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(top: 8),
                      color: Colors.white,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Form(key: vm.formKey, child: _body(vm))),
                          _layoutWarehouse(vm),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4.0,
                            offset: Offset(0.0, 0.75)
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: LoadingButton(
                      title: 'Simpan',
                      noMargin: true,
                      onPressed: () async {
                        await vm.actionSubmit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
