import 'package:flutter/material.dart';

import 'HotelDetailsWidget.dart';
import 'HotelImageWidget.dart';
class HotelContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: 200,
      width: size.width / 1.05,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Color(0xFFC29D5E)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Row(textDirection: TextDirection.rtl, children: [
        HotelImageWidget(),
        HotelDetailsWidget(),
        //Spacer(),
      ]),
    );
  }
}
