import 'package:flutter/cupertino.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/report_sale.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/screen/dashboard/report_screen.dart';

class PieModel {
  Color color;
  String title;
  String key;

  PieModel({this.color, this.title, this.key});
}

abstract class ReportViewModel extends State<ReportScreen> {
  ReportSales reportSales;
  Warehouse warehouse = Warehouse(name: 'Semua Gudang', id: null);
  List<Warehouse> listWarehouse = [];
  DateTime currentDate = DateTime.now();
  DateTime firstDate = DateTime.now().subtract(Duration(days: 365 ~/ 2));
  DateTime lastDate = DateTime.now().add(Duration(days: 365 ~/ 2));
  Map<String, double> dataMap = {};
  List<PieModel> colorList = [
    PieModel(color: Color(0xFF25CED9), key: 'pending', title: 'Menunggu'),
    PieModel(color: Color(0xFFF72564), key: 'reserved', title: 'Dipesan'),
    PieModel(color: Color(0xFF1CA865), key: 'closed', title: 'Selesai'),
  ];

  Future<Null> actionGetReport(String yearMonth) async {
    var params = {
      if (warehouse.id != null) 'warehouse_id': warehouse?.id,
      'year_month': yearMonth,
    };
    print('cek params $params');
    var status = await ApiClient.methodGet(
      ApiConfig.urlListSalesBookingTrx,
      params: params,
      onSuccess: (data, flag) {
        reportSales = ReportSales.fromJson(data['data'] ?? {});
        dataMap['pending'] = reportSales?.pending?.toDouble() ?? 0;
        dataMap['reserved'] = reportSales?.reserved?.toDouble() ?? 0;
        dataMap['closed'] = reportSales?.closed?.toDouble() ?? 0;
      },
      onAfter: (_) {
        if (reportSales == null) {
          dataMap['pending'] = 0;
          dataMap['reserved'] = 0;
          dataMap['closed'] = 0;
        }
      }
    );
    setState(() {
      status.execute();
    });
    return null;
  }

  actionGetWarehouse() async {
    if (listWarehouse.length != 1) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListWarehouse,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listWarehouse.addAll(baseResponse?.data?.listWarehouses ?? []);
      },
    );
    status.execute();
  }

  void prevMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    setState(() {});
  }

  void nextMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    setState(() {});
  }

  void selectMonth(DateTime newDate) {
    currentDate = DateTime(newDate.year, newDate.month, currentDate.day);
  }

  bool prevLimit() {
    var interval = currentDate.difference(DateTime.now()).inDays;
    return interval > -(365 ~/ 2);
  }

  bool nextLimit() {
    var interval = DateTime.now().difference(currentDate).inDays;
    return interval > -(365 ~/ 2);
  }

  void refreshReport() {
    setState(() {
      dataMap.clear();
    });
    var yearMonth = '${currentDate.year}-${currentDate.month}';
    actionGetReport(yearMonth);
  }

  @override
  void initState() {
    super.initState();
//    dataMap['pending'] = 0;
//    dataMap['reserved'] = 0;
//    dataMap['closed'] = 0;
//    dataMap.putIfAbsent("Menunggu", () => 17);
//    dataMap.putIfAbsent("Dipesan", () => 27);
//    dataMap.putIfAbsent("Selesai", () => 56);
    listWarehouse.add(warehouse);
    refreshReport();
  }
}
