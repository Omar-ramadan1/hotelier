import 'package:flutter/material.dart';

import 'DropdownWidget.dart';

class HotelHeaderDropDownWidget extends StatelessWidget {
  final  String text , dropDownValue;
  final List<String> dropDownList;
  final Function onChangeFunction;
  final double size;
  const HotelHeaderDropDownWidget(this.text , this.dropDownValue, this.dropDownList , this.onChangeFunction , this.size);
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        DropdownWidget(dropDownValue, dropDownList, size, 20, (value) {
          onChangeFunction(value);
        }),
      ],
    );
  }
}
