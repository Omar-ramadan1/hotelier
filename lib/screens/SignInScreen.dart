import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';

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
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'بريد الكترونى/رقم عضوية',
                    errorText: null,
                    icon: Icon(
                      Icons.person_outline_sharp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    errorText: null,
                    icon: Icon(
                      Icons.lock_open,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    onChanged: (value){
                      print(value);
                      setState(() {
                        checkBoxValue = value;
                      });
                    },
                    value: checkBoxValue,
                    activeColor: Color(0xFFF7BB85),
                  ),
                  Text(
                    'تذكرنى',
                    style: TextStyle(fontSize: 20),
                  ),
                ],),
              SizedBox(height: 40,),
              ButtonChildWidget("تسجيل دخول"  , Color(0xFFF7BB85) , 25 , 150),
            ],
          ),
        ),
    );
  }
}

