import 'package:flutter/material.dart';

class RememberMeWidgetCheckBox extends StatelessWidget {
  final bool checkBoxValue;
  final Function onChange;

  const RememberMeWidgetCheckBox(this.checkBoxValue , this.onChange);
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          onChanged: (value){
           onChange(value);
          },
          value: checkBoxValue,
          activeColor: Color(0xFFF7BB85),
        ),
        Text(
          'تذكرنى',
          style: TextStyle(fontSize: 20),
        ),
      ],);
  }
}
