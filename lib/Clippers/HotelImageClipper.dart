import 'package:flutter/material.dart';

class HotelImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height );
    path.lineTo(size.width- size.width/ 1.19, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}
