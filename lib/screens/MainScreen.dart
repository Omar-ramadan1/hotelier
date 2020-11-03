import 'package:flutter/material.dart';

import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
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
        child: Column(
          children: [
            MainScreenCardWidget("assets/card.jpg"),
            MainScreenCardWidget("assets/specialOffers.jpg"),
            MainScreenCardWidget("assets/Group 1.jpg"),
          ],
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),
    );
  }
}
