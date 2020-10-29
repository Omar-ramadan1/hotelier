import 'package:flutter/material.dart';

class MainScreenCardWidget extends StatelessWidget {
  final String imageName;

  MainScreenCardWidget(this.imageName);


  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: Image.asset(imageName).image),
      ),
      height: size.height / 5,
      width: size.width / 1.24,

    );
  }
}
