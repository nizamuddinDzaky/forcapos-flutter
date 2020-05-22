import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/loading_button.dart';
import 'package:posku/screen/profile/profile_view_model.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/widget/my_divider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum InputType {
  text,
  number,
  dropdown,
  radio,
}

class InputModel {
  InputType inputType;
  TextInputType textInputType;
  String key;
  String value;
  String prefixText;
  String suffixText;
  String currentRadio;
  List<List<String>> dataRadio;

  InputModel({
    this.inputType,
    this.textInputType,
    this.key,
    this.value,
    this.prefixText,
    this.suffixText,
    this.currentRadio,
    this.dataRadio,
  });
}

class _ProfileScreenState extends ProfileViewModel {
  Widget _bodySheetMenu({
    String title,
    String unitCode,
    List<List<dynamic>> list,
  }) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(14.0),
              topRight: const Radius.circular(14.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CupertinoButton(
                onPressed: () => Get.back(),
                child: Text('Batal'),
              ),
              Container(
                alignment: Alignment.center,
                height: 48,
                child: Text(
                  title ?? 'Masukkan Jumlah',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Positioned(
                right: 0,
                child: LoadingButton(
                  onPressed: () async {
                    Map<String, String> body = {};
                    list.forEach((data2) {
                      if (data2[2].value != null)
                        body[data2[2].key] = data2[2].value ?? data2[1];
                    });
                    print('cek map $body');
                    await actionPutProfile(body);
                  },
                  title: 'Selesai',
                  noMargin: true,
                  isActionNavigation: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ...(list ?? []).map((data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (data != null)
                          Text(
                            data[0],
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        if (data[2].inputType == InputType.text)
                          TextFormField(
                            //controller: qtySentController,
                            initialValue: data[1],
                            autofocus: true,
                            onChanged: (value) {
                              data[2].value = value;
                            },
                            keyboardType: data[2].textInputType,
                            decoration: new InputDecoration(
//                              prefixText: 'Jumlah Kirim : ',
//                              suffixText: unitCode ?? '',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                            ),
                          ),
                        if (data[2].inputType == InputType.radio)
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState
                                  /*You can rename this!*/) {
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: 16 / 3,
                              children: <Widget>[
                                ...(data[2].dataRadio ?? []).map((data2) {
                                  return RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: MyColor.mainRed),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        data[2].currentRadio = data2[1];
                                        data[2].value = data[2].currentRadio;
                                      });
                                    },
                                    color: data[2].currentRadio == data2[1]
                                        ? MyColor.mainRed
                                        : Colors.white,
                                    child: Text(
                                      data2[0],
                                      style: TextStyle(
                                        color: data[2].currentRadio == data2[1]
                                            ? Colors.white
                                            : MyColor.txtField,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _listItem(List<List<dynamic>> list) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, idx) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                list[idx][0],
                style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: MyColor.txtField,
                    ),
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  list[idx][1] ?? '',
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: MyColor.txtField,
                      ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (ctx, idx) {
        return MyDivider.lineDivider(customColor: MyColor.txtField);
      },
      itemCount: list?.length ?? 0,
    );
  }

  Widget _section(
    String title, {
    String actionTxt,
    Function action,
    List<List<dynamic>> list,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.all(0),
            //onPressed: () => action ?? {},
            onPressed: () async {
              var result = await showModalBottomSheet<String>(
                  context: context,
                  isDismissible: false,
                  isScrollControlled: true,
                  builder: (builder) {
                    return _bodySheetMenu(title: 'Ubah $title', list: list);
                  });
            },
            child: Text(
              actionTxt ?? 'Ubah',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: MyColor.blueDio,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    var address = [
      company?.address,
      company?.region,
      company?.city,
      company?.state,
      company?.postalCode,
    ].where((data) => data != null).join(', ');
    var padSpace = SizedBox(height: 12);

    var listProfile = [
      [
        'Nama Depan',
        company?.user?.firstName ?? company?.name,
        InputModel(
          inputType: InputType.text,
          key: 'first_name',
        ),
      ],
      [
        'Nama Belakang',
        company?.user?.lastName ?? company?.name,
        InputModel(
          inputType: InputType.text,
          key: 'last_name',
        ),
      ],
      [
        'Jenis Kelamin',
        gender == 'male'
            ? 'Laki-laki'
            : (gender == 'female' ? 'Perempuan' : ''),
        InputModel(
          inputType: InputType.radio,
          key: 'gender',
          currentRadio: gender,
          dataRadio: [
            ['Laki-laki', 'male'],
            ['Perempuan', 'female'],
          ],
        ),
      ],
    ];
    var listAddress = [
      [
        'Provinsi',
        company?.user?.country ?? company?.state,
        InputModel(
          inputType: InputType.dropdown,
          key: 'state',
        ),
      ],
      [
        'Kota',
        company?.user?.city ?? company?.city,
        InputModel(
          inputType: InputType.dropdown,
          key: 'city',
        ),
      ],
      [
        'Desa',
        company?.state,
        InputModel(
          inputType: InputType.dropdown,
          key: 'region',
        ),
      ],
      [
        'Alamat',
        company?.address,
        InputModel(
          inputType: InputType.text,
          key: 'address',
        ),
      ],
      [
        'Kode Pos',
        company?.postalCode,
        InputModel(
          inputType: InputType.text,
          key: 'postal_code',
        ),
      ],
    ];
    var listCompany = [
      [
        'Kode BK (CF1)',
        company?.cf1,
        InputModel(
          inputType: InputType.text,
          key: 'cf1',
        ),
      ],
      [
        'Kode Supplier (CF6)',
        company?.cf6,
        InputModel(
          inputType: InputType.text,
          key: 'cf6',
        ),
      ],
    ];
    var listAccount = [
      [
        'Email',
        company?.email,
        InputModel(
          inputType: InputType.text,
          key: 'email',
          textInputType: TextInputType.emailAddress,
        ),
      ],
      [
        'No. Telp.',
        company?.user?.phone,
        InputModel(
          inputType: InputType.text,
          key: 'phone',
          textInputType: TextInputType.phone,
        ),
      ],
    ];

    return Container(
      color: MyColor.mainBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 16 + 64 / 2,
                  ),
                  padding: EdgeInsets.only(
                    left: (32 + 64).toDouble(),
                    right: 16,
                    top: 8,
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              company?.company ?? '',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            child: Icon(
                              Icons.edit,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        address,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    top: 8,
                  ),
                  child: Hero(
                    tag: 'logoForcaPoS',
                    child: Image.asset(
                      'assets/images/avatar_account.png',
                      height: 64,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    top: 8,
                  ),
                  height: 64,
                  width: 64,
                  child: ClipOval(
                    child: CupertinoButton(
                      minSize: 0,
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: (64 - 24).toDouble()),
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            'Ubah',
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            padSpace,
            _section('Pribadi', list: listProfile),
            _listItem(listProfile),
            padSpace,
            _section('Alamat', list: listAddress),
            _listItem(listAddress),
            padSpace,
            _section('Perusahaan', list: listCompany),
            _listItem(listCompany),
            padSpace,
            _section('Akun', list: listAccount),
            _listItem(listAccount),
            padSpace,
            LoadingButton(
              onPressed: () async {
                var result = await showModalBottomSheet<String>(
                    context: context,
                    isDismissible: false,
                    isScrollControlled: true,
                    builder: (builder) {
                      return _bodySheetMenu(title: 'Ubah Kata Sandi', list: [
                        [
                          'Kata Sandi Lama',
                          '',
                          InputModel(
                            inputType: InputType.text,
                            textInputType: TextInputType.visiblePassword,
                            key: 'old_password',
                          ),
                        ],
                        [
                          'Kata Sandi Baru',
                          '',
                          InputModel(
                            inputType: InputType.text,
                            textInputType: TextInputType.visiblePassword,
                            key: 'new_password',
                          ),
                        ],
                        [
                          'Ulangi Kata Sandi',
                          '',
                          InputModel(
                            inputType: InputType.text,
                            textInputType: TextInputType.visiblePassword,
                            key: 'new_password_confirm',
                          ),
                        ],
                      ]);
                    });
              },
              title: 'Ganti Kata Sandi',
            ),
            padSpace,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Beranda',
        middle: Text(
          'Akun',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      child: Material(
        child: SafeArea(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionGetProfile,
            child: _body(),
          ),
        ),
      ),
    );
  }
}
