import 'package:flutter/material.dart';
class SignUpButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const SignUpButtonWidget(this.text , this.icon , this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.0, color: Color(0xFFB99659)),
          ),

          child: Icon(icon , size: 30,)
        ),
        Text(text)
      ],
    );

  }
}
