import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'MainScreen.dart';


class SplashScreenWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds:7,
      imageBackground: Image.asset("./assets/SplashScreenImage.jpg").image,
      loaderColor: Colors.transparent,
      navigateAfterSeconds: MainScreen(),

    );
  }
}