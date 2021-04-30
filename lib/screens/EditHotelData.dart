import 'dart:convert';
import 'dart:math';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hotelier/widgets/PaymentAlertDialogMessage.dart';
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
  final Map data;

  static const routeName = '/EditHotelData';

  const EditHotelData(this.data);
  @override
  _EditHotelDataState createState() => _EditHotelDataState();
}

class _EditHotelDataState extends State<EditHotelData> {
  TextEditingController _controller = new TextEditingController();

  String Discount = '10',
      cityId = 'الرياض',
      typeId,
      imageName,
      IsReservationsAvailable = 'متاح';
  int allowedImageNumberToBeUploaded = 10;
  List<String> availableList = ['متاح', 'غير متاح'];
  Key keyValue = ValueKey(new Random().nextInt(100));
  bool checkBoxValue = false,
      isVideoLoading = false,
      isSubmittingRegistration = false;
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
      data = widget.data;
      // print(ModalRoute.of(context).settings.arguments);
      dataListProvider.citiesList.forEach((element) {
        // print(element);
        print(data);
        if (data["cityId"] == element["id"]) {
          print(data["cityId"]);
          cityId = element["Name"];
        }
      });
      dataListProvider.categoryList.forEach((element) {
        print(element);
        if (data["typeId"] == element["id"]) {
          typeId = element["Name"];
        }
      });
      dataClone['Discount'] = data['Discount'];
      dataClone['starRating'] = data['starRating'];
      dataClone['Address'] = data['Address'];
      dataClone['HotelId'] = data['id'];
      imageName = data['userImg'];
      allowedImageNumberToBeUploaded =
          allowedImageNumberToBeUploaded - data['img'].length;
    });

    print(data['IsReservationsAvailable']);
    if (data['IsReservationsAvailable'] == true) {
      IsReservationsAvailable = 'متاح';
    } else {
      IsReservationsAvailable = 'غير متاح';
    }

    _controller.value = TextEditingValue(
        text: data['Notes'],
        selection: TextSelection(
            isDirectional: false,
            baseOffset: 4,
            extentOffset: 4));

  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);
    UserData userDataProvider = Provider.of<UserData>(context);
    DataList dataListProvider = Provider.of<DataList>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/settingAppBarImage.jpg", "الاعدادات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
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
                      DefaultCacheManager manager = new DefaultCacheManager();
                      manager.emptyCache();
                      Map respondedData = jsonDecode(value);
                      print(jsonDecode(value));
                      List imgNameArray = respondedData['imgName'];
                      setState(() {
                        PaintingBinding.instance.imageCache.clearLiveImages();
                        PaintingBinding.instance.imageCache.clear();
                        dataClone["userImg"] = imgNameArray[0];
                        imageName = imgNameArray[0];
                        keyValue = ValueKey(new Random().nextInt(100));
                      });
                    });
                  });
                },
                child: imageName == '' || imageName == null
                    ? SignUpButtonWidget(data['Name'], Icons.home_work_rounded,
                        Color(0xFFF7BB85))
                    : Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: Image.network(
                              '${anotherServerURL}Content/Images/$imageName',
                              key: keyValue,
                            ).image,
                            radius: 50,
                          ),
                          Text(data['name']),
                        ],
                      ),
              ),
              Text(
                " الفندق ${data["isActive"]}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800  , color: data["isActive"] == "غير فعال" ? Colors.red : Colors.green),
              ),
              EditTextFieldWidget("اسم الفندق", data["Name"], (value) {
                onChangeFunction(value, "Name");
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(
                    width: size.width,
                    child: EditTextFieldWidget(
                      "السعر الاساسى".toString(),
                      data["RoomPrice"].toString(),
                          (value) {
                            setState(() {
                              dataClone["RoomPrice"] = int.parse(value);
                              print(dataClone["RoomPrice"]);
                            });
                      },
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Container(
                      width:200,child: Text(dataClone['RoomPrice'] == "" || dataClone['RoomPrice'] == null? "" : "${(dataClone['RoomPrice'] - (dataClone['RoomPrice'] * dataClone['Discount']) / 100).toStringAsFixed(2)}")),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 00),
                      child: Text(
                        "نسبة الخصم المقدمة",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    DropdownWidget(
                        dataClone['Discount'].toString(),
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
                        55,
                        25, (value) {
                      setState(() {
                        dataClone['Discount'] = int.parse(value);
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _controller,
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
                        text: dataClone['Notes'],
                        selection: TextSelection(
                            isDirectional: false,
                            baseOffset: 4,
                            extentOffset: 4));
                  }
                  print(value.length);
                },
                decoration: InputDecoration(
                  hintText: data['Notes'],
                  errorText: dataErrorMessage['Notes'],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              // EditTextFieldWidget(data['commercialRegistrationNo'] == null ? "رقم السجل التجارى" : data['commercialRegistrationNo'], (value) {
              //   onChangeFunction(value.toString(), "commercialRegistrationNo");
              // } , errorText: dataErrorMessage['commercialRegistrationNo'],),
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
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "المدينة",
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
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
                          ],
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
                                labelText: data["district"],
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
                    dataClone['Address'] = address.first.addressLine;
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
                phone1: "رقم الجوال",
                phone2: "رقم الهاتف",
                phone1Text: data['PhoneNumber'],
                phone2Text: data['PhoneNumber2'],
                isEditWidget: true,
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
                        typeId, dataListProvider.categoryNames, 80, 25,
                        (value) {
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
                        IsReservationsAvailable, availableList, 80, 25,
                        (value) {
                      setState(() {
                        IsReservationsAvailable = value;
                        if (IsReservationsAvailable == 'متاح') {
                          dataClone["IsReservationsAvailable"] = true;
                          print(dataClone["IsReservationsAvailable"]);
                        } else {
                          dataClone["IsReservationsAvailable"] = false;
                          print(dataClone["IsReservationsAvailable"]);
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
              Container(
                width: size.width - 20,
                child: GridView.count(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  physics: ScrollPhysics(),
                  primary: false,
                  children: [
                    for (var imageBody in widget.data['img'])
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
                                dataClone["CityId"] = e["id"],
                                dataClone["cityId"] = e["id"],
                              }
                          });
                      categoryListClone.forEach((e) => {
                            if (e["Name"] == typeId)
                              {
                                dataClone["TypeId"] = e["id"],
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

                      // isCommercialRegistrationIs10Digits is always true as it's cancelled for now

                      if (isCommercialRegistrationIs10Digits(
                          dataClone['commercialRegistrationNo'])) {
                        setState(() {
                          isSubmittingRegistration = true;
                        });
                        var response = await http.post(
                          '$serverURL/User/EditHotelV2',
                          headers: <String, String>{
                            'Authorization':
                                'Bearer ${userDataProvider.userData["access_token"]}',
                            'Content-Type': 'application/json'
                          },
                          body: jsonEncode(dataClone),
                        );
                        print(response.statusCode);
                        print(response.body);
                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else {
                          var body = jsonDecode(response.body);
                          setState(() {
                            isSubmittingRegistration = false;
                          });
                          if (body['Message'] == null) {
                            dataClone["access_token"] = data['access_token'];
                            userDataProvider.userData = dataClone;
                            Navigator.of(context).pop();
                          } else {
                            PaymentAlertDialogMessage().showInMessageWidget(
                                context, "من فضلك قم بتسجيل الدخول مرة اخرى");
                            userDataProvider.userData = null;
                            Navigator.of(context).pop();
                          }
                        }
                      } else {
                        setState(() {
                          dataErrorMessage['commercialRegistrationNo'] =
                              'من فضلك  لابد من ادخال عشر ارقام';
                        });
                      }
                    },
                    child: ButtonChildWidget(
                        "تعديل حساب", Color(0xFFF7BB85), 18, 150),
                  ),
                  isSubmittingRegistration
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
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  locationTextHandler() {
    if (dataClone['Address'] != null) {
      return Container(
          width: 150,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            dataClone['Address'],
            style: TextStyle(fontSize: 13, color: mainAppColor),
          ));
    } else if (dataErrorMessage['Address'] != null) {
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
            isVideoLoading = false;
            // Scaffold.of(context).showSnackBar(snackBar1);
          });
        }
      });
    } else {
      // Scaffold.of(context).showSnackBar(snackBar2);
    }
  }

  isCommercialRegistrationIs10Digits(String data) {
    // RegExp regExp = new RegExp(
    //   r"^[0-9]{10}$",
    //   caseSensitive: false,
    //   multiLine: false,
    // );

    // return regExp.hasMatch(data);
    return true;
  }

  uploadImages() async {
    List images = [];
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
      UserData userDataProvider = Provider.of<UserData>(context, listen: false);
      response.stream.transform(utf8.decoder).listen((value) async {
        Map respondedData = jsonDecode(value);
        print(jsonDecode(value));
        List imgNameArray = respondedData['imgName'];

        images.add(imgNameArray[0]);
        print('$serverURL/Media/AddImg?imgName=${imgNameArray[0]}&hotelsId=${dataClone['HotelId']}');
        var response = await http.post(
          '$serverURL/Media/AddImg?imgName=${imgNameArray[0]}&hotelsId=${dataClone['HotelId']}',
          headers: <String, String>{
            'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
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
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    List filter = [];
    print(pkMediaId);
    if(data['img'].length > 1){
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
          'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
          'Content-Type': 'application/json'
        },
      );
      print(response.statusCode);
      print(response.body);
    }else{
      PaymentAlertDialogMessage().showWarningMessageWidget(context, "يجب ان يكون هناك صورتين لحذف الصورة");
    }
    }

}
