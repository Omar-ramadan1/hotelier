import 'package:flutter/material.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/EnableAddingNewHotel.dart';
import 'package:hotelier/Model/HotelData.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/About.dart';
import 'package:hotelier/screens/CartDetailsScreen.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:hotelier/screens/ControllingNumberOfHotelSSettingScreen.dart';
import 'package:hotelier/screens/Error_404.dart';
import 'package:hotelier/screens/ForgetPasswordScreen.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/screens/HotelScreen.dart';
import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/PersonalInformationScreen.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/RenewRegistrationScreen.dart';
import 'package:hotelier/screens/SendSuccessfully.dart';
import 'package:hotelier/screens/SplashScreenWidget.dart';
import 'package:hotelier/screens/BuyCardScreen.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/SpecialOfferScreen.dart';
import 'package:hotelier/screens/Congratulation.dart';
import 'package:hotelier/screens/SponsorsScreen.dart';
import 'package:hotelier/screens/SuccessScreen.dart';
import 'package:hotelier/screens/termsOfservice.dart';
import 'package:hotelier/Model/ImportantInformationModel.dart';
import 'package:provider/provider.dart';


// River' covered by ITZY YEJI
void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataList(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserData(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImportantInformationModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => EnableAddingNewHotel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HotelData(),
        ),
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
      //CartDetailsScreen(),
      // SplashScreenWidget(),

      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        Complaining.routeName: (ctx) => Complaining(),
        Contact.routeName: (ctx) => Contact(),
        BuyCardScreen.routeName: (ctx) => BuyCardScreen(),
        CartDetailsScreen.routeName: (ctx) => CartDetailsScreen(),
        RenewRegistrationScreen.routeName: (ctx) => RenewRegistrationScreen(),
        Congratulation.routeName: (ctx) => Congratulation(),
        SendSuccessfully.routeName: (ctx) => SendSuccessfully(),
        // HotelDetailsScreen.routeName: (ctx) => HotelDetailsScreen(),
        Error_404.routeName: (ctx) => Error_404(),
        EditUserData.routeName: (ctx) => EditUserData(),
        SpecialOfferScreen.routeName: (ctx) => SpecialOfferScreen(),
        HotelScreen.routeName: (ctx) => HotelScreen(),
        TermsOfService.routeName: (ctx) => TermsOfService(),
        GetLocationScreen.routeName: (ctx) => GetLocationScreen(),
        SuccessScreen.routeName: (ctx) => SuccessScreen(),
        ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
        PersonalInformationScreen.routeName: (ctx) =>
            PersonalInformationScreen(),
        About.routeName: (ctx) => About(),
        SponsorsScreen.routeName: (ctx) => SponsorsScreen(),
        ControllingNumberOfHotelSSettingScreen.routeName: (ctx) => ControllingNumberOfHotelSSettingScreen(),
      },
    );
  }
}
