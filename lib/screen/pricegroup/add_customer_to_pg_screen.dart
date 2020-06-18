import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/screen/pricegroup/add_customer_pg_controller.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';
import 'package:posku/util/my_util.dart';

class AddCustomerToPGScreen extends StatefulWidget {
  @override
  _AddCustomerToPGScreenState createState() => _AddCustomerToPGScreenState();
}

class _AddCustomerToPGScreenState extends State<AddCustomerToPGScreen> {
  bool isFirst = true;
  PriceGroup pg;
  final searchController = TextEditingController();

  Widget _selectedCustomer(AddCustomerPGController vm) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Anggota ${vm.pg?.name} : ${vm.selectedCustomer?.length ?? 0}',
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: vm.selectedCustomers?.length ?? 0,
              itemBuilder: (BuildContext context, int idx) => Container(
                foregroundDecoration: vm.selectedCustomers[idx] == null
                    ? BoxDecoration(color: Colors.white.withOpacity(0.85))
                    : null,
                width: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 0,
                        color: vm.selectedCustomers[idx] == null
                            ? Colors.transparent
                            : Colors.white,
                        child: InkWell(
                          onTap: vm.selectedCustomers[idx] == null
                              ? null
                              : () {
                                  vm.removeCustomer(vm.selectedCustomers[idx]);
                                  vm.refresh();
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
                                      child: Text(
                                          vm.selectedCustomers[idx]?.company
                                                  ?.toAlias() ??
                                              '##',
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                                  vm.selectedCustomers[idx]?.company ?? '###',
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
          ),
        ],
      ),
    );
  }

  Widget _listCustomer(AddCustomerPGController vm) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Daftar Pelanggan : ${vm.listCustomers?.length ?? 0}',
                ),
                Row(
                  children: <Widget>[
                    Text('( '),
                    LoadingButton(
                      title: 'Tandai',
                      isActionNavigation: true,
                      noPadding: true,
                      noMargin: true,
                      onPressed: () {
                        vm.addAll();
                      },
                    ),
                    Text(' | '),
                    LoadingButton(
                      title: 'Hapus',
                      isActionNavigation: true,
                      noPadding: true,
                      noMargin: true,
                      onPressed: () {
                        vm.removeAll();
                      },
                    ),
                    Text(
                      ' ) Semua',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TextFormField(
              controller: searchController,
              onChanged: (txtSearch) async {
                await vm.actionSearch(txtSearch?.toLowerCase());
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
          if (vm.listCustomer == null)
            Expanded(
              child: Center(child: CupertinoActivityIndicator()),
            ),
          if (vm.listCustomer != null && vm.listCustomer.length == 0)
            Expanded(
              child: Center(child: Text('Tidak Ada Data.')),
            ),
          if (vm.listCustomer != null && vm.listCustomer.length > 0)
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
                                  child: Text(
                                      vm.listCustomers[idx].company
                                              ?.toAlias() ??
                                          '#',
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

  Widget _body(AddCustomerPGController vm) {
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
        trailing: LoadingButton(
          title: 'Simpan',
          isActionNavigation: true,
          noMargin: true,
          noPadding: true,
          onPressed: () async {
            await AddCustomerPGController.to.actionSubmit();
          },
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            init: AddCustomerPGController(pg),
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
      pg = PriceGroup.fromJson(arg['price_group']);
      isFirst = false;
    }
  }
}
