import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class EditUserData extends StatefulWidget {
  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  String discountValue;
  double starRating = 0;
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        color: Colors.white,
       padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("تعديل حساب"  , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w800),),
              SignUpButtonWidget(
                  "محمد فؤاد",
                  Icons.person_add_alt_1_sharp,
                  Color(0xFFF7BB85)),

              Row(
              textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.3,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'الاسم',
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.3,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'رقم الهوية/رقم الاقامة',
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.edit),
                ],
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
                    Row(
                      textDirection: TextDirection.rtl,
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
                        Icon(Icons.edit),
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
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
                        Icon(Icons.edit),
                      ],
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
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.3,
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
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.3,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'الايميل',
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   textDirection: TextDirection.rtl,
              //   children: [
              //     Container(
              //       width: size.width / 1.3,
              //       child: Directionality(
              //         textDirection: TextDirection.rtl,
              //         child: TextField(
              //           decoration: InputDecoration(
              //             labelText: 'كلمة المرور',
              //             errorText: null,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Icon(Icons.edit),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   textDirection: TextDirection.rtl,
              //   children: [
              //     Container(
              //       width: size.width / 1.3,
              //       child: Directionality(
              //         textDirection: TextDirection.rtl,
              //         child: TextField(
              //           decoration: InputDecoration(
              //             labelText: 'تاكيد كلمة المرور',
              //             errorText: null,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Icon(Icons.edit),
              //   ],
              // ),
              SizedBox(
                height: 35,
              ),
              ButtonChildWidget("حفظ التعديلات", Color(0xFFF7BB85), 18, 150),
              SizedBox(
                height: 25,
              ),
              ButtonChildWidget("تجديد الاشتراك", Color(0xFFF7BB85), 23, 250),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
    ),
    );
  }
}
