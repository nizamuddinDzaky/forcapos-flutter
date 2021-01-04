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
            height: 8,
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
            height: 8,
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
                child: LoadingButton(
                  title: vm.customer?.customerGroupName ?? 'Pilih Kelompok Pelanggan',
                  noMargin: true,
                  noPadding: true,
                  isActionNavigation: true,
                  isSpinner: true,
                  onPressed: () async {
                    await vm.actionGetCustomerGroup();
                    vm.showCustomerGroupPicker(context);
                  },
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
            height: 8,
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
                child: LoadingButton(
                  title: vm.customer?.priceGroupName ?? 'Pilih Kelompok Harga',
                  noMargin: true,
                  noPadding: true,
                  isActionNavigation: true,
                  isSpinner: true,
                  onPressed: () async {
                    await vm.actionGetPriceGroup();
                    vm.showPriceGroupPicker(context);
                  },
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
            height: 8,
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
            height: 8,
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
            height: 8,
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
            height: 8,
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
                child: LoadingButton(
                  title: vm.province?.txt ?? 'Pilih Provinsi',
                  noMargin: true,
                  noPadding: true,
                  isActionNavigation: true,
                  isSpinner: true,
                  onPressed: () async {
                    vm.callAddress(context, 'Provinsi', 'province');
                  },
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
            height: 8,
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
                child: LoadingButton(
                  title: vm.city?.txt ?? 'Pilih Kabupaten/Kota',
                  noMargin: true,
                  noPadding: true,
                  isActionNavigation: true,
                  isSpinner: true,
                  onPressed: () async {
                    vm.callAddress(context, 'Kab. Kota', 'city');
                  },
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
            height: 8,
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
                child: LoadingButton(
                  title: vm.state?.txt ?? 'Pilih Kecamatan',
                  noMargin: true,
                  noPadding: true,
                  isActionNavigation: true,
                  isSpinner: true,
                  onPressed: () async {
                    vm.callAddress(context, 'Kecamatan', 'state');
                  },
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
            height: 8,
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
            height: 8,
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
            height: 8,
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
                      onChanged: vm.isCheckDefaultWarehouse(warehouse)
                          ? null
                          : (bool value) {
                        vm.onChangeCheckBox(value, warehouse);
                      },
                      value: (vm.listWarehousesSelected ?? []).contains(warehouse),
                    ),
                    trailing: Radio(
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
