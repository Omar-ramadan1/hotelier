import 'package:flutter/material.dart';

class ButtonChildWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize , width;
  const ButtonChildWidget(this.text, this.color , this.fontSize , this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      width: width,
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
