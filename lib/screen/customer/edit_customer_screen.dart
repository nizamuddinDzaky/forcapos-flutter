import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/screen/customer/customer_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class EditCustomerScreen extends StatefulWidget {
  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  Customer customer;
  bool isFirst = true;

  Widget _body(CustomerController vm) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //company name
          Text(
            'Nama Perusahaan',
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
            style: Theme.of(Get.context).textTheme.subtitle2,
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
            style: Theme.of(Get.context).textTheme.subtitle2,
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
            style: Theme.of(Get.context).textTheme.subtitle2,
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
            style: Theme.of(Get.context).textTheme.subtitle2,
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
            style: Theme.of(Get.context).textTheme.subtitle2,
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
          //
          Text(
            'Status',
            style: Theme.of(Get.context).textTheme.subtitle2,
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
                    side: BorderSide(color: MyColor.mainRed),
                  ),
                  onPressed: () {
                    setState(() {
                      vm.isActive = data[1];
                    });
                  },
                  color: vm.isActive == data[1]
                      ? MyColor.mainRed
                      : Colors.white,
                  child: Text(
                    data[0],
                    style: TextStyle(
                      color: vm.isActive == data[1]
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
          LoadingButton(
            title: 'Simpan',
            noMargin: true,
            onPressed: () async {
              await vm.actionSubmit();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Dt Pelanggan',
        middle: Text(
          'Ubah Pelanggan',
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
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<CustomerController>(
            init: CustomerController(customer: customer),
            builder: (vm) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Form(key: vm.formKey, child: _body(vm))),
          ),
        ),
      ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      var customer = getArg('customer');
      if (customer != null) this.customer = Customer.fromJson(customer);
      isFirst = false;
    }
  }
}
