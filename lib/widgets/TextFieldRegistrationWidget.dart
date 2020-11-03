import 'package:flutter/material.dart';

class TextFieldRegistrationWidget extends StatelessWidget {
  final String text;
  final IconData icon ;
  const TextFieldRegistrationWidget(this.text , this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          decoration: InputDecoration(
            labelText: text,
            errorText: null,
            icon: Icon(
                icon
            ),
          ),
        ),
      ),
    );
  }
}
