import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'DropdownWidget.dart';

class SignUpHotel extends StatefulWidget {
  @override
  _SignUpHotelState createState() => _SignUpHotelState();
}

class _SignUpHotelState extends State<SignUpHotel> {
  Map data = {
    'discountValue': '0',
    'starRating': 0,
    'cityName': 'الرياض',
    'hotelName': null,
    'commercialRegistrationNo': null,
    'district': null,
    'phone1': null,
    'phone2': null,
    'email': null,
    'imageURL': [],
    'videoURL': null,
    'password': null,
    'address': null,
    'confirmPassword': null,
    'latitude': null,
    'longitude': null,
    'isHotel' : true,
  };

  Map dataErrorMessage = {
    'hotelName': null,
    'commercialRegistrationNo': null,
    'district': null,
    'phone1': null,
    'phone2': null,
    'email': null,
    'imageURL': null,
    'videoURL': null,
    'password': null,
    'address': null,
    'confirmPassword': null,
  };
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
              onChanged: (value) {
                onChangeFunction(value, 'hotelName');
              },
              decoration: InputDecoration(
                labelText: 'اسم الفندق',
                errorText: dataErrorMessage['hotelName'],
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
                onChangeFunction(value, 'commercialRegistrationNo');
              },
              decoration: InputDecoration(
                labelText: 'رقم السجل التجارى',
                errorText: dataErrorMessage['commercialRegistrationNo'],
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
                      onChanged: (value) {
                        onChangeFunction(value, 'phone1');
                      },
                      decoration: InputDecoration(
                        labelText: 'رقم الجوال',
                        errorText: dataErrorMessage['phone1'],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (value) {
                        onChangeFunction(value, 'phone2');
                      },
                      decoration: InputDecoration(
                        labelText: 'رقم الجوال',
                        errorText: dataErrorMessage['phone2'],
                      ),
                    ),
                  ),
                ),
              ],
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
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  "نسبة الخصم المقدمة",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                DropdownWidget(
                    data['discountValue'],
                    [
                      '0',
                      '10',
                      '20',
                      '30',
                      '40',
                      '50',
                      '60',
                      '70',
                      '80',
                      '90',
                      '100'
                    ],
                    80,
                    0, (value) {
                  setState(() {
                    data['discountValue'] = value;
                  });
                }),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    "عدد النجوم",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        print(v);
                        setState(() {
                          data['starRating'] = v;
                        });
                      },
                      starCount: 5,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      rating: data['starRating'].toDouble(),
                      size: 30.0,
                      color: Colors.amberAccent,
                      borderColor: Colors.amberAccent,
                      spacing: 0.0),
                ],
              ),
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  List<Asset> resultList = List<Asset>();
                  resultList = await MultiImagePicker.pickImages(
                    maxImages: 10,
                    enableCamera: false,
                    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                    materialOptions: MaterialOptions(
                      actionBarColor: "#abcdef",
                      actionBarTitle: "Hotelier",
                      allViewTitle: "All Photos",
                      selectCircleStrokeColor: "#000000",
                    ),
                  );
                  resultList.forEach((element) async {
                    var response =  uploadAssetImages(element);
                  });
                },
                child: ButtonChildWidget("رفع صورة", mainAppColor, 15, 100),
              ),
              ButtonChildWidget("رفع فديو", mainAppColor, 15, 100),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                onChanged: (value) {
                  print(value);
                  setState(() {
                    checkBoxValue = value;
                  });
                },
                value: checkBoxValue,
                activeColor: mainAppColor,
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
          InkWell(
              onTap: () {
                print(check());
              },
              child: ButtonChildWidget("تسجيل حساب", mainAppColor, 18, 150)),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
    });
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
