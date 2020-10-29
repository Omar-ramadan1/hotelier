import 'package:flutter/material.dart';

class ButtonChildWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  const ButtonChildWidget(this.text, this.color , this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 2.0, color: Color(0xFFB99659)),
        color: color,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
