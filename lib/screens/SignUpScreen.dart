import 'package:flutter/material.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:hotelier/widgets/SignUpHotel.dart';
import 'package:hotelier/widgets/SignUpUser.dart';

enum Registration {
  hotel,
  user,
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Registration registration = Registration.hotel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "تسجيل حساب جديد",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      registration = Registration.hotel;
                    });
                  },
                    child: SignUpButtonWidget(
                        "فندق",
                        Icons.home_work_outlined,
                        registration == Registration.hotel
                            ? Color(0xFFF7BB85)
                            : Colors.white),),
                InkWell(
                  onTap: (){
                    setState(() {
                      registration = Registration.user;
                    });
                  },
                  child: SignUpButtonWidget(
                      "مستخدم",
                      Icons.person,
                      registration == Registration.user
                          ? Color(0xFFF7BB85)
                          : Colors.white),
                ),
              ],
            ),
            registration == Registration.hotel ? SignUpHotel() : SignUpUser(),
          ],
        ));
  }
}
