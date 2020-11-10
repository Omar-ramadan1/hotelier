import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/EditHotelData.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/termsOfservice.dart';
import 'package:provider/provider.dart';

import 'DrawerTabsWidget.dart';
import '../Clippers/AppBarClipper.dart';

class LoggedInUserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    Size sizes = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: AppBarClipper(),
                    child: Container(
                      height: sizes.height / 3.5,
                      width: double.maxFinite,
                      color: Color(0xFFBD954F),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        color: Color(0xFFBD954F),
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: sizes.width / 9,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Color(0xFFBD954F),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              DrawerTabsWidget(Icons.person, "حسابى", () {
                // Navigator.of(context).pushNamed(EditUserData.routeName);
              }),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.settings, "الاعدادات", () {
                  Navigator.of(context).popAndPushNamed(EditUserData.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.attach_money_rounded, "المدفوعات", () {
                  Navigator.of(context).popAndPushNamed(PaymentScreen.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.autorenew, "تجديد الاشتراك", () {
                  // Navigator.of(context).popAndPushNamed(Complaining.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.credit_card, "شراء بطاقة", () {
                  Navigator.of(context).popAndPushNamed(PaymentScreen.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(CupertinoIcons.phone, "للشكاوى و المقترحات",
                    () {
                  Navigator.of(context).popAndPushNamed(Complaining.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.star_rate_sharp, "عن التطبيق", () {
                  // Navigator.of(context).popAndPushNamed(EditUserData.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              DrawerTabsWidget(Icons.sticky_note_2_rounded, "الشروط و الاحكام", () {
                Navigator.of(context)
                    .popAndPushNamed(TermsOfService.routeName);
              }),
              SizedBox(
                height: 5,
              ),
              DrawerTabsWidget(Icons.logout, "تسجيل الخروج", () {

                userData.updateUserInfo(null);
                Navigator.of(context)
                    .pop();
              }),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/appDrawerLogo.jpeg',
                fit: BoxFit.fill,
                width: 120,
                height: 130,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
