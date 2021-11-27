import 'dart:convert';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/widgets/PaymentAlertDialogMessage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/TextFieldRegistrationWidget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String cardValue = "payAtArrive";
  int x;
  Map data = {
    "email" : null
  };
  Map dataErrorMessage = {'email': null , "serverError" : null};
  bool  isSubmittingRegistration = false;

  onChangeFunction(value, String variableName) {
    print(dataErrorMessage['serverError']);
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
      dataErrorMessage['serverError'] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Container(
            width: size.width * 90 / 100,

            child: Column(

              children: [
                SizedBox(height: size.height * 4 / 100,),
                //TextFieldRegistrationWidget takes text String that will appear as hint  and Icon
                TextFieldRegistrationWidget(
                  'البريد الكترونى',
                  false ,
                  dataErrorMessage['email'],
                  Icons.person_outline_sharp,
                      (value) {
                    onChangeFunction(value, 'email');
                  },
                ),

           SizedBox(height: size.height * 35 / 100,),
                dataErrorMessage['serverError'] == null
                    ? Container(height: 10,)
                    : Text(
                  dataErrorMessage['serverError'],
                  style: TextStyle(color: Colors.red , fontSize: 22),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (check()) {
                          if(data["email"].contains(" ")){
                            setState(() {
                              dataErrorMessage["email"] = "من فضلك تاكد تاكد من عدم وجود مسافات بيضاء";
                              isSubmittingRegistration = false;
                            });
                          }else{
                            setState(() {
                              isSubmittingRegistration = true;
                            });
                            Uri url = Uri.parse('$serverURL/Account/PasswordResetByEmail?Email=${data["email"]}');
                            var response = await http.post(
                              url,
                              headers: <String, String>{
                                "Content-Type": "application/json",
                              },
                            );
                            print(response.statusCode);
                            setState(() {
                              isSubmittingRegistration = false;
                            });
                            if (response.statusCode < 300) {
                              PaymentAlertDialogMessage().showInMessageWidget(context, "تمت العملية بنجاح , تفقد البريدك الخاص");
                            } else if(response.statusCode >= 400) {
                              print(response.body);
                              Map body = jsonDecode(response.body);
                              setState(() {
                                dataErrorMessage['serverError'] = body["Message"];
                              });
                            }else if(response.statusCode >= 500) {
                              print(response.body);
                              setState(() {
                                dataErrorMessage['serverError'] = 'لقد حدث خطا ما فى سيرفر';
                              });
                            }
                          }
                        }
                      },
                      child:
                      ButtonChildWidget("ارسال", Color(0xFFF7BB85), 25, 150),
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
                SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      )
      //  bottomNavigationBar: BottomBarWidget(),
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
