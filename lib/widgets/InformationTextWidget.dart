import 'package:flutter/material.dart';

class InformationTextWidget extends StatelessWidget {
  final String text1, text2;

  const InformationTextWidget(this.text1, this.text2);
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: 15 , top: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text(
            text1,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            text2,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700 , color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
