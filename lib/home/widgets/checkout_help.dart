import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class CheckoutHelp extends StatelessWidget {
  const CheckoutHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      appBar: basicAppBar(context, 'Checkout'),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Checkout Guide',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(244, 55, 85, 1.0),
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(3)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              'Your points can be used to unlock new tracks. Once you tap on a track that you haven’t unlocked yet, you would have to either spend points or watch a video ad. The points cannot be redeemed as real money. You earn points when you listen to tracks. You need to have at least 10 points to unlock one track. Please note that the purchases can only occur when you have an active internet connection and enough points. ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
            ),
          )
        ],
      ),
    );
  }
}
