import 'package:flutter/material.dart';

class SignUpHotel extends StatefulWidget {
  @override
  _SignUpHotelState createState() => _SignUpHotelState();
}

class _SignUpHotelState extends State<SignUpHotel> {

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
                labelText: 'اسم الفندق',
                errorText: null,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'رقم السجل التجارى',
                errorText: null,
              ),
            ),
          ),
          SizedBox(height: 20,),
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
          )
        ],
      ),
    );
  }
}
