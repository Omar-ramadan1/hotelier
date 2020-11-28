import 'package:flutter/material.dart';

class SingleTextFieldWidget extends StatelessWidget {
  final Function onChangeFunction;
  final String text , errorText;
  final bool obscureText;
  const SingleTextFieldWidget(this.text, this.errorText , this.onChangeFunction , {this.obscureText});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          obscureText:  obscureText == null ? false : obscureText,
          onChanged: (value) {
            onChangeFunction(value);
          },
          decoration: InputDecoration(
            labelText: text,
            errorText: errorText,
          ),
        ),
      ),
    );
  }
}
