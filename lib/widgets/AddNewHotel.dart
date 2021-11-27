import 'dart:convert';

import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadVideo.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/StateDependentClasses/AddNewHotelState.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DoubleTextFieldWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/SingleTextFieldWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AddNewHotel extends StatefulWidget {
  @override
  _AddNewHotelState createState() => _AddNewHotelState();
}

class _AddNewHotelState extends State<AddNewHotel> {
  TextEditingController _controller = new TextEditingController();
  late String cityId,
      typeId,
      errorString = '',
      IsReservationsAvailable = "متاح";
  bool isVideoLoading = false,
      isSubmittingRegistration = false;
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
  ],
      availableList = ['متاح', 'غير متاح'];

  Map data = {
    'discountValue': '10',
    'CityId': 'CityId',
    'starRating': 1,
    'TypeId': 'categoryId',
    'Name': null,
    "RoomPrice": null,
    'IsReservationsAvailable': true,
    'district': null,
    'phone1': null,
    'phone2': "",
    'imageURL': [],
    'videoURL': "",
    'Notes': null,
    'address': null,
    'latitude': null,
    'longitude': null,
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
    'address': null,
    'confirmPassword': null,
  };
  bool checkBoxValue = false , finishedAdding = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataList dataList = Provider.of<DataList>(context, listen: false);
    cityId = dataList.citiesNames[0];
    typeId = dataList.categoryNames[0];
  }
  @override
  Widget build(BuildContext context) {
    DataList dataList = Provider.of<DataList>(context);
    UserData userData = Provider.of<UserData>(context);


    AddNewHotelState addNewHotelState = new AddNewHotelState(
        this, dataList, userData, context);
    Size size = MediaQuery
        .of(context)
        .size;
    if(finishedAdding){
      return Container(
        height: 400,
        child: Center(child: Text("لقد تمت الاضافة بنجاح" , style: TextStyle(color: Colors.green , fontSize: 25 , fontWeight: FontWeight.w700),)),
      );
    }else{
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(125.0),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading:
            IconButton(
              icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            flexibleSpace:
            AppBarWidget("assets/settingAppBarImage.jpg", "الاعدادات"),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: size.width /1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: mainAppColor,
                      border: Border.all(color: Color(0xFFBD954F), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text("قم بادخال فرع بيانات جديدة" , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 25, ),),),
                  SingleTextFieldWidget('اسم الفندق', dataErrorMessage['Name'],
                          (value) {
                        onChangeFunction(value, "Name");
                      }),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                        width: 200,
                        child: SingleTextFieldWidget('السعر الاساسى', dataErrorMessage['RoomPrice'],
                              (value) {
                            onChangeFunction(value, "RoomPrice");
                          }, textInputType: TextInputType.number,),
                      ),
                      Column(
                        children: [
                          Text("السعر بعد الخصم"),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              width:50,child: Text(data['RoomPrice'] == null || data['RoomPrice'] == "" ? "" : "${(int.parse(data['RoomPrice']) - (int.parse(data['RoomPrice']) * int.parse(data['discountValue'])) / 100).toStringAsFixed(2)}")),
                        ],
                      ),
                    ],
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
                              child: Text("المدينة",
                                style: TextStyle(fontWeight: FontWeight.w800),),
                            ),
                            Container(
                              width: 100,
                              height: 75,
                              padding: EdgeInsets.only(top: 20),
                              child: DropdownWidget(
                                  cityId, dataList.citiesNames, 80, 30,
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
                          addNewHotelState.locationTextHandler(),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  DoubleTextFieldWidget(
                    dataErrorMessage['phone1'], (value, mapKeyName) {
                    onChangeFunction(value, mapKeyName);
                  }, 'phone1',),
                  TextField(
                    controller: _controller,
                    maxLengthEnforced: true,
                    maxLines: 4,
                    maxLength: 2000,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      if (value.length <= 2000) {
                        onChangeFunction(value, 'Notes');
                      } else {
                        // _controller.text = data['Notes'];
                        _controller.value = TextEditingValue(
                            text: data['Notes'],
                            selection: TextSelection(
                                isDirectional: false, baseOffset: 4, extentOffset: 4)
                        );
                      }
                      print(value.length);
                    },
                    decoration: InputDecoration(
                      hintText: "إضافة الباكدج أو الوصف",
                      errorText: dataErrorMessage['Notes'],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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
                            85,
                            25, (value) {
                          setState(() {
                            typeId = value;
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
                          "الحجز",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        DropdownWidget(
                            IsReservationsAvailable,
                            availableList,
                            85,
                            25, (value) {
                          setState(() {
                            IsReservationsAvailable = value;
                            if (IsReservationsAvailable == 'نعم') {
                              data["IsReservtionAvailable"] = true;
                            } else {
                              data["IsReservtionAvailable"] = false;
                            }
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
                        onTap: addNewHotelState.uploadImages,
                        child: ButtonChildWidget("رفع الصور", mainAppColor, 15, 100),
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
                  errorString == "" ? Container() : Text(
                    errorString, style: TextStyle(color: Colors.red, fontSize: 14),),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      InkWell(
                        onTap: addNewHotelState.addNewHotelFunction,
                        child: ButtonChildWidget("تاكيد اضافة الفرع", mainAppColor, 18, 150),
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
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

  }
  uploadVideo() async {
    final snackBar = SnackBar(content: Text('please wait till video uploads'));
    final snackBar1 = SnackBar(content: Text('video uploaded'));
    final snackBar2 = SnackBar(content: Text('your video size is too large'));
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      isVideoLoading = true;
    });
    var response = await saveVideoFunction(
        pickedFile!, "video${ObjectId().toHexString()}.mp4");
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        Map respondedData = jsonDecode(value);
        List videoNameArray = respondedData['imgName'];
        print(jsonDecode(value));
        if (mounted) {
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
  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
      errorString = "";
    });
  }
}
