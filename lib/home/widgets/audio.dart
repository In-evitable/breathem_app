import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:breathem_app/authentication/signin.dart';
import 'package:breathem_app/home/navigation/home.dart';
import 'package:breathem_app/provider/ad_helper.dart';
import 'package:breathem_app/provider/favourites.dart';
import 'package:breathem_app/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math' as math;
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../main.dart';

AudioCache audioCache = new AudioCache();
AudioPlayer advancedPlayer = new AudioPlayer();
Duration _duration = new Duration();
Duration _position = new Duration();
bool playing = false;
bool audioPressed = false;
bool setAudiosWatched = false;

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

class AudioPage extends StatefulWidget {
  final String poster;
  final String name;
  final String localFileName;
  final VoidCallback parentFunction;
  final bool unlock;
  String heartIcon = 'assets/images/svg/fi-rr-heart.svg';
  Color heartColor = !darkModeOn ? Colors.black : Colors.white;

  AudioPage(
      {required this.poster,
      required this.name,
      required this.localFileName,
      required this.parentFunction,
      required bool this.unlock}) {
    _position = Duration(seconds: 0);
    _loadInterstitialAd();
  }

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  Widget slider() {
    setState(() {});
    return Slider(
        activeColor: Color.fromRGBO(234, 87, 79, 1),
        inactiveColor: Color.fromRGBO(234, 87, 79, 0.25),
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble() != null
            ? _duration.inSeconds.toDouble()
            : 0,
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
            audioPressed = false;
          });
        });
  }

  _favourite() async {
    if (await getFavourite(widget.name) == true) {
      widget.heartIcon = 'assets/images/svg/fi-sr-heart.svg';
      widget.heartColor = Color.fromRGBO(234, 87, 79, 1);
      setState(() {});
    } else if (await getFavourite(widget.name) == false) {
      widget.heartIcon = 'assets/images/svg/fi-rr-heart.svg';
      widget.heartColor = !darkModeOn ? Colors.black : Colors.white;
      setState(() {});
    } else {
      widget.heartIcon = 'assets/images/svg/fi-rr-heart.svg';
      widget.heartColor = !darkModeOn ? Colors.black : Colors.white;
      setState(() {});
    }
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
  void initState() {
    super.initState();
    initPlayer();
    print('checking favourites...');
    _favourite();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onDurationChanged.listen((d) => setState(() {
          _duration = d;
        }));

    advancedPlayer.onAudioPositionChanged.listen((p) => setState(() {
          _position = p;
        }));

    advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() async {
        _position = Duration(seconds: 0);
        playing = false;
        if (!audioPressed) {
          await databaseMethods.increasePoints(
              Constants.MyEmail, Constants.MyName, 15);
          showNotification(
              1,
              'Reward',
              '15 points have been added to your Breathem account.',
              'audio notification');
        }
      });
    });
  }

  void seekToSecond(int second) {
    {
      try {
        Duration newDuration = Duration(seconds: second);
        advancedPlayer.seek(newDuration);
      } catch (e) {
        print('seekToSecond error: ${e.toString()}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: !darkModeOn
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(10, 10, 50, 1),
            appBar: AppBar(
                shape: Border(
                    bottom: BorderSide(
                        color: darkModeOn
                            ? Colors.white
                            : Color.fromRGBO(0, 0, 0, 0),
                        width: 1)),
                backgroundColor:
                    darkModeOn ? Color.fromRGBO(10, 10, 50, 1) : Colors.white,
                shadowColor: darkModeOn ? Colors.black12 : Colors.black26,
                leading: Container(
                  child: new IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/svg/fi-rr-angle-small-left.svg',
                        height: ResponsiveFlutter.of(context).scale(25),
                        width: ResponsiveFlutter.of(context).scale(25),
                        color: darkModeOn ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        advancedPlayer.stop();
                        playing = false;
                        if (!setAudiosWatched) {
                          Constants.audiosWatched++;
                          setAudiosWatched = true;
                        }
                        if (Constants.audiosWatched >= 2) {
                          print('audiosWatched is ${Constants.audiosWatched}');
                          if (_isInterstitialAdReady) {
                            print('ad is ready');
                            _interstitialAd?.show();
                          } else {
                            print('ad is not ready');
                          }
                          Constants.audiosWatched = 0;
                        } else {
                          print(
                              "condition failed, audiosWatched are ${Constants.audiosWatched}");
                        }
                        if (widget.unlock) {
                          Navigator.pop(context, () {
                            setState(() {});
                          });
                          Navigator.pop(context, () {
                            setState(() {});
                          });
                        } else {
                          Navigator.pop(context, () {
                            setState(() {});
                          });
                        }
                      }),
                )),
            body: // Implement your widget here
                Container(
              child: ListView(shrinkWrap: true, children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width - 70,
                    width: MediaQuery.of(context).size.width - 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: Image.asset(widget.poster),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          convertToTitleCase(widget.name).toString(),
                          style: TextStyle(
                              fontFamily: 'Karla',
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontWeight: FontWeight.bold,
                              color: !darkModeOn ? Colors.black : Colors.white),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: ResponsiveFlutter.of(context).scale(30),
                            width: ResponsiveFlutter.of(context).scale(30),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (widget.heartIcon ==
                                        'assets/images/svg/fi-rr-heart.svg') {
                                      widget.heartIcon =
                                          'assets/images/svg/fi-sr-heart.svg';
                                      setFavourite(widget.name, true);
                                    } else {
                                      widget.heartIcon =
                                          'assets/images/svg/fi-rr-heart.svg';
                                    }
                                    if (widget.heartColor == Colors.black ||
                                        widget.heartColor == Colors.white) {
                                      widget.heartColor =
                                          Color.fromRGBO(234, 87, 79, 1);
                                      setFavourite(widget.name, true);
                                    } else {
                                      if (darkModeOn) {
                                        widget.heartColor = Colors.white;
                                        setFavourite(widget.name, false);
                                      } else {
                                        widget.heartColor = Colors.black;
                                        setFavourite(widget.name, false);
                                      }
                                    }
                                  });
                                  widget.parentFunction();
                                },
                                icon: SvgPicture.asset(
                                  widget.heartIcon,
                                  height:
                                      ResponsiveFlutter.of(context).scale(30),
                                  width:
                                      ResponsiveFlutter.of(context).scale(30),
                                  color: widget.heartColor,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: slider(),
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          seekToSecond(0);
                          audioCache.play(widget.localFileName);
                          setState(() {
                            playing = true;
                          });
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
                            seekToSecond(_position.inSeconds - 5);
                            audioCache.play(widget.localFileName);
                            setState(() {
                              playing = true;
                            });
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
                        child: playing
                            ? IconButton(
                                onPressed: () {
                                  advancedPlayer.pause();
                                  setState(() {
                                    playing = false;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/svg/fi-sr-pause.svg',
                                  height:
                                      ResponsiveFlutter.of(context).scale(20),
                                  width:
                                      ResponsiveFlutter.of(context).scale(20),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  audioCache.play(widget.localFileName);

                                  setState(() {
                                    playing = true;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/svg/fi-sr-play.svg',
                                  height:
                                      ResponsiveFlutter.of(context).scale(20),
                                  width:
                                      ResponsiveFlutter.of(context).scale(20),
                                )),
                      ),
                      IconButton(
                        onPressed: () {
                          seekToSecond(_position.inSeconds + 5);
                          audioCache.play(widget.localFileName);
                          setState(() {
                            playing = true;
                            audioPressed = true;
                          });
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
                          seekToSecond(_duration.inSeconds);
                          audioPressed = true;
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
            )));
  }
}
