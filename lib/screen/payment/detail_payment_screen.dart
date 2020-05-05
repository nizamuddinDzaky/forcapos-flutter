import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';

class DetailPaymentScreen extends StatefulWidget {
  @override
  _DetailPaymentScreenState createState() => _DetailPaymentScreenState();
}

class _DetailPaymentScreenState extends State<DetailPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    String urlAttachment = '';
    if (Get.args(context) != null) {
      var arg = Get.args(context) as Map<String, dynamic>;
      var payment = Payment.fromJson(arg ?? {});
      urlAttachment = payment.attachment ?? '';
    }
    urlAttachment = 'https://pbs.twimg.com/profile_images/630285593268752384/iD1MkFQ0.png';

    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Balik',
          middle: Text('Rincian Pembayaran'),
          trailing: CupertinoButton(
            minSize: 0,
            child: Icon(CupertinoIcons.share),
            padding: EdgeInsets.all(0),
            onPressed: () {},
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
//                  errorWidget: (context, url, error) => Icon(Icons.error),
                  errorWidget: (context, url, error) => FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                    'https://pbs.twimg.com/profile_images/630285593268752384/iD1MkFQ0.png',
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
