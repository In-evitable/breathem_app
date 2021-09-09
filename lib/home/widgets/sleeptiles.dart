import 'package:breathem_app/home/widgets/audio.dart';
import 'package:breathem_app/provider/audio_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class SleepTrack extends StatefulWidget {
  final String text;

  SleepTrack({required this.text});

  @override
  _SleepTrackState createState() => _SleepTrackState();
}

_searchCoverWithName(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['cover']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results[0]['cover'];
}

_searchFileWithName(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['cover']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results[0]['file'];
}

_searchDescriptionWithName(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['cover']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results[0]['decr'];
}

_searchTitleWhiteWithName(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['cover']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results[0]['titleWhite'];
}

_searchDescriptionWhiteWithName(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['cover']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results[0]['decrWhite'];
}

class _SleepTrackState extends State<SleepTrack> {
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
                      unlock: false,
                      poster:
                          'assets/images/covers/${_searchCoverWithName(widget.text)}',
                      name: widget.text,
                      localFileName:
                          'sounds/${_searchFileWithName(widget.text)}',
                      parentFunction: () {},
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/covers/${_searchCoverWithName(widget.text)}'),
              fit: BoxFit.cover),
        ),
        height: ResponsiveFlutter.of(context).scale(130),
        width: ResponsiveFlutter.of(context).scale(130),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 22, right: 22, top: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                convertToTitleCase(widget.text).toString(),
                style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontFamily: 'Karla',
                  color: _searchTitleWhiteWithName(widget.text)
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 22, right: 22, top: 0),
              alignment: Alignment.centerLeft,
              child: Text(
                _searchDescriptionWithName(widget.text),
                style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                    fontFamily: 'Karla',
                    color: _searchDescriptionWhiteWithName(widget.text)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.only(left: 22, top: 10, right: 5),
                    child: SvgPicture.asset(
                      'assets/images/svg/fi-rr-headphones.svg',
                      height: ResponsiveFlutter.of(context).scale(15),
                      width: ResponsiveFlutter.of(context).scale(15),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 22),
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
  }
}
