import 'package:breathem_app/authentication/database.dart';
import 'package:breathem_app/home/appbar/appbar.dart';
import 'package:breathem_app/home/navigation/home.dart';
import 'package:breathem_app/main.dart';
import 'package:breathem_app/provider/ad_helper.dart';
import 'package:breathem_app/provider/unlock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../splash.dart';
import 'audio.dart';

late RewardedAd _rewardedAd;

bool _isRewardedAdReady = false;

// TODO: Implement _loadRewardedAd()
void _loadRewardedAd() {
  RewardedAd.load(
    adUnitId: AdHelper.rewardedAdUnitId,
    request: AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        _rewardedAd = ad;

        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            _isRewardedAdReady = false;

            _loadRewardedAd();
          },
        );

        _isRewardedAdReady = true;
      },
      onAdFailedToLoad: (err) {
        print('Failed to load a rewarded ad: ${err.message}');

        _isRewardedAdReady = false;
      },
    ),
  );
}

class Unlock extends StatefulWidget {
  final String poster;
  final String name;
  final String localFileName;
  Unlock(
      {Key? key,
      required this.poster,
      required this.name,
      required this.localFileName})
      : super(key: key) {
    _loadRewardedAd();
  }

  @override
  _UnlockState createState() => _UnlockState();
}

class _UnlockState extends State<Unlock> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
        appBar: basicAppBar(context, 'Unlock'),
        body: ListView(
          shrinkWrap: true,
          children: [
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
            SizedBox(
              height: 20,
            ),
            Text(
              'To unlock this track...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkModeOn ? Colors.white : Colors.black,
                  fontFamily: 'Karla',
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                  fontWeight: FontWeight.bold),
            ),
            // watch an ad button
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _rewardedAd.show(
                      onUserEarnedReward: (rewardedAd, rewardedItem) {
                    setUnlock(widget.name, true);
                    audioPressed = false;
                    setAudiosWatched = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AudioPage(
                                  unlock: true,
                                  poster: widget.poster,
                                  name: widget.name,
                                  localFileName: widget.localFileName,
                                  parentFunction: () {},
                                )));
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20, right: 60, left: 60),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: darkModeOn
                          ? Color.fromRGBO(10, 10, 50, 1)
                          : Colors.white,
                      border: Border.all(
                          color:
                              darkModeOn ? Colors.white : Constants.mainColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Watch a video ad',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: 'Karla',
                            color: darkModeOn ? Colors.white : Colors.black),
                      ),
                      SizedBox(width: 15),
                      SvgPicture.asset(
                        'assets/images/svg/fi-rr-film.svg',
                        color: darkModeOn ? Colors.white : Constants.mainColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  DatabaseMethods databaseMethods = new DatabaseMethods();
                  if ((await databaseMethods.getPoints(
                          Constants.MyEmail, Constants.MyName)) >=
                      10) {
                    print('condition is true');
                    databaseMethods.decreasePoints(
                        Constants.MyEmail, Constants.MyName, 10);
                    setUnlock(widget.name, true);
                    audioPressed = false;
                    setAudiosWatched = false;
                    showNotification(
                        3,
                        'Transaction',
                        'Transaction successful. 10 points have been deducted from your account. You now have ${(await databaseMethods.getPoints(Constants.MyEmail, Constants.MyName)) - 10} points.',
                        'payload');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AudioPage(
                                  unlock: true,
                                  poster: widget.poster,
                                  name: widget.name,
                                  localFileName: widget.localFileName,
                                  parentFunction: () {},
                                )));
                  } else {
                    showNotification(
                        4,
                        'Transaction',
                        'Transaction failed. Check if you have an internet connection and enough points.',
                        'payload');
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin:
                      EdgeInsets.only(top: 20, bottom: 40, right: 60, left: 60),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: darkModeOn
                          ? Color.fromRGBO(10, 10, 50, 1)
                          : Colors.white,
                      border: Border.all(
                          color:
                              darkModeOn ? Colors.white : Constants.mainColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Use 10 points',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            fontFamily: 'Karla',
                            color: darkModeOn ? Colors.white : Colors.black),
                      ),
                      SizedBox(width: 15),
                      SvgPicture.asset(
                        'assets/images/svg/fi-rr-money.svg',
                        color: darkModeOn ? Colors.white : Constants.mainColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
