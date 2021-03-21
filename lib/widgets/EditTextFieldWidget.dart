import 'package:flutter/material.dart';

class EditTextFieldWidget extends StatelessWidget {
  final String text , text2 , errorText;
  final Function onChangeFunction;
  final TextInputType textInputType;
  const EditTextFieldWidget(this.text, this.text2 , this.onChangeFunction , {this.errorText , this.textInputType});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: size.width / 1.8,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              keyboardType: textInputType == null ? TextInputType.text : textInputType,
              onChanged: (value){onChangeFunction(value);},
              decoration: InputDecoration(
                labelText: text,
                errorText: errorText
              ),
            ),
          ),
        ),
       Container(child: Text(text2),margin: EdgeInsets.only(top: 20),),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}


//رقم الهوية/رقم الاقامة