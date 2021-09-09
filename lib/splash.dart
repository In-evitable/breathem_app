import 'package:breathem_app/authentication/signup.dart';
import 'package:breathem_app/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'authentication/storage_manager.dart';
import 'main.dart';

bool animation = false;
late bool darkModeOn;

String? convertToTitleCase(String text) {
  if (text == null) {
    return null;
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  getLoggedInState() async {
    try {
      await StorageManager.getLoggedIn().then((value) {
        setState(() {
          isLoggedIn = value!;
        });
      });
    } catch (e) {
      print('getLoggedInState() error: ${e.toString()}');
    }
  }

  setInfo() async {
    Constants.MyName = await StorageManager.getUsername() as String;
    Constants.MyEmail = await StorageManager.getEmail() as String;
    if (await StorageManager.getProfile() as String == null) {
      await StorageManager.saveProfile('apple');
      Constants.MyProfile = await StorageManager.getProfile() as String;
    } else {
      Constants.MyProfile = await StorageManager.getProfile() as String;
    }
    setState(() {});
  }

  @override
  void initState() {
    getLoggedInState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        animation = true;
      });
    });
    setInfo();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isLoggedIn ? HomeScreen() : SignUpScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        SizedBox(
          height: 600,
          child: OverflowBox(
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/animations/relaxing-bath.json',
            ),
          ),
        ),
        AnimatedDefaultTextStyle(
            child: Text('Relax'),
            style: animation
                ? TextStyle(
                    fontFamily: 'Karla',
                    fontSize: 35,
                    color: Color.fromRGBO(244, 89, 123, 1),
                    fontWeight: FontWeight.bold)
                : TextStyle(
                    fontFamily: 'Karla',
                    fontSize: 35 /**/,
                    color: Color.fromRGBO(244, 89, 123, 0),
                    fontWeight: FontWeight.bold),
            duration: Duration(seconds: 2))
      ]),
    );
  }
}
