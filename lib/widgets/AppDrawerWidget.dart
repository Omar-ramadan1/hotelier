import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/LoggedInUserDrawer.dart';
import 'package:hotelier/widgets/LoggedinHotelDrawer.dart';
import 'package:hotelier/widgets/NormalDrawer.dart';
import 'package:provider/provider.dart';

class AppDrawerWidget extends StatefulWidget {
  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    Map userDataClone = userData.userData;
    Size sizes = MediaQuery.of(context).size;
    return Container(
      //height: 500,
      color: Color(0xFFFFFFFF),
      width: sizes.width / 1.555,
      child: userDataClone == null
          ? NormalDrawer()
          : userDataClone["IsHotel"]
              ? LoggedInHotelDrawer()
              : LoggedInUserDrawer(),
    );
  }
}
