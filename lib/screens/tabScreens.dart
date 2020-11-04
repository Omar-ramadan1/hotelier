import 'package:flutter/material.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/MainScreen.dart';
import 'package:hotelier/screens/OfferDetailsScreen.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/screens/SpecialOfferScreen.dart';

import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class TapScreen extends StatefulWidget {
  static const routeName = '/TapScreen';

  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  List<Widget> _page =[
    MainScreen(),
    PaymentScreen(),
    SpecialOfferScreen(),
  ];
  int _selectPageIndex =0;
  


  void _selectPage(int index){
setState(() {
  
  _selectPageIndex =index;
});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectPageIndex],
     
      bottomNavigationBar : Container(
        height: 65,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25) , topRight: Radius.circular(25)),
     //   border: Border.all(width: 2.0, color: Color(0xFFB99659)),
       // color: Color(0xFFF7BB85),
      ),
        child: BottomNavigationBar(
          
          onTap: _selectPage,
          backgroundColor: Color(0xFFF7BB85),
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white54,
          currentIndex: _selectPageIndex,
     //   type: BottomNavigationBarType.shifting,
         items: [
           BottomNavigationBarItem(
             icon: Icon(
               Icons.person,
           //    color:Colors.black,
               ),
               title: Text("حسابي",style: TextStyle(color:Colors.black),),
               ),
BottomNavigationBarItem(
             icon: Icon(
               Icons.monetization_on_outlined,
             //  color:Colors.black
               ),title: Text("المدفوعات",style: TextStyle(color:Colors.black),),
               ),
               BottomNavigationBarItem(
             icon: Icon(
               Icons.card_giftcard_rounded,
               //color:Colors.black
               ),title: Text("العروض",style: TextStyle(color:Colors.black),),
               ),

         ], 
        ),
      ),
    );
  }
}
