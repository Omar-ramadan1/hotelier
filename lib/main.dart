import 'package:flutter/material.dart';

import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:hotelier/screens/Error_404.dart';


import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/Send_Successfully.dart';
import 'package:hotelier/screens/SplashScreenWidget.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/screens/offer_details.dart';
import 'package:hotelier/screens/special_offer.dart';

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
      home: Offer_Details(),

      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        Complaining.routeName: (ctx) => Complaining(),
        Contact.routeName: (ctx) => Contact(),
        PaymentScreen.routeName: (ctx) => PaymentScreen(),
      },
    );
  }
}



