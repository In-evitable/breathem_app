import 'package:breathem_app/authentication/auth.dart';
import 'package:breathem_app/authentication/storage_manager.dart';
import 'package:breathem_app/authentication/signin.dart';
import 'package:breathem_app/home/navigation/leaderboard.dart';
import 'package:breathem_app/home/widgets/profile_selector.dart';
import 'package:breathem_app/provider/favourites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../splash.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key) {
    getFavouriteMap();
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

profileFunction() async {
  print(await StorageManager.getProfile());
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        shape: Border(
            bottom: BorderSide(
                color: darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0),
                width: 1)),
        backgroundColor:
            darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
        shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
        leading: new IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/images/svg/fi-rr-angle-left.svg',
              height: ResponsiveFlutter.of(context).scale(25),
              width: ResponsiveFlutter.of(context).scale(25),
              color: darkModeOn ? Colors.white : Colors.black,
            )),
        actions: [
          Container(
            padding: EdgeInsets.all(7),
            child: new IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Leaderboard()));
                },
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-podium.svg',
                  height: ResponsiveFlutter.of(context).scale(25),
                  width: ResponsiveFlutter.of(context).scale(25),
                  color: darkModeOn ? Colors.white : Colors.black,
                )),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              color: darkModeOn ? Colors.white : Colors.black,
              fontSize: ResponsiveFlutter.of(context).fontSize(2),
              fontFamily: 'Karla'),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Change profile function
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileSelector()))
                          .then((value) {
                        setState(() {});
                        print('refresh done');
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(234, 87, 79, 1.0),
                          borderRadius: BorderRadius.circular(100)),
                      child: SvgPicture.asset(
                          'assets/images/svg/fi-rr-pencil.svg'),
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.width - 220,
                width: MediaQuery.of(context).size.width - 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/profile/${Constants.MyProfile}.png'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  convertToTitleCase(Constants.MyName)!,
                  style: TextStyle(
                      color: darkModeOn ? Colors.white : Colors.black,
                      fontFamily: 'Karla',
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  Constants.MyEmail,
                  style: TextStyle(
                      color: darkModeOn ? Colors.white : Colors.black,
                      fontFamily: 'Karla',
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('points')
                      .doc('${Constants.MyName}_${Constants.MyEmail}')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return new Text(
                        'Error fetching data',
                        style: TextStyle(
                            color: darkModeOn ? Colors.white : Colors.black,
                            fontFamily: 'Karla',
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2.2)),
                      );
                    }
                    var userDocument = snapshot.data;
                    return Text(
                      'Your Points: ${userDocument!["points"]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: darkModeOn ? Colors.white : Colors.black,
                          fontFamily: 'Karla',
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  // TODO: sign out
                  AuthMethods authMethods = new AuthMethods();
                  authMethods.signOut();
                  StorageManager.saveLoggedIn(false);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(234, 87, 79, 1.0),
                  ),
                  child: Text('Log Out',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
