import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/screens/About.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/BuyCardScreen.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:hotelier/screens/RegistrationScreen.dart';
import 'package:hotelier/screens/RenewRegistrationScreen.dart';
import 'package:hotelier/screens/SponsorsScreen.dart';
import 'package:hotelier/screens/termsOfservice.dart';

import 'DrawerTabsWidget.dart';
import '../Clippers/AppBarClipper.dart';
enum Registration {
  signIn,
  signUp,
}

class NormalDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              DrawerTabsWidget(Icons.home, "الرئيسية", () {
                Navigator.of(context)
                    .popUntil((route) {
                  print(route.settings.name);
                  if(route.settings.name == "null" || route.settings.name == null){
                    return true;
                  }else{
                    return false;
                  }

                });
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.person, "تسجيل الدخول", () {
                Navigator.of(context).popAndPushNamed(RegistrationScreen.routeName ,arguments: "signIn");
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.person_add, "تسجيل حساب جديد", () {
                Navigator.of(context).popAndPushNamed(RegistrationScreen.routeName ,arguments: "signUp");
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.home_work, "شركاء النجاح", () {
                Navigator.of(context).popAndPushNamed(SponsorsScreen.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.autorenew, "تجديد الاشتراك", () {
                Navigator.of(context).popAndPushNamed(RenewRegistrationScreen.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.credit_card, "شراء البطاقة", () {
                Navigator.of(context).popAndPushNamed(BuyCardScreen.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.phone, "اتصل بنا", () {
                Navigator.of(context).popAndPushNamed(Contact.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.send_to_mobile, "للشكاوى و المقترحات", () {
                Navigator.of(context).popAndPushNamed(Complaining.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.star_rate_sharp, "عن التطبيق", () {
                Navigator.of(context).popAndPushNamed(About.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.sticky_note_2_rounded, "الشروط و الاحكام",
                      () {
                    Navigator.of(context).popAndPushNamed(TermsOfService.routeName);
                  }),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/appDrawerLogo.jpeg',
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
