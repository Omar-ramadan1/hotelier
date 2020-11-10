import 'package:flutter/material.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:hotelier/screens/Error_404.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/Send_Successfully.dart';
import 'package:hotelier/screens/OfferDetailsScreen.dart';
import 'package:hotelier/screens/SplashScreenWidget.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/EditHotelData.dart';
import 'package:hotelier/screens/SpecialOfferScreen.dart';
import 'package:hotelier/screens/Congratulation.dart';
import 'package:hotelier/screens/termsOfservice.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataList(),),
        ChangeNotifierProvider(create: (_) => UserData(),),
      ],
      child: Hotelier(),
    ),
  );
}

class Hotelier extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreenWidget(),

      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        Complaining.routeName: (ctx) => Complaining(),
        Contact.routeName: (ctx) => Contact(),
        PaymentScreen.routeName: (ctx) => PaymentScreen(),
        Congratulation.routeName:(ctx)=>Congratulation(),
        Send_Successfully.routeName:(ctx)=>Send_Successfully(),
        OfferDetailsScreen.routeName:(ctx)=>OfferDetailsScreen(),
        Error_404.routeName:(ctx)=>Error_404(),
        EditUserData.routeName:(ctx)=>EditUserData(),
        EditHotelData.routeName:(ctx)=>EditHotelData(),
        SpecialOfferScreen.routeName:(ctx)=>SpecialOfferScreen(),
        TermsOfService.routeName:(ctx)=>TermsOfService(),
        GetLocationScreen.routeName:(ctx)=>GetLocationScreen(),


      },
    );
  }
}



