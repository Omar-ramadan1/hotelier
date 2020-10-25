import 'package:flutter/material.dart';

import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/SplashScreenWidget.dart';

void main() {
  runApp(Hotelier());
}

class Hotelier extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenWidget(),
      // home: MainScreen(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}



