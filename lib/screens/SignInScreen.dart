import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/RememberMeWidgetCheckBox.dart';
import 'package:hotelier/widgets/TextFieldRegistrationWidget.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: size.width * 80 / 100,
        child: Column(
          children: [
            //TextFieldRegistrationWidget takes text String that will appear as hint  and Icon
            TextFieldRegistrationWidget(
              'بريد الكترونى/رقم عضوية',
              Icons.person_outline_sharp,
            ),
            //TextFieldRegistrationWidget takes text String that will appear as hint  and Icon
            TextFieldRegistrationWidget(
              'كلمة المرور',
              Icons.lock_open,
            ),
            SizedBox(
              height: 40,
            ),
            // RememberMeWidgetCheckBox take bool value as a initial value
            // and onchange funtion to handle the change happen
            RememberMeWidgetCheckBox(checkBoxValue, (value) {
              setState(() {
                checkBoxValue = value;
              });
            }),

            // ButtonChildWidget takes text to show , Color , fontsize and width as parameters
            ButtonChildWidget("تسجيل دخول", Color(0xFFF7BB85), 25, 150),
          ],
        ),
      ),
    );
  }
}
