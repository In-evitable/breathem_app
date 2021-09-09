import 'package:breathem_app/home/widgets/sleeptiles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/covers/night.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(10, 10, 40, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Good Night',
                        style: TextStyle(
                            fontFamily: 'Karla',
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(3.25),
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 15, bottom: 30),
                      child: Text(
                        'Your bedtime routine starts here.',
                        style: TextStyle(
                            fontFamily: 'Karla',
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: Colors.white60),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'SLEEP MUSIC',
                        style: TextStyle(
                            fontFamily: 'Karla',
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2.5),
                            color: Colors.white70),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SleepTrack(text: 'stress'),
                              SleepTrack(
                                text: 'cultivating joy',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SleepTrack(
                                text: 'freedom',
                              ),
                              SleepTrack(
                                text: 'cultivating joy',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
