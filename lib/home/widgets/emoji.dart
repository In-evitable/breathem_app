import 'package:breathem_app/home/navigation/home.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Emoji extends StatefulWidget {
  final List<Color> gradientColors;
  final String asset;
  final String label;
  final List moodList;
  final VoidCallback onTap;

  Emoji(
      {required this.gradientColors,
      required this.asset,
      required this.label,
      required this.onTap,
      required this.moodList});

  @override
  _EmojiState createState() => _EmojiState();
}

bool voted = false;

class _EmojiState extends State<Emoji> {

  bool animation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!voted) {
          widget.onTap();
          setState(() {
            animation = true;
            voted = true;
            moodText = widget.moodList[randomNumber(widget.moodList.length)];
          });
        }
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Image.asset(
              widget.asset,
              height: ResponsiveFlutter.of(context).scale(40),
              width: ResponsiveFlutter.of(context).scale(40),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GradientText(widget.label,
                    colors: widget.gradientColors,
                    style: TextStyle(
                        fontFamily: 'Karla',
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        fontWeight: FontWeight.bold)))
          ],
        ),
        decoration: BoxDecoration(
          color: !animation ? Colors.white : Colors.green,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
