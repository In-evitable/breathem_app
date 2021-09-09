import 'package:breathem_app/authentication/auth.dart';
import 'package:breathem_app/authentication/database.dart';
import 'package:breathem_app/authentication/storage_manager.dart';
import 'package:breathem_app/home/home.dart';
import 'package:breathem_app/main.dart';
import 'package:breathem_app/templates/style.dart';
import 'package:flutter/material.dart';
import 'package:breathem_app/authentication/signin.dart';
import 'package:lottie/lottie.dart';
import 'package:breathem_app/splash.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  String authError = '';
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) async {
        print(value.toString());

        loading = false;
        authError = 'The email address is already in use by another account';

        Map<String, String> userInfoMap = {
          'name': usernameController.text,
          'email': emailController.text
        };

        if (value != null) {
          loading = true;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          StorageManager.saveLoggedIn(true);
          StorageManager.saveEmail(emailController.text);
          StorageManager.saveUsername(usernameController.text);

          Constants.MyName = usernameController.text;
          Constants.MyEmail = emailController.text;
          databaseMethods.uploadUser(userInfoMap);
          await databaseMethods.uploadPoints(
              emailController.text, usernameController.text, 0);
          authError = '';
        }
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: loading
            ? Container(
                child: Lottie.asset('assets/animations/loading-wobble.json'))
            : ListView(shrinkWrap: true, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // Already have an account Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: darkModeOn ? Colors.white : Colors.black87,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.7)),
                      ),
                      GestureDetector(
                        onTap: () {
                          // link to sign in screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text('Sign In',
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
                    'Welcome to Breathem',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Create an account to get started',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),
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
                                if (value!.isEmpty) {
                                  return 'Please enter a name';
                                } else {
                                  return null;
                                }
                              },
                              controller: usernameController,
                              decoration:
                                  textFieldDecoration('Username', context),
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(1.5)),
                            ),
                          ),
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
                              controller: emailController,
                              decoration:
                                  textFieldDecoration('Email address', context),
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(1.5)),
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
                              decoration: textFieldDecoration(
                                  'Password (8+ characters)', context),
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(1.5)),
                              obscureText: true,
                            ),
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(234, 87, 79, 1.0),
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.white,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.9))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Text(
                      authError,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.red,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.9)),
                    ),
                  ),
                ]),
              ]),
      ),
    );
  }
}
