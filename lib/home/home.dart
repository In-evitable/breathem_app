import 'package:breathem_app/home/navigation/favourites.dart';
import 'package:breathem_app/home/widgets/emoji.dart';
import 'package:breathem_app/home/widgets/search.dart';
import 'package:breathem_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:breathem_app/home/navigation/home.dart';
import 'package:breathem_app/home/navigation/meditation.dart';
import 'package:breathem_app/home/navigation/sleep.dart';
import 'package:breathem_app/home/navigation/exercise.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import 'appbar/profile.dart';

int currentIndex = 0;
bool sleep = false;
bool exercise = false;

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigationTabs = [
    HomePage(),
    MeditationPage(),
    SleepPage(),
    ExercisePage(),
    FavouritesPage()
  ];

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initGoogleMobileAds();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = sleep ? true : (brightness == Brightness.dark);

    return Scaffold(
        extendBodyBehindAppBar: exercise,
        appBar: exercise
            ? AppBar(
                elevation: 0,
                // shape: Border(
                //     bottom: BorderSide(
                //         color:
                //             darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0),
                //         width: 1)),
                backgroundColor: Colors.transparent,
                // shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
                actions: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: new IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          icon: SvgPicture.asset(
                            'assets/images/svg/fi-rr-search.svg',
                            height: ResponsiveFlutter.of(context).scale(25),
                            width: ResponsiveFlutter.of(context).scale(25),
                            color: Colors.white,
                          )))
                ],
                leading: Container(
                  child: new IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/svg/fi-rr-user.svg',
                        height: ResponsiveFlutter.of(context).scale(25),
                        width: ResponsiveFlutter.of(context).scale(25),
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                        moodText = 'What do you feel like?';
                      }),
                ))
            : AppBar(
                shape: Border(
                    bottom: BorderSide(
                        color: darkModeOn
                            ? Colors.white
                            : Color.fromRGBO(0, 0, 0, 0),
                        width: 1)),
                backgroundColor: sleep
                    ? Color.fromRGBO(10, 10, 50, 1)
                    : !darkModeOn
                        ? Colors.white
                        : Color.fromRGBO(10, 10, 50, 1),
                shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
                actions: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: new IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          icon: SvgPicture.asset(
                            'assets/images/svg/fi-rr-search.svg',
                            height: ResponsiveFlutter.of(context).scale(25),
                            width: ResponsiveFlutter.of(context).scale(25),
                            color: darkModeOn ? Colors.white : Colors.black,
                          )))
                ],
                leading: Container(
                  child: new IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/svg/fi-rr-user.svg',
                        height: ResponsiveFlutter.of(context).scale(25),
                        width: ResponsiveFlutter.of(context).scale(25),
                        color: darkModeOn ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                        moodText = 'What do you feel like?';
                      }),
                )),
        body: NavigationTabs[currentIndex],
        bottomNavigationBar: Container(
          decoration: darkModeOn
              ? BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 1.0)))
              : null,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            backgroundColor:
                darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-home.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: currentIndex == 0
                      ? Color.fromRGBO(234, 87, 79, 1.0)
                      : darkModeOn
                          ? Colors.white
                          : Colors.black54,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-headphones.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: currentIndex == 1
                      ? Color.fromRGBO(234, 87, 79, 1.0)
                      : darkModeOn
                          ? Colors.white
                          : Colors.black54,
                ),
                label: 'Lessons',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-moon.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: currentIndex == 2
                      ? Color.fromRGBO(234, 87, 79, 1.0)
                      : darkModeOn
                          ? Colors.white
                          : Colors.black54,
                ),
                label: 'Sleep',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-gym.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: currentIndex == 3
                      ? Color.fromRGBO(234, 87, 79, 1.0)
                      : darkModeOn
                          ? Colors.white
                          : Colors.black54,
                ),
                label: 'Exercise',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-heart.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: currentIndex == 4
                      ? Color.fromRGBO(234, 87, 79, 1.0)
                      : darkModeOn
                          ? Colors.white
                          : Colors.black54,
                ),
                label: 'Favourites',
              ),
            ],
            onTap: (index) => {
              setState(() {
                currentIndex = index;
                if (index != 0) {
                  voted = false;
                  moodText = 'What do you feel like?';
                }
                if (index == 2) {
                  sleep = true;
                } else {
                  sleep = false;
                }
                if (index == 3) {
                  exercise = true;
                } else {
                  exercise = false;
                }
              })
            },
          ),
        ));
  }
}
