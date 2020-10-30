import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String value;
  final Function onChange;
  final List<String> values;

  const DropdownWidget(this.value , this.values ,this.onChange);
  @override
  Widget build(BuildContext context) {
    return    DropdownButton<String>(
      iconEnabledColor: Colors.transparent,
      style: TextStyle(fontSize: 15),

      value: value,
      hint:  Text("Select item"),
      onChanged: (value) {
        onChange(value);

      },
      items: values.map(( user) {
        return  DropdownMenuItem<String>(
          value: user,
          child: Container(
            child: Text(
              user,
              textAlign: TextAlign.center,
              style:  TextStyle(color: Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }
}
