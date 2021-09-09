import 'package:breathem_app/home/widgets/favourites_tiles.dart';
import 'package:breathem_app/provider/audio_library.dart';
import 'package:breathem_app/provider/favourites.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    getFavouriteMap();

    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Container(
      child: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Text(
              'Favourites',
              style: TextStyle(
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(3),
                  fontWeight: FontWeight.bold),
            ),
          ),
          FavouritesRenderer(),
          SizedBox(height: 20)
        ],
      ),
    );
  }
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

/*
Widget favouritesList() {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: favouriteMap.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return favouriteMap.values.elementAt(index) == true
            ? Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: FavouritesTile(
                  name: favouriteMap.keys.elementAt(index),
                  decr: _searchDescriptionWithName(
                      favouriteMap.keys.elementAt(index)),
                  cover:
                      'assets/images/covers/${_searchCoverWithName(favouriteMap.keys.elementAt(index))}',
                  file: _searchFileWithName(favouriteMap.keys.elementAt(index)),
                  titleWhite: _searchTitleWhiteWithName(
                      favouriteMap.keys.elementAt(index)),
                  decrWhite: _searchDescriptionWhiteWithName(
                      favouriteMap.keys.elementAt(index)),
                ))
            : Container();
      });
}
*/

class FavouritesRenderer extends StatefulWidget {
  FavouritesRenderer({Key? key}) : super(key: key);

  @override
  _FavouritesRendererState createState() => _FavouritesRendererState();
}

class _FavouritesRendererState extends State<FavouritesRenderer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: favouriteMap.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return favouriteMap.values.elementAt(index) == true
                ? Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: FavouritesTile(
                      name: favouriteMap.keys.elementAt(index),
                      decr: _searchDescriptionWithName(
                          favouriteMap.keys.elementAt(index)),
                      cover:
                          'assets/images/covers/${_searchCoverWithName(favouriteMap.keys.elementAt(index))}',
                      file: _searchFileWithName(
                          favouriteMap.keys.elementAt(index)),
                      titleWhite: _searchTitleWhiteWithName(
                          favouriteMap.keys.elementAt(index)),
                      decrWhite: _searchDescriptionWhiteWithName(
                          favouriteMap.keys.elementAt(index)),
                          parentFunction: parentFunction,
                    ))
                : Container();
          }),
    );
  }

  parentFunction() {
    setState(() {
      
    });
  }
}