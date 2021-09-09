import 'package:breathem_app/splash.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

TextStyle mainTextStyle() {
  return TextStyle(
    fontFamily: "Quicksand",
  );
}

InputDecoration textFieldDecoration(String text, BuildContext context) {
  return InputDecoration(
      errorStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveFlutter.of(context).fontSize(1.2)),
      hintText: text,
      hintStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: darkModeOn
                  ? Color.fromRGBO(150, 150, 255, 1)
                  : Colors.black12)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: darkModeOn
                  ? Color.fromRGBO(100, 100, 255, 1)
                  : Colors.black87)));
}

InputDecoration secondaryTextFieldDecoration(
    String text, BuildContext context) {
  return InputDecoration(
      errorStyle: TextStyle(fontFamily: 'Karla', fontWeight: FontWeight.bold),
      hintText: text,
      hintStyle: TextStyle(
          fontFamily: 'Karla',
          fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),
      border: InputBorder.none);
}
