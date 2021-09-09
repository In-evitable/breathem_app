import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';
import 'audio.dart';

class FavouritesTile extends StatefulWidget {
  final String name;
  final String decr;
  final String cover;
  final String file;
  final bool titleWhite;
  final bool decrWhite;
  final VoidCallback parentFunction;

  FavouritesTile(
      {required this.name,
      required this.file,
      required this.cover,
      required this.decr,
      required this.decrWhite,
      required this.titleWhite,
      required this.parentFunction});

  @override
  _FavouritesTileState createState() => _FavouritesTileState();
}

class _FavouritesTileState extends State<FavouritesTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        audioPressed = false;
        setAudiosWatched = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AudioPage(
                      poster: widget.cover,
                      name: widget.name,
                      localFileName: 'sounds/${widget.file}',
                      parentFunction: widget.parentFunction,
                      unlock: false,
                    ))).then((value) {
          refresh();
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('${widget.cover}'), fit: BoxFit.cover),
        ),
        height: ResponsiveFlutter.of(context).scale(120),
        width: ResponsiveFlutter.of(context).scale(60),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 22, right: 22, top: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                convertToTitleCase(widget.name).toString(),
                style: TextStyle(
                    fontFamily: 'Karla',
                    color: /* titleWhite ? */ Colors.white /* : Colors.black */,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2)),
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.only(left: 22, top: 20, right: 5),
                    child: SvgPicture.asset(
                      'assets/images/svg/fi-rr-headphones.svg',
                      height: ResponsiveFlutter.of(context).scale(15),
                      width: ResponsiveFlutter.of(context).scale(15),
                      color: /* decrWhite ? */ Colors.white /* : Colors.black*/,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20, right: 22),
                    child: SvgPicture.asset(
                      'assets/images/svg/fi-rr-play.svg',
                      height: ResponsiveFlutter.of(context).scale(15),
                      width: ResponsiveFlutter.of(context).scale(15),
                      color: Colors.white,
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
    /* Container(
      child: Column(
        children: [
          Text(name),
          Text(file),
        ],
      ),
    ); */
  }

  void refresh() {
    setState(() {});
  }
}
