import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';

class SignUpUser extends StatefulWidget {
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  bool checkBoxValue = false;
  Map data = {
    'cityName': 'الرياض',
    'name': null,
    'idNumber': null,
    'district': null,
    'phone': null,
    'email': null,
    'password': null,
    'address': null,
    'confirmPassword': null,
    'latitude': null,
    'longitude': null,
    'isHotel' : false,
  };


  Map dataErrorMessage = {
    'name': null,
    'idNumber': null,
    'district': null,
    'phone': null,
    'email': null,
    'password': null,
    'address': null,
    'confirmPassword': null,
    'latitude': null,
    'longitude': null
  };

  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
    });
  }

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
              onChanged: (value) {
                onChangeFunction(value, 'name');
              },
              decoration: InputDecoration(
                labelText: 'الاسم',
                errorText: dataErrorMessage['name'],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: (value) {
                onChangeFunction(value, 'idNumber');
              },
              decoration: InputDecoration(
                labelText: 'رقم الهوية/رقم الاقامة',
                errorText: dataErrorMessage['idNumber'],
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
                  child: DropdownWidget(
                      data['cityName'], ['الرياض', 'مكة'], 80, 0, (value) {
                    setState(() {
                      data['cityName'] = value;
                    });
                  }),
                ),
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (value) {
                        onChangeFunction(value, 'district');
                      },
                      decoration: InputDecoration(
                        labelText: 'الحى',
                        errorText: dataErrorMessage['district'],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              // GetLocationScreen
              Position position = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GetLocationScreen()));
              var address = await Geocoder.local.findAddressesFromCoordinates(
                  new Coordinates(position.latitude, position.longitude));
              print(address.first.addressLine);
              setState(() {
                data['latitude'] = position.latitude;
                data['longitude'] = position.longitude;
                data['address'] = address.first.addressLine;
                dataErrorMessage['address'] = null;
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 25),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    "العنوان على الخريطة",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Icon(CupertinoIcons.map_pin_ellipse),
                  locationTextHandler(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                onChanged: (value) {
                  onChangeFunction(value, 'phone');
                },
                decoration: InputDecoration(
                  labelText: 'رقم الجوال',
                  errorText: dataErrorMessage['phone'],
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
              onChanged: (value) {
                onChangeFunction(value, 'email');
              },
              decoration: InputDecoration(
                labelText: 'الايميل',
                errorText: dataErrorMessage['email'],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: (value) {
                onChangeFunction(value, 'password');
              },
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                errorText: dataErrorMessage['password'],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: (value) {
                onChangeFunction(value, 'confirmPassword');
              },
              decoration: InputDecoration(
                labelText: 'تاكيد كلمة المرور',
                errorText: dataErrorMessage['confirmPassword'],
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
                'اوافق على الشروط و الاحكام',
                style: TextStyle(fontSize: 20),
              ),
              Checkbox(
                onChanged: (value) {
                  print(value);
                  setState(() {
                    checkBoxValue = value;
                  });
                },
                value: checkBoxValue,
                activeColor: Color(0xFFF7BB85),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          InkWell(
              onTap: () {
                check();
              },
              child:
                  ButtonChildWidget("تسجيل حساب", Color(0xFFF7BB85), 18, 150)),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  check() {
    bool check = true;
    data.forEach((key, value) {
      if (value == null || value == '') {
        print('$key   $value');
        setState(() {
          dataErrorMessage[key] = "من فضلك اكمل هذه الخانة";
        });
        check = false;
      }
    });

    return check;
  }

  locationTextHandler() {
    if (data['address'] != null) {
      return Container(
          width: 150,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            data['address'],
            style: TextStyle(fontSize: 13, color: mainAppColor),
          ));
    } else if (dataErrorMessage['address'] != null) {
      return Container(
        width: 150,
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(5),
        child: Text("من فضلك اختر مكان على الخريطة",
            style: TextStyle(fontSize: 12, color: Colors.red)),
      );
    } else {
      return Container();
    }
  }
}
