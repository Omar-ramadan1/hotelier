import 'package:flutter/material.dart';

class TextFieldRegistrationWidget extends StatelessWidget {
  final String text , errorText;
  final IconData icon ;
  final Function onChange;
  final bool obscureText;
  const TextFieldRegistrationWidget(this.text , this.obscureText , this.errorText , this.icon , this.onChange);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          obscureText: obscureText,
          onChanged: (value){onChange(value);},
          decoration: InputDecoration(
            labelText: text,
            errorText: errorText,
            icon: Icon(
                icon
            ),
          ),
        ),
      ),
    );
  }
}
