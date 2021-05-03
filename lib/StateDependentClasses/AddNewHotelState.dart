import 'dart:convert';
import 'package:hotelier/Model/EnableAddingNewHotel.dart';
import 'package:http/http.dart' as http;
import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Functions/UploadAssetImages.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
class AddNewHotelState {
  final state , dataList , userData , context;

  AddNewHotelState(this.state, this.dataList, this.userData, this.context);

  addNewHotelFunction() async {
    EnableAddingNewHotel enableAddingNewHotel = Provider.of<EnableAddingNewHotel>(context , listen: false);
    print(this.state.data["imageURL"]);
    var citiesListClone = dataList.citiesList;
    var categoryListClone = dataList.categoryList;
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
    if(check()){
      if (this.state.data["imageURL"].length == 0) {
        ScaffoldMessenger.of(this.state.context).showSnackBar(SnackBar(
          content: Text(
              'من فضلك قم بارفاق على الاقل صورة واحدة'),),);
      }else{
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
                          '$serverURL/User/V2/RegisterSubHotel',
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
                          Navigator.of(this.state.context).pop();
                          // this.state.setState(() {
                          //   this.state.finishedAdding = true;
                          //   enableAddingNewHotel.isEnabled = true;
                          // });
                        } else if (response.statusCode == 400) {
                          Map body = jsonDecode(response.body);
                          if(body["Phone"] != null){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(body["Phone"] , style: TextStyle(fontSize: 22 ,),),),);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('هذا الايميل مستخدم من قبل' , style: TextStyle(fontSize: 22 ,))));
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
        else {
          this.state.setState(() {
            this.state.isSubmittingRegistration = true;
          });

          print(userData.userData["access_token"]);
          var response = await http.post(
            '$serverURL/User/V2/RegisterSubHotel',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':'Bearer ${userData.userData["access_token"]}'
            },
            body: jsonEncode(this.state.data),
          );
          print(response.statusCode);
          print(response.body);
          if(response.statusCode < 300){
            print("entered");
            Navigator.of(this.state.context).pop();
            // this.state.setState(() {
            //   this.state.finishedAdding = true;
            //   enableAddingNewHotel.isEnabled = true;
            // });
          }else if(response.statusCode < 400 && response.statusCode > 300){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('لقد حدث خطاما و محتاج تسجل مرة اخرى حهندلها بعدين حاضر' , style: TextStyle(fontSize: 22 ,))));
          }
        }
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