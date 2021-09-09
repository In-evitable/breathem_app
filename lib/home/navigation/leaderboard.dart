import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:breathem_app/home/widgets/checkout_help.dart';
import 'package:breathem_app/home/widgets/points_help.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../main.dart';
import '../../splash.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: basicAppBar(context, 'Leaderboard'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(3),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('points')
                    .orderBy('points', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return AccountRank(
                              name: (Constants.MyName ==
                                      snapshot.data.docs[index].data()['name'])
                                  ? 'Me'
                                  : convertToTitleCase(snapshot.data.docs[index]
                                      .data()['name'])!,
                              place: index + 1,
                              points:
                                  snapshot.data.docs[index].data()['points']);
                        });
                  } else {
                    return Container();
                  }
                }),
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
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text(
                      'Error fetching data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: darkModeOn ? Colors.white : Colors.black,
                          fontFamily: 'Karla',
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                    ),
                  );
                }
                var userDocument = snapshot.data;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Text(
                    'Your Points: ${userDocument!["points"]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkModeOn ? Colors.white : Colors.black,
                        fontFamily: 'Karla',
                        fontSize: ResponsiveFlutter.of(context).fontSize(3)),
                  ),
                );
              }),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckoutHelp()));
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: EdgeInsets.only(top: 20, bottom: 20),
                // height: ResponsiveFlutter.of(context).scale(60),
                width: ResponsiveFlutter.of(context).scale(175),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.5),
                  color: Color.fromRGBO(244, 55, 85, 1.0),
                ),
                child: Text('Checkout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.5))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Feeling Lost?',
                style: TextStyle(
                    fontFamily: 'Karla',
                    color: darkModeOn ? Colors.white : Colors.black87,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PointsHelp()));
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text('Help',
                        style: TextStyle(
                            fontFamily: 'Karla',
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            color: Color.fromRGBO(234, 87, 79, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2.5)))),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AccountRank extends StatefulWidget {
  final int place;
  final String name;
  final int points;

  const AccountRank(
      {required this.name, required this.place, required this.points});

  @override
  _AccountRankState createState() => _AccountRankState();
}

class _AccountRankState extends State<AccountRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: darkModeOn ? Colors.white : Color.fromRGBO(0, 0, 0, 0.4)),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            child: Text(
              '#${widget.place}  ',
              style: TextStyle(
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
            ),
          ),
          Container(
            child: Text(
              widget.name,
              style: TextStyle(
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${widget.points}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
