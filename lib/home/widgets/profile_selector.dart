import 'package:breathem_app/authentication/storage_manager.dart';
import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:breathem_app/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../main.dart';

class ProfileSelector extends StatefulWidget {
  const ProfileSelector({Key? key}) : super(key: key);

  @override
  _ProfileSelectorState createState() => _ProfileSelectorState();
}

class _ProfileSelectorState extends State<ProfileSelector> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    String selected = Constants.MyProfile;

    return Scaffold(
        appBar:
      AppBar(
    shape: Border(
        bottom: BorderSide(
            color: darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0),
            width: 1)),
    backgroundColor: darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
    shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
    leading: new IconButton(
        icon: SvgPicture.asset(
          'assets/images/svg/fi-rr-angle-small-left.svg',
          height: ResponsiveFlutter.of(context).scale(25),
          width: ResponsiveFlutter.of(context).scale(25),
          color: darkModeOn ? Colors.white : Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
    centerTitle: true,
    title: Text(
      'Profile Selector',
      style: TextStyle(
          color: darkModeOn ? Colors.white : Colors.black,
          fontSize: ResponsiveFlutter.of(context).fontSize(2),
          fontFamily: 'Karla'),
    ),
  ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Choose your profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Karla',
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
              ),
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                GestureDetector(
                  onTap: () {
                    selected = 'apple';
                    StorageManager.saveProfile('apple');
                    Constants.MyProfile = 'apple';
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    height: ResponsiveFlutter.of(context).scale(125),
                    width: ResponsiveFlutter.of(context).scale(125),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: selected == 'apple'
                          ? Border.all(
                              color: Color.fromRGBO(244, 55, 85, 1.0), width: 5)
                          : Border(),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile/apple.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selected = 'pear';
                    StorageManager.saveProfile('pear');
                    Constants.MyProfile = 'pear';
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    height: ResponsiveFlutter.of(context).scale(125),
                    width: ResponsiveFlutter.of(context).scale(125),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: selected == 'pear'
                          ? Border.all(
                              color: Color.fromRGBO(244, 55, 85, 1.0), width: 5)
                          : Border(),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile/pear.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selected = 'strawberry';
                    StorageManager.saveProfile('strawberry');
                    Constants.MyProfile = 'strawberry';
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    height: ResponsiveFlutter.of(context).scale(125),
                    width: ResponsiveFlutter.of(context).scale(125),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: selected == 'strawberry'
                          ? Border.all(
                              color: Color.fromRGBO(244, 55, 85, 1.0), width: 5)
                          : Border(),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/profile/strawberry.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
