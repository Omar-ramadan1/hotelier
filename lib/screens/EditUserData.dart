import 'dart:convert';
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/GetLocationScreen.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/EditTextFieldWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class EditUserData extends StatefulWidget {
    static const routeName = '/EditUserData';

  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {

  String discountValue , CityId;
  double starRating = 0;
  bool checkBoxValue = false;
  Map data, dataClone = {}, dataErrorMessage = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      UserData userDataProvider = Provider.of<UserData>(context , listen: false);
    DataList dataListProvider = Provider.of<DataList>(context , listen: false);
    print(userDataProvider.userDataClone);
      setState(() {
        data = userDataProvider.userData;
        print(userDataProvider.userData);
        CityId = dataListProvider.citiesNames[0];
      });
  }
  @override
  Widget build(BuildContext context) {
    DataList dataListProvider = Provider.of<DataList>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          flexibleSpace: AppBarWidget("assets/settingAppBarImage.jpg","الاعدادات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      resizeToAvoidBottomInset: true,
    body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
       padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("تعديل حساب"  , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w800),),
              InkWell(
                onTap: (){ uploadImages();},
                child: SignUpButtonWidget(
                    data['name'],
                    Icons.person_add_alt_1_sharp,
                    Color(0xFFF7BB85)
                    ),
              ),
              EditTextFieldWidget(data['name'] , (value) {
                onChangeFunction(value, "name");
              }),
              EditTextFieldWidget(data['idNumber'] , (value) {
                onChangeFunction(value, "idNumber");
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
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 20),
                          child: DropdownWidget(CityId, dataListProvider.citiesNames, 100, 30,
                                  (value) {
                                setState(() {
                                  CityId = value;
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
                                labelText: 'الحى',
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
              SizedBox(
                height: 10,
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
                height: 10,
              ),
              EditTextFieldWidget(data['phone'] , (value) {
                onChangeFunction(value, "phone");
              }),

              EditTextFieldWidget(data['phone'] , (value) {
                onChangeFunction(value, "phone");
              }),

              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: ()async{
                  var citiesListClone = dataListProvider.citiesList;

                  citiesListClone.forEach((e) => {
                    if (e["Name"] == CityId)
                      {
                        dataClone["CityId"] = e["id"],
                      }
                  });

                  data.forEach((key, value) {
                    if(dataClone[key] == null){
                      dataClone[key] = data[key];
                    }else{

                    }
                  });

                  print(data);
                  var response = await http.post(
                    '$serverURL/User/EditUser',
                    headers: <String, String>{
                      'Authorization':'Bearer ${data['access_token']}',
                      'Content-Type':'application/x-www-form-urlencoded',
                    },
                    body: jsonEncode(dataClone),
                  );

                  print(response.statusCode);
                  print(response.body);
                },
                  child: ButtonChildWidget("حفظ التعديلات", Color(0xFFF7BB85), 18, 150),),
              SizedBox(
                height: 25,
              ),
              ButtonChildWidget("تجديد الاشتراك", Color(0xFFF7BB85), 23, 250),
              SizedBox(
                height: 45,
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
  onChangeFunction(value, String variableName) {
    setState(() {
      dataClone[variableName] = value;
      print(dataClone[variableName]);
      print(data[variableName]);
    });
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

}
