import 'dart:async';
import 'dart:math' as math;
import 'package:breathem_app/authentication/database.dart';
import 'package:breathem_app/home/navigation/home.dart';
import 'package:breathem_app/provider/ad_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:video_player/video_player.dart';
import '../../main.dart';
import '../../splash.dart';

bool videoPressed = false;
bool setVideosWatched = false;

InterstitialAd? _interstitialAd;
bool _isInterstitialAdReady = false;

void _loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: AdHelper.interstitialAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        _interstitialAd = ad;

        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            print('ad close go brr');
          },
        );

        _isInterstitialAdReady = true;
      },
      onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
        _isInterstitialAdReady = false;
      },
    ),
  );
}

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String video;

  VideoPlayerScreen({required this.title, required this.video}) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _loadInterstitialAd();
  }

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

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
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/videos/${widget.video}');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(false);

    _controller.addListener(() async {
      if (_controller.value.position ==
          Duration(seconds: 0, minutes: 0, hours: 0)) {
        print('Video Started!');
      }

      if (_controller.value.position == _controller.value.duration) {
        print('Video Finished!');
        DatabaseMethods databaseMethods = new DatabaseMethods();
        if (!videoPressed) {
          await databaseMethods.increasePoints(
              Constants.MyEmail, Constants.MyName, 10);
          showNotification(
              2,
              'Reward',
              '10 points have been added to your Breathem account.',
              'video notification');
        }
        if (Constants.videosWatched >= 2) {
          print('Ad supposed to show');
          print('videosWatched: ${Constants.videosWatched}');
        }
      }
    });

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

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    // try {
    //   _interstitialAd?.dispose();
    // } catch (e) {
    //   print('Ad dispose error: ${e.toString()}');
    // }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.landscape
          ? null // show nothing in landscape mode
          : AppBar(
              shape: Border(
                  bottom: BorderSide(
                      color: darkModeOn
                          ? Colors.white
                          : Color.fromRGBO(0, 0, 0, 0),
                      width: 1)),
              backgroundColor:
                  darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
              shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
              leading: new IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/fi-rr-angle-small-left.svg',
                    height: ResponsiveFlutter.of(context).scale(25),
                    width: ResponsiveFlutter.of(context).scale(25),
                    color: darkModeOn ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    if (!setVideosWatched) {
                      Constants.videosWatched++;
                      setVideosWatched = true;
                    }
                    if (Constants.videosWatched >= 2) {
                      print('videosWatched is ${Constants.videosWatched}');
                      if (_isInterstitialAdReady) {
                        print('ad is ready');
                        _interstitialAd?.show();
                      } else {
                        print('ad is not ready');
                      }
                      Constants.videosWatched = 0;
                    } else {
                      print(
                          "condition failed, videosWatched are ${Constants.videosWatched}");
                    }
                    Navigator.pop(context);
                  }),
              centerTitle: true,
              title: Text(
                convertToTitleCase(widget.title).toString(),
                style: TextStyle(
                    color: darkModeOn ? Colors.white : Colors.black,
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontFamily: 'Karla'),
              ),
            ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: ListView(shrinkWrap: true, children: [
        SizedBox(
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? 0
              : 60,
        ),
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: darkModeOn
                        ? Border.all(color: Colors.white, width: 2)
                        : Border.all()),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: ClipRRect(
                    child: AspectRatio(
                      // get the aspect ratio of the video
                      aspectRatio: _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video
                      child: VideoPlayer(_controller),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  convertToTitleCase(widget.title).toString(),
                  style: TextStyle(
                      fontFamily: 'Karla',
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      fontWeight: FontWeight.bold,
                      color: !darkModeOn ? Colors.black : Colors.white),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _controller
                      .seekTo((Duration(minutes: 0, seconds: 0, hours: 0)));
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-rewind.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: darkModeOn ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _controller.seekTo(
                        (_controller.value.position - Duration(seconds: 5)));
                    setState(() {});
                  },
                  icon: Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: SvgPicture.asset(
                      'assets/images/svg/fi-rr-play.svg',
                      height: ResponsiveFlutter.of(context).scale(15),
                      width: ResponsiveFlutter.of(context).scale(15),
                      color: darkModeOn ? Colors.white : Colors.black,
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: !darkModeOn
                            ? Color.fromRGBO(234, 87, 79, 1)
                            : Colors.white,
                        width: 2),
                    color: darkModeOn ? Colors.white : Colors.white),
                child: _controller.value.isPlaying
                    ? IconButton(
                        onPressed: () {
                          _controller.pause();
                          setState(() {});
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/fi-sr-pause.svg',
                          height: ResponsiveFlutter.of(context).scale(20),
                          width: ResponsiveFlutter.of(context).scale(20),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          _controller.play();
                          setState(() {});
                        },
                        icon: SvgPicture.asset(
                          'assets/images/svg/fi-sr-play.svg',
                          height: ResponsiveFlutter.of(context).scale(20),
                          width: ResponsiveFlutter.of(context).scale(20),
                        )),
              ),
              IconButton(
                onPressed: () {
                  _controller.seekTo(
                      (_controller.value.position + Duration(seconds: 5)));
                  videoPressed = true;
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-play.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: darkModeOn ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  _controller.seekTo((_controller.value.duration));
                  videoPressed = true;
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  'assets/images/svg/fi-rr-forward.svg',
                  height: ResponsiveFlutter.of(context).scale(15),
                  width: ResponsiveFlutter.of(context).scale(15),
                  color: darkModeOn ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20)
      ]),
    );
  }
}
