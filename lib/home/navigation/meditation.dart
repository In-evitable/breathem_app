import 'package:breathem_app/home/widgets/discover.dart';
import 'package:breathem_app/home/widgets/search.dart';
import 'package:breathem_app/templates/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../splash.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  TextEditingController searchController = new TextEditingController();
  double searchBorderWidth = 2;
  String searchHintText = 'Type here...';

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Discover',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Text(
                  'Browse our library of meditation tracks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: Color.fromRGBO(234, 87, 79, 1.0),
                      width: searchBorderWidth)),
              margin: EdgeInsets.only(
                left: 50,
                right: 50,
              ),
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
                        controller: searchController,
                        cursorColor: Color.fromRGBO(234, 87, 79, 1.0),
                        decoration: secondaryTextFieldDecoration(
                            searchHintText, context),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (searchController.text.isEmpty) {
                          setState(() {});
                        } else if (searchController.text == ' ') {
                          searchController.text = '';
                          setState(() {});
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                          searchPageController.text = searchController.text;
                        }
                      },
                      icon: SvgPicture.asset(
                        'assets/images/svg/fi-rr-search.svg',
                        color: Color.fromRGBO(234, 87, 79, 1.0),
                      ))
                ],
              ),
            ),
            // end of search part
            // Visualization Tracks
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: Text(
                'Visualization Tracks',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DiscoverTile(label: 'intro'),
                  DiscoverTile(
                    label: 'stress',
                  ),
                  DiscoverTile(
                    label: 'intro',
                  ),
                  DiscoverTile(
                    label: 'intro',
                  ),
                  DiscoverTile(
                    label: 'intro',
                  )
                ],
              ),
            ),
            // Deep Mood
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: Text(
                'Deep Mood',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DiscoverTile(label: 'cultivating joy'),
                  DiscoverTile(
                    label: 'stress',
                  ),
                  DiscoverTile(
                    label: 'intro',
                  ),
                  DiscoverTile(
                    label: 'intro',
                  ),
                ],
              ),
            ),
            // Music for the Soul
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: Text(
                'Music for the Soul',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DiscoverTile(label: 'ocean waves'),
                  DiscoverTile(
                    label: 'rainforest',
                  ),
                  DiscoverTile(
                    label: 'summer',
                  ),
                  DiscoverTile(
                    label: 'water',
                  ),
                  DiscoverTile(label: 'galaxy')
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }
}
