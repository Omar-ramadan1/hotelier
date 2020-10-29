import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DrawerTabsWidget.dart';
import 'MyClipper.dart';
class LogedInDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: sizes.height / 3.5,
                    width: double.maxFinite,
                    color: Color(0xFFBD954F),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top:40),
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
            InkWell(
              child: DrawerTabsWidget(Icons.person , "حسابى"),
            ),
            SizedBox(height: 20,),
            InkWell(
              child: DrawerTabsWidget(Icons.settings , "الاعدادات"),
            ),
            SizedBox(height: 20,),
            InkWell(
              child: DrawerTabsWidget(Icons.phone , "للشكاوى و المقترحات"),
            ),
            SizedBox(height: 20,),
            InkWell(
              child: DrawerTabsWidget(Icons.star_rate_sharp , "عن التطبيق"),
            ),
            SizedBox(height: 20,),
            InkWell(
              child: DrawerTabsWidget(CupertinoIcons.money_dollar , "المدفوعات"),
            ),
            SizedBox(height: 20,),
            InkWell(
              child: DrawerTabsWidget(Icons.loop  , "تجديد الاشتراك"),
            ),
            SizedBox(height: 20,),
            Image.asset('assets/appDrawerLogo.jpeg', width: 80,),
          ],
        ),
      ),
    );
  }
}
