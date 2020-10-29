import 'package:flutter/material.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/Contact.dart';

import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/SplashScreenWidget.dart';
import 'package:hotelier/screens/PaymentScreen.dart';

void main() {
  runApp(Hotelier());
}

class Hotelier extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PaymentScreen(),
      home: Complaining(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}



