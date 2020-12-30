import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/screen/customer/customer_view_model.dart';
import 'package:posku/screen/masterdata/master_data_controller.dart';
import 'package:posku/util/resource/my_color.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends CustomerViewModel {
  @override
  Widget build(BuildContext context) {
    if (MasterDataController.to.isRefresh) {
      MasterDataController.to.refresh(callback: () {
        actionRefresh();
      });
    }
    return isFirst
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: listCustomer.length == 0
                ? LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Image.asset('assets/images/female_forca.png'),
                                SizedBox(height: 16),
                                Text('Belum ada data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                SizedBox(height: 16),
                                Text('Tarik ke bawah untuk memuat ulang'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    color: Color(0xffE9E9E9),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (c, i) => _listItem(listCustomer[i], i),
                      itemCount: listCustomer.length,
                    ),
                  ),
          );
  }

  Widget _listItem(Customer customer, int index) {
    List<String> address = [];
    address.add(customer?.city);
    address.add(customer?.country);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Get.toNamed(detailCustomerScreen, arguments: {
            'id': customer.id,
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  child: Text('PoS',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
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
                      customer?.company ?? '~',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if ((customer?.cf1 ?? '').isNotEmpty)
                      Text(
                        customer?.cf1 ?? '~',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    Text(
                      address?.where((dt) => dt != null)?.join(', '),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
