import 'package:breathem_app/home/widgets/audio.dart';
import 'package:flutter/material.dart';
import 'package:breathem_app/splash.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

AppBar basicAppBar(
    BuildContext context, String title) {
  return AppBar(
    shape: Border(
        bottom: BorderSide(
            color: darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0),
            width: 1)),
    backgroundColor: darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
    shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
    leading: new IconButton(
        icon: SvgPicture.asset(
          'assets/images/svg/fi-rr-angle-small-left.svg',
          height: ResponsiveFlutter.of(context).scale(25),
          width: ResponsiveFlutter.of(context).scale(25),
          color: darkModeOn ? Colors.white : Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          color: darkModeOn ? Colors.white : Colors.black,
          fontSize: ResponsiveFlutter.of(context).fontSize(2),
          fontFamily: 'Karla'),
    ),
  );
}

AppBar searchAppBar(BuildContext context) {
  return AppBar(
      title: Text(
        'Search',
        style: TextStyle(fontFamily: 'Karla'),
      ),
      shape: Border(
          bottom: BorderSide(
              color: darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0),
              width: 1)),
      backgroundColor:
          darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
      shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
      leading: Container(
        child: new IconButton(
            icon: SvgPicture.asset(
              'assets/images/svg/fi-rr-angle-small-left.svg',
              height: ResponsiveFlutter.of(context).scale(25),
              width: ResponsiveFlutter.of(context).scale(25),
              color: darkModeOn ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ));
}
