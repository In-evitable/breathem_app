import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:breathem_app/home/widgets/audio.dart';
import 'package:breathem_app/splash.dart';
import 'package:breathem_app/templates/style.dart';
import 'package:flutter/material.dart';
import 'package:breathem_app/provider/audio_library.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

TextEditingController searchPageController = new TextEditingController();

class SearchPage extends StatefulWidget {
  List searchResults = [];

  SearchPage() {
    searchResults = _searchWithKeyword(searchPageController.text);
  }

  @override
  _SearchPageState createState() => _SearchPageState();
}

_searchWithKeyword(String keyword) {
  List results = [];
  for (Map map in AudioLibrary.audioLibrary) {
    if (map.containsKey('name')) {
      if (map['name'].toString().contains(keyword.toLowerCase())) {
        print('correct');
        print(map['name']);
        results.add(map);
      } else if (!(map['name'].toString().contains(keyword.toLowerCase()))) {
        print('wrong');
      }
    }
  }
  print(results);
  return results;
}

class _SearchPageState extends State<SearchPage> {
  Widget searchList() {
    if (widget.searchResults.isNotEmpty) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.searchResults.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SearchTile(
                  name: widget.searchResults[index]['name'],
                  decr: widget.searchResults[index]['decr'],
                  cover:
                      'assets/images/covers/${widget.searchResults[index]['cover']}',
                  file: widget.searchResults[index]['file'],
                  titleWhite: widget.searchResults[index]['titleWhite'],
                  decrWhite: widget.searchResults[index]['decrWhite']),
            );
          });
    } else if (widget.searchResults.isEmpty) {
      return Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'There were no great matches for your search.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: searchAppBar(context),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Color.fromRGBO(234, 87, 79, 1.0), width: 2)),
            margin: EdgeInsets.only(left: 50, right: 50, top: 20),
            child: Row(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 175,
                    child: TextField(
                      style: TextStyle(
                          fontFamily: 'Karla',
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.5)),
                      controller: searchPageController,
                      cursorColor: Color.fromRGBO(234, 87, 79, 1.0),
                      decoration:
                          secondaryTextFieldDecoration('Type here...', context),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      widget.searchResults =
                          _searchWithKeyword(searchPageController.text);
                      print(widget.searchResults);
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      'assets/images/svg/fi-rr-search.svg',
                      color: Color.fromRGBO(234, 87, 79, 1.0),
                    ))
              ],
            ),
          ),
          searchList(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String name;
  final String decr;
  final String cover;
  final String file;
  final bool titleWhite;
  final bool decrWhite;

  SearchTile(
      {required this.name,
      required this.file,
      required this.cover,
      required this.decr,
      required this.decrWhite,
      required this.titleWhite});

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
                      poster: cover,
                      name: name,
                      localFileName: 'sounds/$file',
                      unlock: false,
                      parentFunction: () {},
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage('$cover'), fit: BoxFit.cover),
        ),
        height: ResponsiveFlutter.of(context).scale(120),
        width: ResponsiveFlutter.of(context).scale(60),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 22, right: 22, top: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                convertToTitleCase(name).toString(),
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
}
