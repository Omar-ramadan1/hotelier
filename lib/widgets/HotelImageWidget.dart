import 'package:flutter/material.dart';
import 'package:hotelier/Clippers/HotelImageClipper.dart';
import 'package:hotelier/Constant/Constant.dart';

class HotelImageWidget extends StatelessWidget {
  final Map data;

  const HotelImageWidget(this.data);
  @override
  Widget build(BuildContext context) {
    List images = data["img"];
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: HotelImageClipper(),
      child: Stack(
        children: [
          Container(
            width: size.width / 2.65,
            height: size.width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(17) , bottomRight: Radius.circular(17)),
                 image: DecorationImage(image:NetworkImage("${anotherServerURL}Content/Images/${images[0]}"),
                 fit: BoxFit.cover),
                color: Colors.transparent
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 45 , top: size.width / 1.94),
            width: 70,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.elliptical(400, 400) , topRight: Radius.elliptical(400, 400),
              
              ),
             // image: NetworkImage(""),
              color: Colors.yellow,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
                
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${data["Discount"]}%" , style: TextStyle(fontWeight: FontWeight.w800),),
                Text("Discount" , style: TextStyle(fontWeight: FontWeight.w800),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
