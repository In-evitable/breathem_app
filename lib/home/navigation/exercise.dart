import 'package:breathem_app/home/widgets/exercise_grid.dart';
import 'package:breathem_app/home/widgets/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0),
      shrinkWrap: true,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Exercise',
                    style: TextStyle(
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveFlutter.of(context).fontSize(3.25),
                        color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
                  child: Text(
                    '“The pain you feel today, will be the strength you feel tomorrow.”',
                    style: TextStyle(
                        fontFamily: 'Karla',
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  margin: EdgeInsets.only(bottom: 20, left: 20),
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(234, 87, 79, 1.0),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Begin',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Karla',
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/images/svg/fi-sr-play.svg',
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/covers/exercise.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 25, bottom: 0, right: 25, left: 25),
          margin: EdgeInsets.zero,
          child: Text(
            'Let\'s begin',
            style: TextStyle(
                fontFamily: 'Karla',
                fontSize: ResponsiveFlutter.of(context).fontSize(2.25),
                fontWeight: FontWeight.w700),
          ),
        ),
        ExerciseGrid()
      ],
    ));
  }
}

class ExerciseTile extends StatefulWidget {
  final String session;
  final String number;
  final String video;
  final Color lightColor;
  final Color color;
  ExerciseTile(
      {required this.session,
      required this.video,
      required this.number,
      required this.lightColor,
      required this.color});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        videoPressed = false;
        setVideosWatched = false;
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                    title: widget.session, video: widget.video)));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
          border: darkModeOn ? Border.all(color: widget.color, width: 2) : null,
          boxShadow: darkModeOn
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.175),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                convertToTitleCase(widget.session).toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Karla',
                    color: darkModeOn ? widget.lightColor : widget.color,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2)),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  widget.number,
                  style: TextStyle(
                      color: darkModeOn ? widget.lightColor : widget.color,
                      fontFamily: 'Karla',
                      fontWeight: FontWeight.w700,
                      fontSize: ResponsiveFlutter.of(context).fontSize(5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
