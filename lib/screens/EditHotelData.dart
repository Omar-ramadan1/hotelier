import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EditHotelData extends StatefulWidget {
    static const routeName = '/EditHotel';

  @override
  _EditHotelDataState createState() => _EditHotelDataState();
}

class _EditHotelDataState extends State<EditHotelData> {
  String discountValue ;
  double starRating = 0;
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg",""),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
         padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.2,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'اسم الفندق',
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: size.width / 1.2,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'رقم السجل التجارى',
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(height: 20,),
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
                    Text("العنوان على الخريطة" , style: TextStyle(fontWeight: FontWeight.w900),),
                    Icon(CupertinoIcons.map_pin_ellipse)
                  ],
                ),
              ),
              SizedBox(height: 25,),
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
                            labelText: 'رقم الجوال',
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
                            labelText: 'رقم الجوال',
                            errorText: null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'الايميل',
                    errorText: null,
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text("نسبة الخصم المقدمة" , style: TextStyle(fontWeight: FontWeight.w900),),
                    DropdownWidget(discountValue , ['10' , '20' , '30', '40' ,'50' , '60' , '70', '80' ,'90', '100'], 80 , 0 ,(value){
                      setState(() {
                        discountValue = value;
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text("عدد النجوم" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w800),),
                      SmoothStarRating(
                          allowHalfRating: true,
                          onRated: (v) {
                            print(v);
                            setState(() {
                              starRating = v;
                            });
                          },
                          starCount: 5,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          rating: starRating,
                          size: 30.0,
                          color: Colors.amberAccent,
                          borderColor: Colors.amberAccent,
                          spacing:0.0
                      ),


                    ],
                  ),
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonChildWidget("رفع صورة" , Color(0xFFF7BB85) , 15 , 100),
                  ButtonChildWidget("رفع فديو" , Color(0xFFF7BB85) , 15 , 100),
                ],
              ),
              SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    errorText: null,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'تاكيد كلمة المرور',
                    errorText: null,
                  ),
                ),
              ),
              SizedBox(height: 25,),
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
                    'اوافق على الشروط و الاحكام',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 35,),
              ButtonChildWidget("تسجيل حساب" , Color(0xFFF7BB85) , 18 , 150),
              SizedBox(height: 35,),
            ],
          ),
        ),
      ),
    );
  }
}
