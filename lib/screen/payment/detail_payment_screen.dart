import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPaymentScreen extends StatefulWidget {
  @override
  _DetailPaymentScreenState createState() => _DetailPaymentScreenState();
}

class _DetailPaymentScreenState extends State<DetailPaymentScreen> {
  void shareImage(String url, Payment payment) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    String refNo =
        payment?.referenceNo ?? '${DateTime.now().microsecondsSinceEpoch}';
//    await Share.file(
//        payment.referenceNo, 'pembayaran$refNo.jpg', bytes, 'image/jpg');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String urlAttachment = '';
    Payment payment;
    if (Get.args(context) != null) {
      var arg = Get.args(context) as Map<String, dynamic>;
      payment = Payment.fromJson(arg ?? {});
      urlAttachment = payment.attachment ?? '';
    }
//    urlAttachment = 'https://pbs.twimg.com/profile_images/630285593268752384/iD1MkFQ0.png';

    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text('Rincian Pembayaran'),
          trailing: CupertinoButton(
            minSize: 0,
            child: Icon(CupertinoIcons.share),
            padding: EdgeInsets.all(0),
            onPressed: () {
              //shareImage('https://pbs.twimg.com/profile_images/630285593268752384/iD1MkFQ0.png', payment);
              shareImage(urlAttachment, payment);
            },
          ),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              color: MyColor.mainBg,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: urlAttachment,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.error),
                      Text('Gagal memuat / Lampiran kosong'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
