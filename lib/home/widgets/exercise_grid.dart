import 'package:breathem_app/home/navigation/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class ExerciseGrid extends StatefulWidget {
  const ExerciseGrid({Key? key}) : super(key: key);

  @override
  _ExerciseGridState createState() => _ExerciseGridState();
}

class _ExerciseGridState extends State<ExerciseGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Amy',
              style: TextStyle(
                  fontFamily: 'Karla',
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
            )),
        exerciseAmy(),
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Emma',
              style: TextStyle(
                  fontFamily: 'Karla',
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
            )),
        exerciseEmma(),
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Mark',
              style: TextStyle(
                  fontFamily: 'Karla',
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
            )),
        exerciseMark(),
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Jerry',
              style: TextStyle(
                  fontFamily: 'Karla',
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2)),
            )),
        exerciseJerry()
      ],
    );
  }
}

Widget exerciseAmy() {
  return GridView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        ExerciseTile(
          session: 'Dead Bug Exercise',
          video: 'amy/amy01.mp4',
          number: '01',
          lightColor: Color.fromRGBO(255, 214, 205, 1),
          color: Color.fromRGBO(234, 87, 79, 1.0),
        ),
        ExerciseTile(
          session: 'Open Books',
          video: 'amy/amy02.mp4',
          number: '02',
          lightColor: Color.fromRGBO(255, 214, 205, 1),
          color: Color.fromRGBO(234, 87, 79, 1.0),
        ),
        ExerciseTile(
          session: 'Open Hip Abduction',
          video: 'amy/amy03.mp4',
          number: '03',
          lightColor: Color.fromRGBO(255, 214, 205, 1),
          color: Color.fromRGBO(234, 87, 79, 1.0),
        ),
        ExerciseTile(
          session: 'Squat Jump',
          video: 'amy/amy04.mp4',
          number: '04',
          lightColor: Color.fromRGBO(255, 214, 205, 1),
          color: Color.fromRGBO(234, 87, 79, 1.0),
        ),
      ]);
}

Widget exerciseEmma() {
  return GridView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        ExerciseTile(
          session: 'Frog Press',
          video: 'emma/emma01.mp4',
          number: '01',
          lightColor: Color.fromRGBO(169, 136, 194, 1),
          color: Color.fromRGBO(114, 19, 186, 1.0),
        ),
        ExerciseTile(
          session: 'Lunges',
          video: 'emma/emma02.mp4',
          number: '02',
          lightColor: Color.fromRGBO(169, 136, 194, 1),
          color: Color.fromRGBO(114, 19, 186, 1.0),
        ),
        ExerciseTile(
          session: 'Seated Abs Circle',
          video: 'emma/emma03.mp4',
          number: '03',
          lightColor: Color.fromRGBO(169, 136, 194, 1),
          color: Color.fromRGBO(114, 19, 186, 1.0),
        ),
        ExerciseTile(
          session: 'Step Up on Chair',
          video: 'emma/emma04.mp4',
          number: '04',
          lightColor: Color.fromRGBO(169, 136, 194, 1),
          color: Color.fromRGBO(114, 19, 186, 1.0),
        ),
      ]);
}

Widget exerciseMark() {
  return GridView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        ExerciseTile(
          session: 'Abs Crunches',
          video: 'mark/mark01.mp4',
          number: '01',
          lightColor: Color.fromRGBO(56, 199, 199, 1),
          color: Color.fromRGBO(42, 145, 145, 1.0),
        ),
        ExerciseTile(
          session: 'Push-ups',
          video: 'mark/mark02.mp4',
          number: '02',
          lightColor: Color.fromRGBO(56, 199, 199, 1),
          color: Color.fromRGBO(42, 145, 145, 1.0),
        ),
        ExerciseTile(
          session: 'High Knees',
          video: 'mark/mark03.mp4',
          number: '03',
          lightColor: Color.fromRGBO(56, 199, 199, 1),
          color: Color.fromRGBO(42, 145, 145, 1.0),
        ),
        ExerciseTile(
          session: 'Triceps Dips',
          video: 'mark/mark04.mp4',
          number: '04',
          lightColor: Color.fromRGBO(56, 199, 199, 1),
          color: Color.fromRGBO(42, 145, 145, 1.0),
        ),
      ]);
}

Widget exerciseJerry() {
  return GridView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        ExerciseTile(
          session: 'Inchworm',
          video: 'jerry/jerry01.mp4',
          number: '01',
          lightColor: Color.fromRGBO(251, 255, 0, 1),
          color: Color.fromRGBO(186, 189, 25, 1.0),
        ),
        ExerciseTile(
          session: 'Reverse Crunches',
          video: 'jerry/jerry02.mp4',
          number: '02',
          lightColor: Color.fromRGBO(251, 255, 0, 1),
          color: Color.fromRGBO(186, 189, 25, 1.0),
        ),
        ExerciseTile(
          session: 'Squat Kick',
          video: 'jerry/jerry03.mp4',
          number: '03',
          lightColor: Color.fromRGBO(251, 255, 0, 1),
          color: Color.fromRGBO(186, 189, 25, 1.0),
        ),
        ExerciseTile(
          session: 'T Plank',
          video: 'jerry/jerry04.mp4',
          number: '04',
          lightColor: Color.fromRGBO(251, 255, 0, 1),
          color: Color.fromRGBO(186, 189, 25, 1.0),
        ),
      ]);
}
