import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/EnableAddingNewHotel.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/InformationImageViewer.dart';
import 'package:hotelier/widgets/AddNewHotel.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/GoogleMapWidget.dart';
import 'package:hotelier/widgets/InformationTextWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HotelPersonalInformationWidget extends StatefulWidget {
  @override
  _HotelPersonalInformationWidgetState createState() =>
      _HotelPersonalInformationWidgetState();
}

class _HotelPersonalInformationWidgetState
    extends State<HotelPersonalInformationWidget> {
  int i = 0;
  @override
  void initState() {
    EnableAddingNewHotel enableAddingNewHotel =
        Provider.of<EnableAddingNewHotel>(context, listen: false);
    enableAddingNewHotel.isEnabled = true;
    // TODO: implement initState
    super.initState();
    getIsUserActive();
  }

  getIsUserActive() async {
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    Map data = userDataProvider.userData;
    var request = await http.get(
      '$serverURL/User/IsActive',
      headers: <String, String>{
        'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
        'Content-Type': 'application/json'
      },
    );
    print(request.body);
    if (request.statusCode < 300) {
      print("request.body");
      print(request.body);
      Map body = jsonDecode(request.body);
      data["IsActive"] = body["IsActive"];
      userDataProvider.userData = data;
      print("userDataProvider.userData[IsActive]");
      print(userDataProvider.userData["IsActive"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    EnableAddingNewHotel enableAddingNewHotel =
        Provider.of<EnableAddingNewHotel>(this.context);
    Size size = MediaQuery.of(context).size;
    UserData userDataProvider = Provider.of<UserData>(context);
    print(userDataProvider.userData['IsActive']);
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
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/settingAppBarImage.jpg", "حسابى"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      extendBodyBehindAppBar: true,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 160),

          child: Column(
            children: [
              userDataProvider.userData['userImg'] == '' ||
                      userDataProvider.userData['userImg'] == null
                  ? SignUpButtonWidget(userDataProvider.userData['name'],
                      Icons.home_work_rounded, Color(0xFFF7BB85))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: Image.network(
                                  '${anotherServerURL}Content/Images/${userDataProvider.userData['userImg']}')
                              .image,
                          radius: 50,
                        ),
                      ],
                    ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: userDataProvider.userData['IsActive']
                      ? Colors.lightGreenAccent
                      : Colors.redAccent,
                  radius: 10,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  width: size.width - 20,
                  decoration: BoxDecoration(
                    color: mainAppColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    children: [
                      InformationTextWidget(
                          'اسم الفندق:  ', userDataProvider.userData['name']),
                      InformationTextWidget(
                          'الحساب:  ',
                          userDataProvider.userData['IsActive']
                              ? "مفعل"
                              : "غير مفعل و سيفعل قريبا"),
                      InformationTextWidget('عدد النجوم:  ',
                          userDataProvider.userData['starRating'].toString()),
                      InformationTextWidget('نسبة الخصم المقدمة:  ',
                          '${userDataProvider.userData['discountValue'].toString()} %'),
                    ],
                  )),
              Container(
                height: 200,
                child: GoogleMapWidget(userDataProvider.userData['latitude'],
                    userDataProvider.userData['longitude']),
              ),
              SizedBox(
                height: 30,
              ),
              InformationImageViewer(userDataProvider.userData['img']),
              SizedBox(
                height: 30,
              ),
              for (int k = 0; k < i; k++) AddNewHotel(),
              enableAddingNewHotel.isEnabled
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          i++;
                          enableAddingNewHotel.isEnabled = false;
                        });
                      },
                      child: ButtonChildWidget(
                          "اضافة فرع جديد", mainAppColor, 20, 200),
                    )
                  : Container(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
