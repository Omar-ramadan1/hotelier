import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'MainScreen.dart';


class SplashScreenWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds:7,
      backgroundColor: Colors.white,
      loadingText: Text("Splash Screeeeeen" ,style: TextStyle(fontSize: 30),),
      photoSize: 150,
      navigateAfterSeconds: MainScreen(),

    );
  }
}