import 'package:flutter/material.dart';
import 'dart:math';

import '../Clippers/AppBarClipper.dart';

class AppBarWidget extends StatelessWidget {
final String imageName;
final String text;
  static const routeName = '/MainScreen';

  const AppBarWidget(this.imageName,this.text);
  @override
  Widget build(BuildContext context) {
    return  ClipPath(
      clipper: AppBarClipper(),
        child: Container(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                child: Text(text,style: TextStyle(fontSize:30,color:Colors.white,fontWeight: FontWeight.w800),),),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(imageName).image,
          ),
        ),
        
        ),
    );
  }
}


