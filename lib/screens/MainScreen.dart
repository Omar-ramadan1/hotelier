import 'package:flutter/material.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/HotelScreen.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:provider/provider.dart';
import 'SpecialOfferScreen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataList = Provider.of<DataList>(context , listen: false);
    UserData userData = Provider.of<UserData>(context , listen: false);

      dataList.getCitiesListFunction();
      userData.checkIfUserDataOnMobileStorage();
      dataList.getTypesListFunction();

  }
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
              MainScreenCardWidget("assets/card.jpg",(){Navigator.of(context).pushNamed(PaymentScreen.routeName);}),
              MainScreenCardWidget("assets/specialOffers.jpg",(){Navigator.of(context).pushNamed(SpecialOfferScreen.routeName);}),
              MainScreenCardWidget("assets/Group 1.jpg",(){Navigator.of(context).pushNamed(HotelScreen.routeName);}),
            ],
          ),
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),
    );
  }
}

