import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:intl/intl.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class FilterState extends ChangeNotifier {
  String currentPage = '';
  final Map<String, String> firstFilter;

  FilterState({this.firstFilter}) {
    firstInit(this.firstFilter ?? {});
  }

  void firstInit(Map<String, String> first) {
    if (first.containsKey(MyString.KEY_SORT_BY)) {
      indexSort = sortVal.indexOf(first[MyString.KEY_SORT_BY]);
      isAsc = first[MyString.KEY_SORT_TYPE];
    }
    if (first.containsKey(MyString.KEY_START_DATE)) {
      var startDate = DateTime.tryParse(first[MyString.KEY_START_DATE]);
      var endDate = DateTime.tryParse(first[MyString.KEY_END_DATE]);
      if (startDate != null && endDate != null) {
        changeIntervals([
          [
            startDate,
            endDate,
          ],
        ], notify: false);
      }
    }
    callInitFilter(first['page']);
    if (first.containsKey(MyString.KEY_PAY_STATUS)) {
      selectedPayment = (selectedPayment.where((data) {
        return data[1] == first[MyString.KEY_PAY_STATUS];
      })?.first) ??
          ['', ''];
    }
    if (first.containsKey(MyString.KEY_GR_STATUS)) {
      _selectedStatus = (_statusDelivery.where((data) {
        return data[1] == first[MyString.KEY_GR_STATUS];
      })?.first) ??
          ['', ''];
    }
    if (first.containsKey(MyString.KEY_SALE_STATUS)) {
      _selectedStatus = (_statusDelivery.where((data) {
        return data[1] == first[MyString.KEY_SALE_STATUS];
      })?.first) ??
          ['', ''];
    }
  }

  void _initFilterGR() {
    _statusDelivery.addAll([
      ['Dikirim', 'delivering'],
      ['Diterima', 'received'],
    ]);
  }

  void _initFilterSB() {
    statusPayment.addAll([
      ['Menunggu', 'pending'],
      ['Sebagian', 'partial'],
      ['Lunas', 'paid'],
      ['Jatuh Tempo', 'due'],
    ]);
    _statusDelivery.addAll([
      ['Menunggu', 'pending'],
      ['Dipesan', 'reserved'],
      ['Selesai', 'closed'],
    ]);
  }

  void callInitFilter(String page) {
    currentPage = page;
    _statusDelivery = [];
    statusPayment = [];
    switch(page) {
      case 'gr':
        _initFilterGR();
        break;
      case 'sb':
        _initFilterSB();
        break;
      default:
        _initFilterGR();
        _initFilterSB();
        break;
    }
  }

  //status
  List<List<String>> _statusDelivery = [];
  List<List<String>> statusPayment = [];
  List<String> _selectedStatus = ['', ''];
  List<String> selectedPayment = ['', ''];

  List<String> get selectedStatus => _selectedStatus;

  List<List<String>> get statusDelivery => _statusDelivery;

  bool getStatus(int index) => _selectedStatus == _statusDelivery[index];
  bool getStatusPayment(int index) => selectedPayment == statusPayment[index];

  void changeStatus(int index) {
    _selectedStatus = _statusDelivery[index];
    notifyListeners();
  }

  void changeStatusPayment(int index) {
    selectedPayment = statusPayment[index];
    notifyListeners();
  }

  //date range
  List<List<DateTime>> intervals = [];
  String differenceDate;
  int hint;

  void changeIntervals(List<List<DateTime>> intervals, {bool notify}) {
    this.intervals = intervals;
    if (intervals.length == 1) {
      differenceDate =
          differenceDateTime(intervals.first[0], intervals.first[1]);
    }
    hint = 0;
    if (notify == true) notifyListeners();
  }

  //sorting
  String isAsc = 'desc';
  int indexSort = 0;
  List<String> sortData = ['Tanggal Transaksi', 'Total Harga', 'Status'];
  List<String> sortVal = ['date', 'amount', 'status_penerimaan'];

  String get labelName => sortData[indexSort % sortData.length];

  String get _labelVal => sortVal[indexSort % sortVal.length];

  void showDataPicker(BuildContext context) {
    final bool showTitleActions = true;
    DataPicker.showDatePicker(
      context,
      showTitleActions: showTitleActions,
      locale: 'id',
      datas: sortData,
      title: 'Urut berdasarkan',
      onChanged: (_) {},
      onConfirm: (data) {
        indexSort = sortData.indexOf(data);
        notifyListeners();
      },
    );
  }

  void updateSortType() {
    isAsc = isAsc == 'asc' ? 'desc' : 'asc';
    notifyListeners();
  }

  String labelType() {
    switch (indexSort) {
      case 1:
        return isAsc == 'desc' ? 'Tertinggi' : 'Terendah';
      case 2:
        return isAsc == 'desc' ? 'Z - A' : 'A - Z';
      default:
        return isAsc == 'desc' ? 'Terbaru' : 'Awal';
    }
  }

  Map<String, String> resultFilter(page) {
    Map<String, String> result = {};
    if (intervals.isNotEmpty && intervals.first.isNotEmpty) {
      var f = DateFormat('yyyy-MM-dd HH:mm:ss');
      result[MyString.KEY_START_DATE] = f.format(intervals.first[0]);
      result[MyString.KEY_END_DATE] = f.format(intervals.first[1]);
    }
    if (_selectedStatus.isNotEmpty && _selectedStatus[1] != '' && page == 'gr') {
      result[MyString.KEY_GR_STATUS] = _selectedStatus[1];
    }
    if (_selectedStatus.isNotEmpty && _selectedStatus[1] != '' && page == 'sb') {
      result[MyString.KEY_SALE_STATUS] = _selectedStatus[1];
    }
    if (selectedPayment.isNotEmpty && selectedPayment[1] != '' && page == 'sb') {
      result[MyString.KEY_PAY_STATUS] = selectedPayment[1];
    }
    result[MyString.KEY_SORT_BY] = _labelVal;
    result[MyString.KEY_SORT_TYPE] = isAsc;
    print(result);
    return result;
  }

  void onReset() {
    _selectedStatus = ['', ''];
    intervals = [];
    differenceDate = null;
    indexSort = 0;
    isAsc = 'desc';
    hint = null;
    notifyListeners();
  }
}