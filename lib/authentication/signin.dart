import 'package:breathem_app/authentication/database.dart';
import 'package:breathem_app/authentication/storage_manager.dart';
import 'package:breathem_app/home/home.dart';
import 'package:breathem_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:breathem_app/templates/style.dart';
import 'package:breathem_app/authentication/signup.dart';
import 'package:lottie/lottie.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
import 'auth.dart';
import 'package:breathem_app/splash.dart';

DatabaseMethods databaseMethods = new DatabaseMethods();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool loading = false;
  String authError = '';
  AuthMethods authMethods = new AuthMethods();
  QuerySnapshot? snapshotUserInfo;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signIn() async {
    if (formKey.currentState!.validate()) {
      StorageManager.saveEmail(emailController.text);
      setState(() {
        loading = true;
      });

      databaseMethods.getUserByEmail(emailController.text).then((value) {
        snapshotUserInfo = value;
        StorageManager.saveUsername(snapshotUserInfo!.docs[0]['name']);
        Constants.MyName = snapshotUserInfo!.docs[0]['name'];
        Constants.MyEmail = emailController.text;
      });

      authMethods
          .signInWithEmailAndPassword(
              emailController.text.trim(), passwordController.text)
          .then((value) {
        loading = false;
        authError = 'Invalid username or password';

        print(value.toString());

        if (value != null) {
          loading = true;
          databaseMethods
              .getUserByEmail(emailController.text)
              .then((value) async {
            snapshotUserInfo = value;
            StorageManager.saveUsername(snapshotUserInfo!.docs[0]['name']);
            Constants.MyName = snapshotUserInfo!.docs[0]['name'];
            Constants.MyEmail = emailController.text;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          authError = '';
          StorageManager.saveLoggedIn(true);
        }

        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
        body: Container(
      child: loading
          ? Container(
              alignment: Alignment.center,
              child: Lottie.asset('assets/animations/loading-wobble.json'))
          : Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Already have an account link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: darkModeOn ? Colors.white : Colors.black87,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.7)),
                        ),
                        GestureDetector(
                          onTap: () {
                            // link to sign up screen
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Color.fromRGBO(234, 87, 79, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.7)))),
                        )
                      ],
                    ),
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Log into your Breathem account',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.5)),
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!)) {
                                    return null;
                                  } else {
                                    return 'Please enter a valid email';
                                  }
                                },
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.5)),
                                controller: emailController,
                                decoration: textFieldDecoration(
                                    'Email address', context),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length >= 8 && value.length < 16) {
                                    return null;
                                  } else {
                                    return 'Please enter a valid password';
                                  }
                                },
                                controller: passwordController,
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.5)),
                                decoration:
                                    textFieldDecoration('Password', context),
                                obscureText: true,
                              ),
                            )
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        // TODO: sign in
                        signIn();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(234, 87, 79, 1.0),
                        ),
                        child: Text('Sign In',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                color: Colors.white,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      authError,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.red,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.9)),
                    ),
                  ]),
            ),
    ));
  }
}
