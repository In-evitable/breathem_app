import 'package:breathem_app/authentication/signin.dart';
import 'package:breathem_app/home/widgets/audio.dart';
import 'package:breathem_app/home/widgets/emoji.dart';
import 'package:breathem_app/home/widgets/discover.dart';
import 'package:breathem_app/home/widgets/tiles.dart';
import 'package:breathem_app/home/widgets/unlock.dart';
import 'package:breathem_app/home/widgets/video.dart';
import 'package:breathem_app/provider/mood.dart';
import 'package:breathem_app/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../main.dart';
import 'dart:math';

Random random = new Random();

int randomNumber(int max) {
  return random.nextInt(max);
} // from 0 up to $max included

String moodText = 'What do you feel like?';

// TODO: Complete mood comments
List lovedComments = [
  'Lucky you!',
  'Love is a blessing!',
  'Now listen to something to keep you shinin\'!',
  'I can feel those vibes!',
  'Keep smiling, you lucky person!',
];
List veryHappyComments = [
  'I\'m jealous of that positive energy!',
  'Wish everyone was like you!',
  'We need to keep these vibes running!',
  'You truly feel like a happy person!',
  'Don\'t let anyone ruin your day!'
];
List happyComments = [
  'I\'m jealous of that positive energy!',
  'Wish everyone was like you!',
  'We need to keep these vibes running',
  'You truly feel like a happy person!',
  'Don\'t let anyone ruin your day!'
];
List averageComments = [
  'Let\'s cheer you up some more!',
  'Relax for a better mood!',
  'Every day needs to be special!',
  'Perhaps all you need is the magic of meditation!',
  'Maybe a hint of relaxation will do the job!'
];
List sadComments = [
  'Hope you feel better, buddy!',
  'Check out some Music For The Soul!',
  'At least you don\'t have mood swings!',
  'Conjure up a happy memory. I\'m sure that would do the magic!',
  'Maybe some exercises will help.',
];
List angryComments = [
  'Calm down, dude!',
  'At least you don\'t have mood swings!',
  'Breathe In. Breathe Out. How do you feel now?',
  'Conjure up a happy memory. I\'m sure that would do the magic!',
  'Meditation is the solution!',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

var initializationSettingsAndroid;
var initializationSettingsIOS;
var initializationSettings;

Future<void> showNotification(
    int index, String title, String body, String payload) async {
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    body,
    htmlFormatBigText: true,
    contentTitle: title,
    htmlFormatContentTitle: true,
    htmlFormatSummaryText: true,
  );

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name', 'channeld escription',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'testTicker',
      styleInformation: bigTextStyleInformation);

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(index, title, body, platformChannelSpecifics, payload: payload);
}

Future onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('Notification payload: $payload');
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title!),
              content: Text(body!),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Ok'),
                    onPressed: () async {
                      print('notification redirect');
                    })
              ],
            ));
  }

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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                Constants.MyName != null
                    ? 'Hello, ${convertToTitleCase(Constants.MyName)}!'
                    : 'Hello!',
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontFamily: 'Karla',
                    fontSize: ResponsiveFlutter.of(context).fontSize(2.1),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // Discover
                DiscoverTile(label: 'intro'),
                DiscoverTile(
                  label: 'deep breathing',
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
        ),
        /*
        CupertinoButton.filled(
            child: Text('Vedio'),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                                title: 'Rick Ashley',
                                video: 'rick.mp4',
                              )))
                  .then((value) => SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]));
            }),
            */
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            moodText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: darkModeOn ? Colors.white : Colors.black,
                fontFamily: 'Karla',
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 12),
            child: Row(
              children: [
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(254, 218, 82, 1),
                    Color.fromRGBO(254, 195, 30, 1)
                  ],
                  asset: 'assets/images/png/loved.png',
                  label: 'Loved',
                  onTap: () {
                    print('Loved');
                    setState(() {});
                    setMood('loved');
                  },
                  moodList: lovedComments,
                ),
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(254, 195, 30, 1),
                    Color.fromRGBO(253, 155, 79, 1)
                  ],
                  asset: 'assets/images/png/very_happy.png',
                  label: 'Very Happy',
                  onTap: () {
                    print('Very Happy');
                    setState(() {});
                    setMood('very happy');
                  },
                  moodList: veryHappyComments,
                ),
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(253, 155, 79, 1),
                    Color.fromRGBO(247, 124, 90, 1)
                  ],
                  asset: 'assets/images/png/happy.png',
                  label: 'Happy',
                  onTap: () {
                    print('Happy');
                    setState(() {});
                    setMood('happy');
                  },
                  moodList: happyComments,
                ),
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(255, 104, 70, 1),
                    Color.fromRGBO(252, 121, 96, 1)
                  ],
                  asset: 'assets/images/png/average.png',
                  label: 'Average',
                  onTap: () {
                    print('Average');
                    setState(() {});
                    setMood('average');
                  },
                  moodList: averageComments,
                ),
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(252, 121, 96, 1),
                    Color.fromRGBO(244, 55, 85, 1)
                  ],
                  asset: 'assets/images/png/sad.png',
                  label: 'Sad',
                  onTap: () {
                    print('Sad');
                    setState(() {});
                    setMood('sad');
                  },
                  moodList: sadComments,
                ),
                Emoji(
                  gradientColors: [
                    Color.fromRGBO(244, 55, 85, 1),
                    Color.fromRGBO(223, 80, 36, 1)
                  ],
                  asset: 'assets/images/png/angry.png',
                  label: 'Angry',
                  onTap: () {
                    print('Angry');
                    setState(() {});
                    setMood('angry');
                  },
                  moodList: angryComments,
                )
              ],
            ),
          ),
        ),
        /*
        MaterialButton(
          onPressed: () {
            databaseMethods.uploadPoints(Constants.MyEmail, 0);
          },
          child: Text('upload ${Constants.MyEmail}\'s points to 0'),
        ),
        MaterialButton(
          onPressed: () async {
            print(
                'points: ${await databaseMethods.getPoints(Constants.MyEmail)}');
          },
          child: Text('get ${Constants.MyEmail}\'s points'),
        ),
        MaterialButton(
          onPressed: () async {
            databaseMethods.updatePoints(Constants.MyEmail,
                (await databaseMethods.getPoints(Constants.MyEmail)) + 10);
          },
          child: Text('update ${Constants.MyEmail}\'s points by +10'),
        ),
        */
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 5, left: 20),
          child: Text(
            'Time to unwind',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: darkModeOn ? Colors.white : Colors.black,
                fontFamily: 'Karla',
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 12.5, right: 5, top: 5, bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  TileTrack(text: 'stress'),
                  TileTrack(
                    text: 'cultivating joy',
                  ),
                ],
              ),
              Row(
                children: [
                  TileTrack(
                    text: 'freedom',
                  ),
                  TileTrack(
                    text: 'cultivating joy',
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
