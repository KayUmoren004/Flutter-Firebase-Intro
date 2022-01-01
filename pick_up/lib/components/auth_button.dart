import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  final double radius;
  final double margin;

  const AuthButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
    required this.radius,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      child: Center(
        child: SizedBox(
          width: size.width * 0.8,
          height: 56,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(radius)),
            child: TextButton(
              child: Text(text),
              onPressed: press,
              style: TextButton.styleFrom(primary: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
