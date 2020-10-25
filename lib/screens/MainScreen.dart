import 'package:flutter/material.dart';

import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawerScrimColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          flexibleSpace: AppBarWidget(),
        ),
      ),
      drawer: Container(),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        color: Colors.white,
        width: double.maxFinite,
        height: double.infinity,
        child: Column(
          children: [
            MainScreenCardWidget("CARD" , "البطاقة"),
            MainScreenCardWidget("SPECIAL OFFERS" , "العروض المميزة"),
            MainScreenCardWidget("" , ""),
          ],
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),
    );
  }
}
