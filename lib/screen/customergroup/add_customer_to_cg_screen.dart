import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/screen/customergroup/customer_group_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class AddCustomerToCGScreen extends StatefulWidget {
  @override
  _AddCustomerToCGScreenState createState() => _AddCustomerToCGScreenState();
}

class _AddCustomerToCGScreenState extends State<AddCustomerToCGScreen> {
  bool isFirst = true;
  CustomerGroup cg;

  Widget _selectedCustomer(CustomerGroupController vm) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Anggota ${vm.cg?.name} : ${vm.selectedCustomer?.length ?? 0}',
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: vm.selectedCustomer?.length ?? 0,
              itemBuilder: (BuildContext context, int idx) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(0),
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          vm.removeCustomer(vm.selectedCustomer[idx]);
                        },
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: MyColor.blueDio,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Center(
                                    child: Text('PoS',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: MyColor.mainRed,
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                vm.selectedCustomer[idx].company ?? '',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listCustomer(CustomerGroupController vm) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Daftar Pelanggan',
                ),
                Row(
                  children: <Widget>[
                    LoadingButton(
                      title: 'Tandai Semua',
                      isActionNavigation: true,
                      noPadding: true,
                      noMargin: true,
                      onPressed: () {
                        vm.addAll();
                      },
                    ),
                    Text(' | '),
                    LoadingButton(
                      title: 'Hapus Semua',
                      isActionNavigation: true,
                      noPadding: true,
                      noMargin: true,
                      onPressed: () {
                        vm.removeAll();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (bCtx, idx) {
                return MyDivider.lineDivider();
              },
              itemCount: vm.listCustomer?.length ?? 0,
              itemBuilder: (bCtx, idx) {
                return Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () {
                      vm.selectOrRemove(vm.listCustomer[idx]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(8),
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: MyColor.blueDio,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Text('PoS',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.white)),
                                ),
                              ),
                              if (vm.listCustomer[idx].flag == '1')
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: MyColor.mainGreen,
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  vm.listCustomer[idx].company ?? '',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                if (vm.listCustomer[idx].company !=
                                    vm.listCustomer[idx].name)
                                  Text(
                                    vm.listCustomer[idx].name ?? '',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(CustomerGroupController vm) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectedCustomer(vm),
          MyDivider.lineDivider(),
          Expanded(
            child: _listCustomer(vm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Balik',
        middle: Text(
          'Tambah Ke Kel. Pelanggan',
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            init: CustomerGroupController(cg),
            builder: (vm) => _body(vm),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      if (arg == null) return;
      cg = CustomerGroup.fromJson(arg['customer_group']);
    }
  }
}
