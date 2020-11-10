import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:http/http.dart' as http;
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:provider/provider.dart';
import 'SpecialOfferScreen.dart';

class MainScreen extends StatelessWidget {
 httpRequest() async{
    // var ressponse  = await http.get('http://islam86868-001-site1.itempurl.com/api/Types/List');
    var ressponse  = await http.get('http://islam86868-001-site1.itempurl.com/api/City/List');
    print(ressponse.body);
    var body = jsonDecode(ressponse.body);
    var city = body[0];
    print('city');
    print(city["Name"]);
  }
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    final dataList = Provider.of<DataList>(context);
    UserData userData = Provider.of<UserData>(context);

    if(dataList.citiesList == null){
      dataList.getCitiesListFunction();
      userData.checkIfUserDataOnMobileStorage();
    }
    if(dataList.typesList == null){
      dataList.getTypesListFunction();
    }
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
                 MainScreenCardWidget("assets/specialOffers.jpg",(){Navigator.of(context).pushNamed(SpecialOfferScreen.routeName);}),
                 MainScreenCardWidget("assets/Group 1.jpg",(){Navigator.of(context).pushNamed(SpecialOfferScreen.routeName);}),
            ],
          ),
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),
    );
  }
}
