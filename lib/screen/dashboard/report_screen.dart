import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/dashboard/report_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends ReportViewModel {
  void showWarehousePicker() {
    DataPicker.showDatePicker(
      Navigator.of(context).context,
      locale: 'id',
      datas: listWarehouse,
      title: 'Urut berdasarkan',
      onConfirm: (data) {
        warehouse = data;
        refreshReport();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.all(0),
                  onPressed: !prevLimit()
                      ? null
                      : () {
                          prevMonth();
                          refreshReport();
                        },
                  disabledColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        showMonthPicker(
                          context: context,
                          firstDate: firstDate,
                          lastDate: lastDate,
                          initialDate: currentDate,
                        ).then((date) {
                          if (date != null) {
                            selectMonth(date);
                            refreshReport();
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Icon(
                              Icons.event_note,
                              color: MyColor.txtField,
                            ),
                          ),
                          Text(
                            currentDate.toMonthStr(showDiffYear: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.all(0),
                  onPressed: !nextLimit()
                      ? null
                      : () {
                          nextMonth();
                          refreshReport();
                        },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 12,
                  child: dataMap.isEmpty
                      ? Container()
                      : PieChart(
//                  child: reportSales == null ? Container() : PieChart(
//                  child: PieChart(
                          dataMap: dataMap,
//                    dataMap: dataMap.isNotEmpty
//                    dataMap: reportSales != null
//                        ? dataMap
//                        : {
//                            'NoData': 0,
//                          },
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          showChartValuesInPercentage: true,
                          showChartValues: true,
                          showChartValuesOutside: true,
                          chartValueBackgroundColor: Colors.grey[200],
                          colorList: colorList.map((dt) => dt.color).toList(),
                          showLegends: false,
                          legendPosition: LegendPosition.bottom,
                          decimalPlaces: 1,
                          showChartValueLabel: true,
                          initialAngle: 0,
                          chartValueStyle: defaultChartValueStyle.copyWith(
                            color: Colors.blueGrey[900].withOpacity(0.9),
                          ),
                          chartType: ChartType.ring,
                        ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
//                    child: reportSales == null
//                    child: reportSales == null
                    child: dataMap.isEmpty
                        ? CupertinoActivityIndicator()
                        : reportSales == null
                            ? CupertinoButton(
                                onPressed: refreshReport,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(CupertinoIcons.refresh_bold),
                                    Text('Ulangi'),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Total Transaksi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.txtField,
                                    ),
                                  ),
                                  Text(
                                    reportSales?.totalTransaction(),
                                    style: TextStyle(
                                      color: MyColor.txtField,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ),
                Positioned.fill(
                  right: 8,
                  bottom: 16,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.business,
                            color: MyColor.txtField,
                          ),
                        ),
                        LoadingButton(
                          onPressed: () async {
                            await actionGetWarehouse();
                            showWarehousePicker();
                          },
                          title: warehouse?.name ?? '?',
                          noMargin: true,
                          isActionNavigation: true,
                        ),
                      ],
                    ),
/*
                    child: CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.all(0),
                      onPressed: showWarehousePicker,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              Icons.business,
                              color: MyColor.txtField,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              warehouse?.name ?? '?',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
*/
                  ),
                ),
              ],
            ),
            ...colorList.mapIndexed((color, index) {
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: color.color,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                  ),
                  title: Text(color.title),
                  subtitle: dataMap[color.key] == null
                      ? Text('-')
                      : Text(
                          '${MyNumber.toNumberId(dataMap[color.key])} Transaksi',
                        ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ));
  }
}
