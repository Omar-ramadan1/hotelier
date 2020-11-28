import 'package:flutter/material.dart';

class EditTextFieldWidget extends StatelessWidget {
  final String text;
  final Function onChangeFunction;

  const EditTextFieldWidget(this.text, this.onChangeFunction);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: size.width / 1.3,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: (value){onChangeFunction(value);},
              decoration: InputDecoration(
                labelText: text,
              ),
            ),
          ),
        ),
        Icon(Icons.edit),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}


//رقم الهوية/رقم الاقامة