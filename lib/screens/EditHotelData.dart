import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/Constant/Constant.dart';
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
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EditHotelData extends StatefulWidget {
  static const routeName = '/EditHotel';

  @override
  _EditHotelDataState createState() => _EditHotelDataState();
}

class _EditHotelDataState extends State<EditHotelData> {
  String discountValue = '10', cityId = 'الرياض';
  double starRating = 0;
  bool checkBoxValue = false;
  Map data, dataClone = {}, dataErrorMessage = {};
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];
  onChangeFunction(value, String variableName) {
    setState(() {
      dataClone[variableName] = value;
      print(dataClone[variableName]);
      print(data[variableName]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    DataList dataListProvider = Provider.of<DataList>(context, listen: false);
    print(userDataProvider.userDataClone);
    setState(() {


      data = userDataProvider.userData;
      print(userDataProvider.userData);
      dataListProvider.citiesList.forEach((element) {
        print(element);
        if (data["cityName"] == element["id"]) {
          cityId = element["Name"];
        }
      });
      discountValue = data['discountValue'].toString();
      starRating = data['starRating'].toDouble();
      dataClone['address'] = data['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
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
              SignUpButtonWidget(
                  data['name'], Icons.home_work_rounded, Color(0xFFF7BB85)),
              EditTextFieldWidget(data['name'], (value) {
                onChangeFunction(value, "name");
              }),
              EditTextFieldWidget(data['commercialRegistrationNo'], (value) {
                onChangeFunction(value, "commercialRegistrationNo");
              }),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
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
                              onChanged: (value){onChangeFunction(value, "district");},
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
                phone1: data['phone'],
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
                        discountValue,
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
                        discountValue = value;
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
                  ButtonChildWidget("رفع صور", Color(0xFFF7BB85), 15, 100),
                  ButtonChildWidget("رفع فديو", Color(0xFFF7BB85), 15, 100),
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
                  crossAxisCount: 4,
                  children: [
                    for (var imageURL in imgList)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: HotelImageEditWidget(imageURL),
                      ),
                    for (var imageURL in imgList)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: HotelImageEditWidget(imageURL),
                      ),
                  ],
                ),
              ),
              ButtonChildWidget("تعديل حساب", Color(0xFFF7BB85), 18, 150),
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
}


// http://api.hoteliercard.com/api/Content/Images/image5fbfa71e2489b9bcaeadf55c.jpg