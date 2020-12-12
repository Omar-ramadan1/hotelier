import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/RememberMeWidgetCheckBox.dart';
import 'package:hotelier/widgets/TextFieldRegistrationWidget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool checkBoxValue = false , isSubmittingRegistration = false;
  Map data = {
    // 'grant_type': 'password',
    'email': null,
    'password': null,
  };

  Map dataErrorMessage = {'email': null, 'password': null, 'serverError': null};

  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
      dataErrorMessage['serverError'] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: size.width * 80 / 100,
        child: Column(
          children: [
            //TextFieldRegistrationWidget takes text String that will appear as hint  and Icon
            TextFieldRegistrationWidget(
              'بريد الكترونى/رقم عضوية',
              false ,
              dataErrorMessage['email'],
              Icons.person_outline_sharp,
              (value) {
                onChangeFunction(value, 'email');
              },
            ),
            //TextFieldRegistrationWidget takes text String that will appear as hint  and Icon
            TextFieldRegistrationWidget(
              'كلمة المرور',
              true ,
              dataErrorMessage['password'],
              Icons.lock_open,
              (value) {
                onChangeFunction(value, 'password');
              },
            ),
            SizedBox(
              height: 40,
            ),
            dataErrorMessage['serverError'] == null
                ? Container()
                : Text(
                    dataErrorMessage['serverError'],
                    style: TextStyle(color: Colors.red),
                  ), // RememberMeWidgetCheckBox take bool value as a initial value
            // and onchange funtion to handle the change happen
            RememberMeWidgetCheckBox(checkBoxValue, (value) {
              setState(() {
                checkBoxValue = value;
              });
            }),

            // ButtonChildWidget takes text to show , Color , fontsize and width as parameters
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                InkWell(
                  onTap: () async {
                    if (check()) {
                      setState(() {
                        isSubmittingRegistration = true;
                      });
                      print(jsonEncode(data));
                      var response = await http.post(
                        'http://api.hoteliercard.com/api/Account/CustomToken',
                        headers: <String, String>{
                          "Accept": "application/json",
                          "Content-Type": "application/json"
                        },
                        body: jsonEncode(data),
                      );
                      print(response.statusCode);
                      print(response.body);
                      Map body = jsonDecode(response.body);
                      setState(() {
                        isSubmittingRegistration = false;
                      });
                      if (response.statusCode == 200) {

                    if(body['IsHotel']){
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
                      body["img"] = newImageList;
                    }
                        if(checkBoxValue){
                          userData.updateUserInfo(body);
                           Navigator.of(context).pop();
                        }else{
                          userData.userData =  body;
                         Navigator.of(context).pop();
                        }
                      } else if(response.statusCode == 400) {
                        print(response.body);
                        setState(() {
                          dataErrorMessage['serverError'] = 'يوجد خطا فى الحساب او كلمة المرور';
                        });
                      }
                    }
                  },
                  child:
                      ButtonChildWidget("تسجيل دخول", Color(0xFFF7BB85), 25, 150),
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
          ],
        ),
      ),
    );
  }

  check() {
    bool check = true;
    data.forEach((key, value) {
      if (value == null || value == '') {
        print('$key   $value');
        setState(() {
          dataErrorMessage[key] = "من فضلك ادخل هذه الخانة";
        });
        check = false;
      }
    });

    return check;
  }
}
