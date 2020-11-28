import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/widgets/SingleTextFieldWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:provider/provider.dart';

class SignUpUser extends StatefulWidget {
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  bool checkBoxValue = false;
  String cityName;
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

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    DataList dataList = Provider.of<DataList>(context);
    cityName = dataList.citiesNames[0];
  }

  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    DataList dataList = Provider.of<DataList>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 80 / 100,
      child: Column(
        children: [
          SingleTextFieldWidget(
              'الاسم', null,
                  (value) {
                    onChangeFunction(value, 'name');
              }),
          SingleTextFieldWidget(
              'رقم الهوية/رقم الاقامة', null,
                  (value) {
                onChangeFunction(value, 'idNumber');
              }),
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
                      cityName , dataList.citiesNames, 80, 0, (value) {
                    setState(() {
                      cityName = value;
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
              LatLng position = await Navigator.of(context).push(
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
          SingleTextFieldWidget(
              'رقم الجوال', null,
                  (value) {
                onChangeFunction(value, 'phone');
              }),
          SingleTextFieldWidget(
              'الايميل', null,
                  (value) {
                onChangeFunction(value, 'email');
              }),
          SingleTextFieldWidget(
              'كلمة المرور', null,
                  (value) {
                onChangeFunction(value, 'password');
              } , obscureText: true),
          SingleTextFieldWidget(
              'تاكيد كلمة المرور', null,
                  (value) {
                onChangeFunction(value, 'confirmPassword');
              }, obscureText: true),
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
              onTap: () async{
                var citiesListClone = dataList.citiesList;
                print(dataList.citiesList);
                citiesListClone.forEach((e) => {
                  if( e["Name"] == cityName){
                    data["cityName"] = e["id"],
                  }
                });
                if(check()){

                  if(regularExpressionCheck(data["password"])){
                    if(data["password"] == data["confirmPassword"]){
                        print(jsonEncode(data));
                        var response = await http.post(
                          'http://api.hoteliercard.com/api/User/Register',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(data),
                        );
                        print(response.statusCode);
                        print(response.body);

                        if(response.statusCode == 200){
                          Navigator.of(context).pop();
                        }else if(response.statusCode == 400){
                          Map body = jsonDecode(response.body);
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(body["Message"])));
                        }
                    }else{
                      setState(() {
                        dataErrorMessage["password"] = "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
                        dataErrorMessage["confirmPassword"] = "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
                      });
                    }

                  }else{
                    setState(() {
                      dataErrorMessage["password"] = "ادخل حروف و ارقام و رموز و ما لا يقل عن ثمانية مدخلات";
                    });
                  }
                }
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

  regularExpressionCheck(String data){
    RegExp regExp = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(data);
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
