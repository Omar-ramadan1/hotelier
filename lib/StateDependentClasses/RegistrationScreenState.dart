import 'dart:convert';

import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:hotelier/screens/PersonalInformationScreen.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
class RegistrationScreenState {
  final state , dataList , userData , context;

  RegistrationScreenState(this.state , this.dataList,  this.userData , this.context);

  signUpFunction() async{

    print(this.state.data["imageURL"]);
    var citiesListClone = dataList.citiesList;
    var categoryListClone = dataList.categoryList;
    if (this.state.data["videoURL"] == null) {
      ScaffoldMessenger.of(this.state.context).showSnackBar(SnackBar(
          content: Text('من فضلك قم بارفاق فديو لاكمال التسجيل')));
    }
    citiesListClone.forEach((e) => {
      if (e["Name"] == this.state.cityId)
        {
          this.state.data["CityId"] = e["id"],
        }
    });
    categoryListClone.forEach((e) => {
      if (e["Name"] == this.state.typeId)
        {
          this.state.data["TypeId"] = e["id"],
        }
    });
    if (check()) {
      print(this.state.data);
      if (regularExpressionCheck(this.state.data["password"])) {
        if (this.state.data["password"] == this.state.data["confirmPassword"]) {
          if (this.state.data["imageURL"].length == 0) {
            ScaffoldMessenger.of(this.state.context).showSnackBar(SnackBar(
              content: Text(
                  'من فضلك قم بارفاق على الاقل صورة واحدة'),),);
          } else {
            if(isCommercialRegistrationIs10Digits(this.state.data['commercialRegistrationNo'].toString())){
              if(emailCheck(this.state.data['email'])){
                if(this.state.data['email'].contains(" ")){
                  this.state.setState(() {
                    this.state.dataErrorMessage["email"] = "من فضلك تاكد تاكد من عدم وجود مسافات بيضاء";
                    this.state.errorString = "من فضلك تاكد من ادخال الايميل لا يوجد مسافات بيضاء تماما";
                  });
                }else{
                  print("entered");
                  print("jsonEncode(data)");
                  if(this.state.isVideoLoading){
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
                                  this.state.setState(() {
                                    this.state.isSubmittingRegistration = true;
                                  });
                                  print(this.state.data["imageURL"]);
                                  var response = await http.post(
                                    '$serverURL/User/V2/RegisterHotel',
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode(this.state.data),
                                  );
                                  print(response.statusCode);
                                  print(response.body);
                                  this.state.setState(() {
                                    this.state.isSubmittingRegistration = false;
                                  });
                                  if (response.statusCode == 200) {
                                    var response = await http.post(
                                      '$serverURL/Account/CustomToken',
                                      headers: <String, String>{
                                        "Accept": "application/json",
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonEncode({'email' : this.state.data['email'] , 'password' : this.state.data['password']}),
                                    );
                                    Map body = jsonDecode(response.body);
                                    if(body['IsHotel']){
                                      // this handle a server error which may add photo to the hotel with no name
                                      print(body["img"]);
                                      List imageList = body["img"];
                                      List newImageList = [];
                                      imageList.forEach((element) {
                                        if(element['FileName'] == ''){
                                          print('entered');
                                          http.post(
                                            '$serverURL/Media/DeleatImg?id=${element['PK_MediId']}',
                                            headers: <String, String>{
                                              'Authorization': 'Bearer ${body["access_token"]}',
                                              'Content-Type': 'application/json'
                                            },
                                          );
                                        }else{
                                          newImageList.add(element);
                                        }
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('لقد تم التسجيل بنجاح')));
                                      body["img"] = newImageList;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('لقد تم التسجيل بنجاح')));
                                  userData.updateUserInfo(body);
                                    Navigator.of(context)
                                        .popUntil((route) {
                                      print(route.settings.name);
                                      if(route.settings.name == "/MainScreen"){
                                        return true;
                                      }else{
                                        return false;
                                      }

                                    });
                                    Navigator.of(context).pushNamed(PersonalInformationScreen.routeName);
                                  } else if (response.statusCode == 400) {
                                    Map body = jsonDecode(response.body);
                                    if(body["Phone"] != null){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(body["Phone"] , style: TextStyle(fontSize: 22 ,),),),);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        //Message
                                          content: Text(body["Message"] , style: TextStyle(fontSize: 22 ,))));
                                    }
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

                  }
                  else{
                    this.state.setState(() {
                      this.state.isSubmittingRegistration = true;
                    });
                    print(this.state.data["imageURL"]);
                    var response = await http.post(
                      '$serverURL/User/V2/RegisterHotel',
                      headers: <String, String>{
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode(this.state.data),
                    );
                    print(response.statusCode);
                    print(response.body);
                    if (response.statusCode == 200) {
                      var response = await http.post(
                        '$serverURL/Account/CustomToken',
                        headers: <String, String>{
                          "Accept": "application/json",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode({'email' : this.state.data['email'] , 'password' : this.state.data['password']}),
                      );
                      Map body = jsonDecode(response.body);
                      print(body);
                      if(body['IsHotel']){
                        // this handle a server error which may add photo to the hotel with no name
                        print(body["img"]);
                        List imageList = body["img"];
                        List newImageList = [];
                        imageList.forEach((element) {
                          if(element['FileName'] == ''){
                            print('entered');
                            http.post(
                              '$serverURL/Media/DeleatImg?id=${element['PK_MediId']}',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${body["access_token"]}',
                                'Content-Type': 'application/json'
                              },
                            );
                          }else{
                            newImageList.add(element);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('لقد تم التسجيل بنجاح')));
                        body["img"] = newImageList;
                      }
                      userData.updateUserInfo(body);
                      Navigator.of(context)
                          .popUntil((route) {
                        print(route.settings.name);
                        if(route.settings.name == "null" || route.settings.name == null){
                          return true;
                        }else{
                          return false;
                        }

                      });
                      Navigator.of(context).pushNamed(PersonalInformationScreen.routeName);
                    } else if (response.statusCode == 400) {
                      this.state.setState(() {
                        this.state.isSubmittingRegistration = false;
                      });
                      Map body = jsonDecode(response.body);
                      if(body["Phone"] != null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(body["Phone"] , style: TextStyle(fontSize: 22 ,),),),);
                      }else{
                        ScaffoldMessenger.of(this.state.context).showSnackBar(SnackBar(
                            content: Text('هذا الايميل مستخدم من قبل' , style: TextStyle(fontSize: 22 ,))));
                      }
                    }
                  }
                }
              }else{
                this.state.setState(() {
                  this.state.dataErrorMessage["email"] = "من فضلك تاكد من ادخال الايميل بشكل صحيح";
                  this.state.errorString = "من فضلك تاكد من ادخال الايميل بهذا الشكل test@gmail.com";
                });
              }
            }else{
              this.state.setState(() {
                this.state.errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
                this.state.dataErrorMessage['commercialRegistrationNo'] = 'من فضلك  لابد من ادخال عشر ارقام و تاكد ان اول رقم ليس صفر';
              });
            }
          }
        } else {
          this.state.setState(() {
            this.state.errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
            this.state.dataErrorMessage["password"] =
            "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
            this.state.dataErrorMessage["confirmPassword"] =
            "من فضلك تاكد من تطابق كلمة المرور و تاكيدها";
          });
        }
      } else {
        this.state.setState(() {
          this.state.errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
          this.state.dataErrorMessage["password"] = "يجب ادخال ست مدخلات";
        });
      }
    }
  }

  onChangeFunction(value, String variableName) {
    this.state.setState(() {
      this.state.data[variableName] = value;
      this.state.dataErrorMessage[variableName] = null;
      this.state.errorString = "";
    });
  }

  check() {
    bool check = true;
    this.state.data.forEach((key, value) {
      if (value == null) {
        print('$key   $value');
        this.state.setState(() {
          this.state.errorString = "من فضلك اصعد لاعلى لاستكمال البيانات بشكل صحيح";
          this.state.dataErrorMessage[key] = "من فضلك اكمل هذه الخانة";
        });
        check = false;
      }
    });

    return check;
  }

  emailCheck(data) {
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.com",
      caseSensitive: false,
      multiLine: false,
    );

    return regExp.hasMatch(data);
  }

  isCommercialRegistrationIs10Digits (String data){
    // RegExp regExp = new RegExp(
    //   r"^[0-9]{10,10}$",
    //   caseSensitive: false,
    //   multiLine: false,
    // );

    // return regExp.hasMatch(data);
    return true;
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    length = resultList.length;
    resultList.forEach((element) async {
      var response = await uploadAssetImages(element , "image${ObjectId().toHexString()}.jpg");

      response.stream.transform(utf8.decoder).listen((value) {
        Map respondedData = jsonDecode(value);
        print(jsonDecode(value));
        List imgNameArray = respondedData['imgName'];
        images.add(imgNameArray[0]);

        if (images.length == length) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar1);
          this.state.setState(() {
            this.state.data["imageURL"] = images;
          });
        }
      });
    });
  }

  locationTextHandler() {
    if (this.state.data['address'] != null) {
      return Container(
          width: 140,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Text(
            this.state.data['address'],
            style: TextStyle(fontSize: 13, color: mainAppColor),
          ));
    } else if (this.state.dataErrorMessage['address'] != null) {
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