import 'package:flutter/material.dart';

import 'HotelDetailsWidget.dart';
import 'HotelImageWidget.dart';
class HotelContainerWidget extends StatelessWidget {
  final Map data;

  const HotelContainerWidget(this.data);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      width: size.width / 1.05,
      height: size.width / 1.7,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Color(0xFFC29D5E)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Row(textDirection: TextDirection.rtl, children: [
        HotelImageWidget(data),
        HotelDetailsWidget(data),
        //Spacer(),
      ]),
    );
  }
}
