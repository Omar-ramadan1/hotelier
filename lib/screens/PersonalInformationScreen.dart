import 'package:flutter/material.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/HotelPersonalInformationWidget.dart';
import 'file:///D:/andriod_projects/hotelier/lib/screens/UserInformationScreen.dart';
import 'package:provider/provider.dart';

class PersonalInformationScreen extends StatelessWidget {
  static const routeName = '/PersonalInformationScreen';
  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context);
    Map userData = userDataProvider.userData;
    return userData["IsHotel"] ?
    HotelPersonalInformationWidget() : UserInformationScreen();
  }
}
