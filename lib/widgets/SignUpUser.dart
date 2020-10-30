import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SignUpUser extends StatefulWidget {
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  String discountValue;
  double starRating = 0;
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 80 / 100,
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'الاسم',
                errorText: null,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'رقم الهوية/رقم الاقامة',
                errorText: null,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: size.width,
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'المدينة',
                        errorText: null,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'الحى',
                        errorText: null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  "العنوان على الخريطة",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Icon(CupertinoIcons.map_pin_ellipse)
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'رقم الجوال',
                  errorText: null,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'الايميل',
                errorText: null,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                errorText: null,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'تاكيد كلمة المرور',
                errorText: null,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'برجاء اختيار طريقة الدفع',
                style: TextStyle(fontSize: 20),
              ),
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
                'اوافق على الشروط و الاحكام',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          ButtonChildWidget("تسجيل حساب", Color(0xFFF7BB85), 18, 150),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
