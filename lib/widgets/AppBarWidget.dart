import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
     resizeToAvoidBottomInset: true,
     backgroundColor: Colors.white,
      body: Container(
        child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFFF7BB85),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: NetworkImage(
              //       "https://img.freepik.com/free-vector/flat-bright-stars-background_23-2148379399.jpg?size=626&ext=jpg"),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    var firstControlPoint = Offset(size.width / 3.25, size.height - 65);
    var firstEndPoint = Offset(size.width / 1.75, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondCP = Offset(size.width / 1.25, size.height + 15);
    var secondEP = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
