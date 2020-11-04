import 'package:flutter/material.dart';

import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

import 'OfferDetailsScreen.dart';
import 'SpecialOfferScreen.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg",""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        color: Colors.white,
        width: double.maxFinite,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
               MainScreenCardWidget("assets/card.jpg",null),
                 MainScreenCardWidget("assets/specialOffers.jpg",(){Navigator.of(context).popAndPushNamed (SpecialOfferScreen.routeName);}),
                 MainScreenCardWidget("assets/Group 1.jpg",(){Navigator.of(context).popAndPushNamed (OfferDetailsScreen.routeName);}),
            ],
          ),
        ),
      ),
   //   bottomNavigationBar : BottomBarWidget(),
    );
  }
}
