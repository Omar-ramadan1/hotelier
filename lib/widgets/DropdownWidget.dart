import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String value;
  final Function onChange;
  final List<String> values;
  final double width , iconSize;
  const DropdownWidget(this.value , this.values ,this.width ,this.iconSize  ,this.onChange);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 20),
   padding: EdgeInsets.only(top: 0),
      width: width,

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButton<String>(
          isExpanded: true,
          iconSize: iconSize,
          iconEnabledColor: Colors.black,
          style: TextStyle(fontSize: 15 , ),
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
        ),
      ),
    );
  }
}
