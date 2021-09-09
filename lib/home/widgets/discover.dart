import 'package:breathem_app/home/widgets/audio.dart';
import 'package:breathem_app/home/widgets/unlock.dart';
import 'package:breathem_app/provider/audio_library.dart';
import 'package:breathem_app/provider/unlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class DiscoverTile extends StatefulWidget {
  final String label;

  DiscoverTile({required this.label});

  @override
  _DiscoverTileState createState() => _DiscoverTileState();
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

class _DiscoverTileState extends State<DiscoverTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        audioPressed = false;
        setAudiosWatched = false;
        Navigator.push(
            context,
            (await getUnlock(widget.label)) != true
                ? MaterialPageRoute(
                    builder: (context) => Unlock(
                          poster:
                              'assets/images/covers/${_searchCoverWithName(widget.label)}',
                          name: widget.label,
                          localFileName:
                              'sounds/${_searchFileWithName(widget.label)}',
                        ))
                : MaterialPageRoute(
                    builder: (context) => AudioPage(
                        poster:
                            'assets/images/covers/${_searchCoverWithName(widget.label)}',
                        name: widget.label,
                        localFileName:
                            'sounds/${_searchFileWithName(widget.label)}',
                        parentFunction: () async {
                          print('unlock lol: ${await getUnlock(widget.label)}');
                        },
                        unlock: false)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/covers/${_searchCoverWithName(widget.label)}'),
              fit: BoxFit.cover),
        ),
        width: ResponsiveFlutter.of(context).scale(200),
        height: ResponsiveFlutter.of(context).scale(125),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 22, right: 22, top: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                convertToTitleCase(widget.label).toString(),
                style: TextStyle(
                  fontFamily: 'Karla',
                  color: _searchTitleWhiteWithName(widget.label)
                      ? Colors.white
                      : Colors.black,
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 22, right: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                _searchDescriptionWithName(widget.label),
                style: TextStyle(
                    fontFamily: 'Karla',
                    color: _searchDescriptionWhiteWithName(widget.label)
                        ? Colors.white
                        : Colors.black,
                    fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
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
