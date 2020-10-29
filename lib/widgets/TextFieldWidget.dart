import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextDirection textDirection;
  final String name , hint;
  final double width;

  const TextFieldWidget( this.name , this.width ,this.textDirection , this.hint);


  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      child: Column(
        children: [
          Row(
            textDirection: textDirection,
            children: [

              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          TextField(
              textAlign: TextAlign.center,
              showCursor: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFF7BB85),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: hint)),

        ],
      ),
    );
  }
}
