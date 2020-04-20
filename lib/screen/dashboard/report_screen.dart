import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';

import 'dart:core';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }
}

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Color(0xFF25CED9),
    Color(0xFFF72564),
    Color(0xFF1CA865),
  ];

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Menunggu", () => 17);
    dataMap.putIfAbsent("Dipesan", () => 27);
    dataMap.putIfAbsent("Selesai", () => 56);
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
                Icon(
                  Icons.arrow_back_ios,
                  color: MyColor.txtField,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Icon(
                          Icons.event_note,
                          color: MyColor.txtField,
                        ),
                      ),
                      Text(
                        'April',
                        style: TextStyle(
                          color: MyColor.txtField,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyColor.txtField,
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 11,
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: true,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
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
                    child: Column(
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
                          MyNumber.toNumberId(21000),
                          style: TextStyle(
                            color: MyColor.txtField,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 16,
                  bottom: 16,
                  child: Align(
                    alignment: Alignment.bottomRight,
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
                        Text(
                          'Gudang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColor.txtField,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ...colorList.mapIndexed((color, index) {
              return ListTile(
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                ),
                title: Text(
                  dataMap.entries.map((data) => data.key).toList()[index],
                ),
                subtitle: Text(
                  '${MyNumber.toNumberId(dataMap.entries.map((data) => data.value).toList()[index])} Transaksi',
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            }).toList(),
          ],
      ),
    ),
        ));
  }
}
