import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class PointsHelp extends StatelessWidget {
  const PointsHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      appBar: basicAppBar(context, 'Help'),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Points Guide',
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
              'For every track you listen to, you earn points. These points can be used to unlock new tracks. If you are too hyped to try out new tracks, you can watch a short ad. Please note that these points are only earnt when listening to tracks, and you cannot pay real currency to get points. The points are synced across your account, and you can only earn or redeem the points when you have an active internet connection. ',
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
