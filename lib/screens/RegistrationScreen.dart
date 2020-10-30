import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

import 'SignInScreen.dart';
import 'SignUpScreen.dart';

enum Registration {
  signIn,
  signUp,
}

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Registration registration = Registration.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: TextDirection.rtl,
                children: [
                  InkWell(
                    child: ButtonChildWidget(
                        "تسجيل الدخول",
                        registration == Registration.signIn
                            ? Color(0xFFF7BB85)
                            : Colors.white,
                        18 , 150),
                    onTap: () {
                      setState(() {
                        registration = Registration.signIn;
                      });
                    },
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        registration = Registration.signUp;
                      });
                    },
                    child: ButtonChildWidget(
                        "تسجيل حساب",
                        registration == Registration.signUp
                            ? Color(0xFFF7BB85)
                            : Colors.white,
                        18 , 150),
                  ),
                ],
              ),
              registration == Registration.signIn ?
              SignInScreen() : SignUpScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
