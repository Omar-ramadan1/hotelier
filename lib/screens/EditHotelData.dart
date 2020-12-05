import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:hotelier/Functions/UploadVideo.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DoubleTextFieldWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/EditTextFieldWidget.dart';
import 'package:hotelier/widgets/HotelImageEditWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EditHotelData extends StatefulWidget {
  static const routeName = '/EditHotel';

  @override
  _EditHotelDataState createState() => _EditHotelDataState();
}

class _EditHotelDataState extends State<EditHotelData> {
  String discountValue = '10', cityId = 'الرياض', typeId;
  int allowedImageNumberToBeUploaded = 10;
  bool checkBoxValue = false, isVideoLoading = false , isSubmittingRegistration = false;
  Map data, dataClone = {}, dataErrorMessage = {};
  onChangeFunction(value, String variableName) {
    setState(() {
      dataClone[variableName] = value;
      print(dataClone[variableName]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    DataList dataListProvider = Provider.of<DataList>(context, listen: false);
    setState(() {
      data = userDataProvider.userData;
      print(data['vedio']);
      print(userDataProvider.userData);
      dataListProvider.citiesList.forEach((element) {
        print(element);
        if (data["cityName"] == element["id"]) {
          cityId = element["Name"];
        }
      });
      dataListProvider.categoryList.forEach((element) {
        print(element);
        if (data["TypeId"] == element["id"]) {
          typeId = element["Name"];
        }
      });
      dataClone['discountValue'] = data['discountValue'];
      dataClone['starRating'] = data['starRating'];
      dataClone['address'] = data['address'];
      allowedImageNumberToBeUploaded =
          allowedImageNumberToBeUploaded - data['img'].length;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    DataList dataListProvider = Provider.of<DataList>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/settingAppBarImage.jpg", "الاعدادات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "تعديل حساب",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              InkWell(
                onTap: () async {
                  var resultList = await MultiImagePicker.pickImages(
                    maxImages: 1,
                    enableCamera: false,
                    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                    materialOptions: MaterialOptions(
                      actionBarColor: "#abcdef",
                      actionBarTitle: "Hotelier",
                      allViewTitle: "All Photos",
                      selectCircleStrokeColor: "#000000",
                    ),
                  );
                  //"image${ObjectId().toHexString()}.jpg"
                  resultList.forEach((element) async {
                    var response = await uploadAssetImages(
                        element, "profileImage${data['userId']}.jpg");

                    response.stream
                        .transform(utf8.decoder)
                        .listen((value) async {
                      Map respondedData = jsonDecode(value);
                      print(jsonDecode(value));
                      List imgNameArray = respondedData['imgName'];
                      setState(() {
                        dataClone["userImg"] = imgNameArray[0];
                      });
                    });
                  });
                },
                child: data['userImg'] == '' || data['userImg'] == null
                    ? SignUpButtonWidget(data['name'], Icons.home_work_rounded,
                        Color(0xFFF7BB85))
                    : Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: Image.network(
                                    'http://api.hoteliercard.com/Content/Images/${data['userImg']}')
                                .image,
                            radius: 50,
                          ),
                          Text(data['name']),
                        ],
                      ),
              ),
              EditTextFieldWidget(data['name'], (value) {
                onChangeFunction(value, "name");
              }),
              EditTextFieldWidget(data['commercialRegistrationNo'], (value) {
                onChangeFunction(value.toString(), "commercialRegistrationNo");
              } , errorText: dataErrorMessage['commercialRegistrationNo'],),
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
                          height: 75,
                          padding: EdgeInsets.only(top: 20),
                          child: DropdownWidget(
                              cityId, dataListProvider.citiesNames, 80, 30,
                              (value) {
                            setState(() {
                              cityId = value;
                            });
                          }),
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
                              onChanged: (value) {
                                onChangeFunction(value, "district");
                              },
                              decoration: InputDecoration(
                                labelText: data['district'],
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
              InkWell(
                onTap: () async {
                  // GetLocationScreen
                  LatLng position = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => GetLocationScreen()));
                  var address = await Geocoder.local
                      .findAddressesFromCoordinates(new Coordinates(
                          position.latitude, position.longitude));
                  print(address.first.addressLine);
                  setState(() {
                    dataClone['latitude'] = position.latitude;
                    dataClone['longitude'] = position.longitude;
                    dataClone['address'] = address.first.addressLine;
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
              DoubleTextFieldWidget(
                null,
                (value, mapKeyName) {
                  onChangeFunction(value, mapKeyName);
                },
                'phone',
                phone1: data['PhoneNumber'],
                phone2: data['PhoneNumber2'],
                isEditWidget: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        "نسبة الخصم المقدمة",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    DropdownWidget(
                        dataClone['discountValue'].toString(),
                        [
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
                        30,
                        0, (value) {
                      setState(() {
                        dataClone['discountValue'] = int.parse(value);
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            print(v);
                            setState(() {
                              dataClone['starRating'] = v.toInt();
                            });
                          },
                          starCount: 5,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          rating: dataClone['starRating'].toDouble(),
                          size: 30.0,
                          color: Colors.amberAccent,
                          borderColor: Colors.amberAccent,
                          spacing: 0.0),
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
                      "التصنيف",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    DropdownWidget(
                        typeId, dataListProvider.categoryNames, 60, 25,
                        (value) {
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
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    child:
                        ButtonChildWidget("رفع فيديو", mainAppColor, 15, 100),
                  ),
                  isVideoLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SpinKitFadingCircle(
                            color: Colors.lightBlueAccent,
                            size: 20.0,
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '-:تعديل بيانات الحساب البنكى',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  )
                ],
                textDirection: TextDirection.rtl,
              ),
              EditTextFieldWidget(
                  data['BankName'] == null ? "اسم البنك" : data['BankName'],
                  (value) {
                onChangeFunction(value, "BankName");
              }),
              EditTextFieldWidget(
                  data['BankNumber'] == null
                      ? "رقم الحساب البنكى"
                      : data['BankNumber'], (value) {
                onChangeFunction(value, "BankNumber");
              }),
              EditTextFieldWidget(data['Bin'] == null ? "الايبان" : data['Bin'],
                  (value) {
                onChangeFunction(value, "Bin");
              }),
              Container(
                width: size.width - 20,
                child: GridView.count(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  children: [
                    for (var imageBody in data['img'])
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: HotelImageEditWidget(imageBody, (pkMediaId) {
                          deleteImageFunction(pkMediaId);
                        }),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  InkWell(
                      onTap: () async {
                        var citiesListClone = dataListProvider.citiesList;
                        var categoryListClone = dataListProvider.categoryList;
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
                        data.forEach((key, value) {
                          if (key == 'access_token') {
                          } else if (dataClone[key] == null) {
                            setState(() {
                              dataClone[key] = value;
                            });
                          }
                        });
                        print(dataClone);
                        if(isCommercialRegistrationIs10Digits(dataClone['commercialRegistrationNo'])){
                          setState(() {
                            isSubmittingRegistration = true;
                          });
                          var response = await http.post(
                            '$serverURL/User/EditHotel',
                            headers: <String, String>{
                              'Authorization': 'Bearer ${data["access_token"]}',
                              'Content-Type': 'application/json'
                            },
                            body: jsonEncode(dataClone),
                          );
                          print(response.statusCode);
                          print(response.body);
                          var body = jsonDecode(response.body);
                          setState(() {
                            isSubmittingRegistration = false;
                          });
                          if (body['Message'] == null) {
                            dataClone["access_token"] = data['access_token'];
                            userDataProvider.userData = dataClone;
                          }
                          Navigator.of(context).pop();
                        }else{
                          setState(() {
                            dataErrorMessage['commercialRegistrationNo'] = 'من فضلك  لابد من ادخال عشر ارقام';
                          });
                        }
                      },
                      child: ButtonChildWidget(
                          "تعديل حساب", Color(0xFFF7BB85), 18, 150),),
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
        ),
      ),
    );
  }

  locationTextHandler() {
    if (dataClone['address'] != null) {
      return Container(
          width: 150,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            dataClone['address'],
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


  uploadVideo() async {
    String name;
    final snackBar = SnackBar(content: Text('please wait till video uploads'));
    final snackBar1 = SnackBar(content: Text('video uploaded'));
    final snackBar2 = SnackBar(content: Text('your video size is too large'));
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    // Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      isVideoLoading = true;
    });
    if (data["videoURL"] == null || data["videoURL"] == '') {
      name = "Video${data['userId']}.mp4";
    } else {
      name = data["videoURL"];
    }
    var response = await saveVideoFunction(pickedFile, name);
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        Map respondedData = jsonDecode(value);
        List videoNameArray = respondedData['imgName'];
        print(jsonDecode(value));
        // Scaffold.of(context).showSnackBar(snackBar2);
        if (mounted) {
          setState(() {
            dataClone["videoURL"] = videoNameArray[0];
            setState(() {
              isVideoLoading = false;
            });
            // Scaffold.of(context).showSnackBar(snackBar1);
          });
        }
      });
    } else {
      // Scaffold.of(context).showSnackBar(snackBar2);
    }
  }

  isCommercialRegistrationIs10Digits (String data){
    RegExp regExp = new RegExp(
      r"^[0-9]{10}$",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(data);
  }

  uploadImages() async {
    List images = [];
    final snackBar = SnackBar(content: Text('please wait till image uploads'));
    // final snackBar1 = SnackBar(content: Text('images uploaded'));
    List<Asset> resultList = List<Asset>();

    resultList = await MultiImagePicker.pickImages(
      maxImages: allowedImageNumberToBeUploaded,
      enableCamera: false,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "#abcdef",
        actionBarTitle: "Hotelier",
        allViewTitle: "All Photos",
        selectCircleStrokeColor: "#000000",
      ),
    );
    // Scaffold.of(context).showSnackBar(snackBar);
    //
    resultList.forEach((element) async {
      var response = await uploadAssetImages(
          element, "image${ObjectId().toHexString()}.jpg");

      response.stream.transform(utf8.decoder).listen((value) async {
        Map respondedData = jsonDecode(value);
        print(jsonDecode(value));
        List imgNameArray = respondedData['imgName'];

        images.add(imgNameArray[0]);
        var response = await http.post(
          '$serverURL/Media/AddImg?imgName=${imgNameArray[0]}',
          headers: <String, String>{
            'Authorization': 'Bearer ${data["access_token"]}',
            'Content-Type': 'application/json'
          },
        );
        print(response.body);
        print(response.statusCode);
        // {PK_MediId: 33, FileName: image5fbfa71e2489b9bca}
        //{"imgName":true,"id":17}
        Map body = jsonDecode(response.body);
        Map imageData = {
          'PK_MediId': body['id'],
          'FileName': imgNameArray[0],
        };
        setState(() {
          data["img"].add(imageData);
          allowedImageNumberToBeUploaded = 10 - data['img'].length;
        });
      });
    });
  }

  void deleteImageFunction(pkMediaId) async {
    List filter = [];
    print(pkMediaId);
    data['img'].forEach((element) {
      if (element['PK_MediId'] == pkMediaId) {
        print(element['PK_MediId']);
      } else {
        filter.add(element);
      }
    });
    setState(() {
      data['img'] = filter;
      allowedImageNumberToBeUploaded = 10 - data['img'].length;
    });
    var response = await http.post(
      '$serverURL/Media/DeleatImg?id=$pkMediaId',
      headers: <String, String>{
        'Authorization': 'Bearer ${data["access_token"]}',
        'Content-Type': 'application/json'
      },
    );
    print(response.statusCode);
    print(response.body);
  }
}

// http://api.hoteliercard.com/Content/Images/image5fbfa71e2489b9bcaeadf55c.jpg
