import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/About.dart';
import 'package:hotelier/screens/CartDetailsScreen.dart';
import 'package:hotelier/screens/Complaining.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/BuyCardScreen.dart';
import 'package:hotelier/screens/PersonalInformationScreen.dart';
import 'package:hotelier/screens/RenewRegistrationScreen.dart';
import 'package:hotelier/screens/SponsorsScreen.dart';
import 'package:hotelier/screens/termsOfservice.dart';
import 'package:hotelier/widgets/DrawerTabSpecialForMoney.dart';
import 'package:provider/provider.dart';


import 'DrawerTabsWidget.dart';
import '../Clippers/AppBarClipper.dart';

class LoggedInUserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context);
    Map userData = userDataProvider.userData;
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
                      height: sizes.height / 3,
                      width: double.maxFinite,
                      color: Color(0xFFBD954F),
                    ),
                  ),
                  Column(
                    children: [
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: userData["userImg"] == '' ||
                                  userData['userImg'] == null
                              ? CircleAvatar(
                                  radius: sizes.width / 9,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xFFBD954F),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: Image.network(
                                          '${anotherServerURL}Content/Images/${userData['userImg']}')
                                      .image,
                                  radius: 40,
                                ),
                        ),
                      ),
                      userData["fullName"] == null
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                userData["fullName"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
              DrawerTabsWidget(Icons.home, "الرئيسية", () {
                Navigator.of(context)
                    .popUntil((route) {
                  print(route.settings.name);
                  if(route.settings.name == "/MainScreen"){
                    return true;
                  }else{
                    return false;
                  }

                });
              }),
              SizedBox(
                height: 10,
              ),
              DrawerTabsWidget(Icons.person, "حسابى", () {
                 Navigator.of(context).pushNamed(PersonalInformationScreen.routeName);
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
              DrawerTabsWidget(Icons.home_work, "شركاء النجاح", () {
                Navigator.of(context).popAndPushNamed(SponsorsScreen.routeName);
              }),
              InkWell(
                child: DrawerTabSpecialForMoney( "المدفوعات",
                    () {
                 Navigator.of(context).popAndPushNamed(CartDetailsScreen.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.autorenew, "تجديد الاشتراك", () async{
                  Navigator.of(context)
                      .popAndPushNamed(RenewRegistrationScreen.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: DrawerTabsWidget(Icons.credit_card, "شراء بطاقة", () async{
                  Navigator.of(context)
                      .popAndPushNamed(BuyCardScreen.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              DrawerTabsWidget(Icons.phone, "اتصل بنا", () {
                Navigator.of(context).popAndPushNamed(Contact.routeName);
              }),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: DrawerTabsWidget(
                    Icons.send_to_mobile, "للشكاوى و المقترحات", () {
                  Navigator.of(context).popAndPushNamed(Complaining.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child:
                    DrawerTabsWidget(Icons.star_rate_sharp, "عن التطبيق", () {
                  Navigator.of(context).popAndPushNamed(About.routeName);
                }),
              ),
              SizedBox(
                height: 5,
              ),
              DrawerTabsWidget(Icons.sticky_note_2_rounded, "الشروط و الاحكام",
                  () {
                Navigator.of(context).popAndPushNamed(TermsOfService.routeName);
              }),
              SizedBox(
                height: 5,
              ),
              DrawerTabsWidget(Icons.logout, "تسجيل الخروج", () {
                userDataProvider.updateUserInfo(null);
                Navigator.of(context)
                    .popUntil((route) {
                  print(route.settings.name);
                  if(route.settings.name == "/MainScreen"){
                    return true;
                  }else{
                    return false;
                  }
                });
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
