import 'package:posku/util/my_number.dart';

class ReportSales {
  int pending;
  int confirmed;
  int canceled;
  int completed;
  int returned;
  int reserved;
  int closed;

  ReportSales(
      {this.pending,
        this.confirmed,
        this.canceled,
        this.completed,
        this.returned,
        this.reserved,
        this.closed});

  ReportSales.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    confirmed = json['confirmed'];
    canceled = json['canceled'];
    completed = json['completed'];
    returned = json['returned'];
    reserved = json['reserved'];
    closed = json['closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['confirmed'] = this.confirmed;
    data['canceled'] = this.canceled;
    data['completed'] = this.completed;
    data['returned'] = this.returned;
    data['reserved'] = this.reserved;
    data['closed'] = this.closed;
    return data;
  }

  String totalTransaction() {
    List<double> data = [
      MyNumber.strUSToDouble(pending.toString()),
      MyNumber.strUSToDouble(reserved.toString()),
      MyNumber.strUSToDouble(closed.toString()),
    ];
//    return MyNumber.toNumberId(data.where((c) => c != null).reduce((a, b) => a + b));
//    print('cek nilai ${data?.reduce((a, b) => a + b) ?? 0}');
//    return '';
    return MyNumber.toNumberId(data?.reduce((a, b) => a + b) ?? 0);
  }
}
