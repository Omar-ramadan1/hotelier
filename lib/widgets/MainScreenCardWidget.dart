import 'package:flutter/material.dart';

class MainScreenCardWidget extends StatelessWidget {
  final String imageName;
  final GestureTapCallback onTap;

  MainScreenCardWidget(this.imageName,this.onTap);


  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return InkWell(
          child: Container(

        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(image: Image.asset(imageName).image),
        ),
        height: size.height / 5,
        width: size.width / 1.24,

      ),
      onTap:onTap ,
    );
  }
}
