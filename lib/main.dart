import 'package:breathem_app/provider/favourites.dart';
import 'package:breathem_app/provider/theme_provider.dart';
import 'package:breathem_app/provider/unlock.dart';
import 'package:breathem_app/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  getFavouriteMap();
  getUnlockMap();
  runApp(MyApp());
}

class Constants {
  static String MyName = '';
  static String MyEmail = '';
  static String MyProfile = 'apple';
  static int videosWatched = 0;
  static int audiosWatched = 0;
  static const Color mainColor = Color.fromRGBO(254, 84, 79, 1);
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      title: 'App',
      themeMode: ThemeMode.system,
      theme: MainTheme.light,
      darkTheme: MainTheme.dark,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
