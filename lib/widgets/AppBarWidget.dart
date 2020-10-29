import 'package:flutter/material.dart';

import 'MyClipper.dart';

class AppBarWidget extends StatelessWidget {
final String imageName;
  static const routeName = '/MainScreen';

  const AppBarWidget(this.imageName);
  @override
  Widget build(BuildContext context) {
    return  ClipPath(
      clipper: MyClipper(),
        child: Container(
          height: 160,
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


