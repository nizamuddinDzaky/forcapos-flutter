import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/screen/delivery/edit_delivery_view_model.dart';

class EditDeliveryScreen extends StatefulWidget {
  @override
  _EditDeliveryScreenState createState() => _EditDeliveryScreenState();
}

class _EditDeliveryScreenState extends EditDeliveryViewModel {
  Widget _body() {
    return Container(
      child: Text('Content edit delivery'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Dftr Krm',
        middle: Text(
          'Ubah Pengiriman',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      child: Material(
        child: SafeArea(
          child: _body(),
        ),
      ),
    );
  }
}
