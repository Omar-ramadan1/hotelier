import 'dart:convert';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/screens/termsOfservice.dart';
import 'package:hotelier/widgets/DoubleTextFieldWidget.dart';
import 'package:hotelier/widgets/SingleTextFieldWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:hotelier/Functions/UploadVideo.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'DropdownWidget.dart';

class SignUpHotel extends StatefulWidget {
  @override
  _SignUpHotelState createState() => _SignUpHotelState();
}

class _SignUpHotelState extends State<SignUpHotel> {
  String cityId , typeId , errorString = '';
  bool isVideoLoading = false , isSubmittingRegistration = false;
  List<String> discountList = [
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
  ];

  Map data = {
    'discountValue': '10',
    'CityId': 'CityId',
    'starRating': 1,
    'TypeId' : 'categoryId',
    'Name': null,
    'commercialRegistrationNo': null,
    'district': null,
    'phone1': null,
    'phone2': "",
    'email': null,
    'imageURL': [],
    'videoURL': "",
    'password': null,
    'address': null,
    'confirmPassword': null,
    'latitude': null,
    'longitude': null,
    // 'bankName' : null,
    // 'bankNumber':null,
    // 'bin' : null,
    'isHotel': true,
  };

  Map dataErrorMessage = {
    'Name': null,
    'commercialRegistrationNo': null,
    'district': null,
    'phone1': null,
    'email': null,
    'imageURL': null,
    'videoURL': null,
    'password': null,
    'address': null,
    'confirmPassword': null,
  };
  bool checkBoxValue = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    DataList dataList = Provider.of<DataList>(context);
    cityId = dataList.citiesNames[0];
    typeId = dataList.categoryNames[0];
  }

  @override
  Widget build(BuildContext context) {
    DataList dataList = Provider.of<DataList>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 80 / 100,
      child: Column(
        children: [
          SingleTextFieldWidget('اسم الفندق', dataErrorMessage['Name'],
              (value) {
            onChangeFunction(value, "Name");
          }),
          SingleTextFieldWidget(
              'رقم السجل التجارى', dataErrorMessage['commercialRegistrationNo'],
              (value) {
            onChangeFunction(int.parse(value), "commercialRegistrationNo");
          }),
          Container(
            width: size.width,
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                        child: Text("المدينة" , style: TextStyle(fontWeight: FontWeight.w800),),
                    ),
                    Container(
                      width: 100,
                      height: 75,
                      padding: EdgeInsets.only(top: 20),
                      child: DropdownWidget(cityId, dataList.citiesNames, 80, 30,
                              (value) {
                            setState(() {
                              cityId = value;
                            });
                          }),
                    ),
                  ],
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
          DoubleTextFieldWidget(dataErrorMessage['phone1'] , (value , mapKeyName){
            onChangeFunction(value, mapKeyName);
          } , 'phone1',),

          SingleTextFieldWidget(
              'الايميل', dataErrorMessage['email'],
                  (value) {
                onChangeFunction(value, "email");
              }),

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
                    discountList,
                    45,
                    25, (value) {
                  setState(() {
                    data['discountValue'] = value;
                  });
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  "التصنيف",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                DropdownWidget(
                    typeId,
                    dataList.categoryNames,
                    60,
                    25, (value) {
                  setState(() {
                    typeId = value;
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
                      allowHalfRating: false,
                      onRated: (v) {
                        print(v);
                        setState(() {
                          data['starRating'] = v.ceil();
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
          SizedBox(height: 30,),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data["imageURL"].length == 0 ? Container() : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(data["imageURL"].length.toString(),
                  ),
              ),
              InkWell(
                onTap: () {
                  uploadImages();
                },
                child: ButtonChildWidget("رفع صورة", mainAppColor, 15, 100),
              ),
              InkWell(
                  onTap: () async {
                    uploadVideo();
                  },
                  child: ButtonChildWidget("رفع فيديو", mainAppColor, 15, 100),
              ),
              isVideoLoading ? Container(
                margin: EdgeInsets.only(top: 20),
                child: SpinKitFadingCircle(
                  color: Colors.lightBlueAccent,
                  size: 20.0,
                ),
              ) : Container(),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          SingleTextFieldWidget(
              'كلمة المرور', dataErrorMessage['password'],
                  (value) {
                onChangeFunction(value, "password");
              } , obscureText: true),
          SingleTextFieldWidget(
              'تاكيد كلمة المرور', dataErrorMessage['confirmPassword'],
                  (value) {
                onChangeFunction(value, "confirmPassword");
              }, obscureText: true),
          SingleTextFieldWidget('اسم البنك', dataErrorMessage['bankName'],
                  (value) {
                onChangeFunction(value, "bankName");
              }),
          SingleTextFieldWidget('رقم البنك', dataErrorMessage['bankNumber'],
                  (value) {
                onChangeFunction(value, "bankNumber");
              }),
          SingleTextFieldWidget('الايبان', dataErrorMessage['bin'],
                  (value) {
                onChangeFunction(value, "bin");
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(TermsOfService.routeName);
                },
                child: Text(
                  'اوافق على الشروط و الاحكام',
                  style: TextStyle(fontSize: 18 , color: Colors.blue),
                ),
              ),

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
            ],
          ),
          errorString == ""?Container() : Text(errorString , style: TextStyle(color: Colors.red , fontSize: 14),),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              InkWell(
                  onTap: () async {
                    print(data["imageURL"]);
                    var citiesListClone = dataList.citiesList;
                    var categoryListClone = dataList.categoryList;
                    if (data["videoURL"] == null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('من فضلك قم بارفاق فديو لاكمال التسجيل')));
                    }
                    citiesListClone.forEach((e) => {
                          if (e["Name"] == cityId)
                            {
                              data["CityId"] = e["id"],
                            }
                        });
                    categoryListClone.forEach((e) => {
                      if (e["Name"] == typeId)
                        {
                          data["TypeId"] = e["id"],
                        }
                    });
                    if (check()) {
                      if (regularExpressionCheck(data["password"])) {
                        if (data["password"] == data["confirmPassword"]) {
                          if (data["imageURL"].length == 0) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'من فضلك قم بارفاق على الاقل صورة واحدة'),),);
                          } else {
                            if(isCommercialRegistrationIs10Digits(data['commercialRegistrationNo'].toString())){
                              print("entered");
                              print("jsonEncode(data)");
                              if(isVideoLoading){
                                print("entered");
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context1) {
                                    return AlertDialog(
                                      title: Text("AlertDialog"),
                                      content: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text("الفديو مازال يرفع هل ترغب فى المتابعة و رفع الفديو لاحقا"),),

                                      actions:
                                      [
                                        Container(
                                          margin: EdgeInsets.only(right: 70),
                                          child: InkWell(
                                            onTap: ()async{
                                              Navigator.of(context1).pop();
                                              setState(() {
                                                isSubmittingRegistration = true;
                                              });
                                              print(data["imageURL"]);
                                              var response = await http.post(
                                                '$serverURL/User/RegisterHotel',
                                                headers: <String, String>{
                                                  'Content-Type': 'application/json',
                                                },
                                                body: jsonEncode(data),
                                              );
                                              print(response.statusCode);
                                              print(response.body);
                                              setState(() {
                                                isSubmittingRegistration = false;
                                              });
                                              if (response.statusCode == 200) {
                                                Navigator.of(context).pop();
                                              } else if (response.statusCode == 400) {
                                                Scaffold.of(context).showSnackBar(
                                                    SnackBar(content: Text('هذا الايميل مستخدم من قبل')));
                                              }
                                            },
                                            child: Text("نعم" , style: TextStyle(fontSize: 20),),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 70),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("لا"  , style: TextStyle(fontSize: 20),),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              }else{
                                setState(() {
                                  isSubmittingRegistration = true;
                                });
                                print(data["imageURL"]);
                                var response = await http.post(
                                  '$serverURL/User/RegisterHotel',
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode(data),
                                );
                                print(response.statusCode);
                                print(response.body);
                                setState(() {
                                  isSubmittingRegistration = false;
                                });
                                if (response.statusCode == 200) {
                                  Navigator.of(context).pop();
                                } else if (response.statusCode == 400) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('هذا الايميل مستخدم من قبل')));
                                }
                              }
                            }else{
                              setState(() {
                                errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
                                dataErrorMessage['commercialRegistrationNo'] = 'من فضلك  لابد من ادخال عشر ارقام و تاكد ان اول رقم ليس صفر';
                              });
                            }
                          }
                        } else {
                          setState(() {
                            errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
                            dataErrorMessage["password"] =
                                "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
                            dataErrorMessage["confirmPassword"] =
                                "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
                          });
                        }
                      } else {
                        setState(() {
                          errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
                          dataErrorMessage["password"] =
                              "يجب ادخال ست مدخلات";
                        });
                      }
                    }
                  },
                  child: ButtonChildWidget("تسجيل حساب", mainAppColor, 18, 150),
              ),

              isSubmittingRegistration ? Container(
                margin: EdgeInsets.only(top: 20),
                child: SpinKitFadingCircle(
                  color: Colors.lightBlueAccent,
                  size: 20.0,
                ),
              ) : Container(),
            ],
          ),
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
      errorString = "";
    });
  }

  check() {
    bool check = true;
    data.forEach((key, value) {
      if (value == null) {
        print('$key   $value');
        setState(() {
          errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
          dataErrorMessage[key] = "من فضلك اكمل هذه الخانة";
        });
        check = false;
      }
    });

    return check;
  }

  isCommercialRegistrationIs10Digits (String data){
    RegExp regExp = new RegExp(
      r"^[0-9]{10,10}$",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(data);
  }
  uploadVideo() async {
    final snackBar = SnackBar(content: Text('please wait till video uploads'));
    final snackBar1 = SnackBar(content: Text('video uploaded'));
    final snackBar2 = SnackBar(content: Text('your video size is too large'));
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      isVideoLoading = true;
    });
    var response = await saveVideoFunction(pickedFile , "video${ObjectId().toHexString()}.mp4");
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        Map respondedData = jsonDecode(value);
        List videoNameArray = respondedData['imgName'];
        print(jsonDecode(value));
        if(mounted){
          setState(() {
            data["videoURL"] = videoNameArray[0];
            setState(() {
              isVideoLoading = false;
            });
            Scaffold.of(context).showSnackBar(snackBar1);
          });
        }

      });
    } else {
      Scaffold.of(context).showSnackBar(snackBar2);
    }
  }

  regularExpressionCheck(String data) {
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9]{6,}$",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(data);
  }

  uploadImages() async {
    List images = [];
    int length;
    final snackBar = SnackBar(content: Text('please wait till image uploads'));
    final snackBar1 = SnackBar(content: Text('images uploaded'));
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
    Scaffold.of(context).showSnackBar(snackBar);
    length = resultList.length;
    resultList.forEach((element) async {
      var response = await uploadAssetImages(element , "image${ObjectId().toHexString()}.jpg");

      response.stream.transform(utf8.decoder).listen((value) {
        Map respondedData = jsonDecode(value);
        print(jsonDecode(value));
        List imgNameArray = respondedData['imgName'];
        images.add(imgNameArray[0]);

        if (images.length == length) {
          Scaffold.of(context).showSnackBar(snackBar1);
          setState(() {
             data["imageURL"] = images;
          });
        }
      });
    });
  }

  locationTextHandler() {
    if (data['address'] != null) {
      return Container(
          width: 140,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            data['address'],
            style: TextStyle(fontSize: 13, color: mainAppColor),
          ));
    } else if (dataErrorMessage['address'] != null) {
      return Container(
        width: 140,
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
