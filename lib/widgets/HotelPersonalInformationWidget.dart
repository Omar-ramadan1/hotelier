import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/InformationImageViewer.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/GoogleMapWidget.dart';
import 'package:hotelier/widgets/InformationTextWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:provider/provider.dart';

class HotelPersonalInformationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/settingAppBarImage.jpg", "حسابى"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
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
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0,0), // changes position of shadow
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: userDataProvider.userData['IsActive']  ?  Colors.lightGreenAccent : Colors.redAccent,
                radius: 10,
              ),
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.all(5),
                width: size.width - 20,
                decoration: BoxDecoration(
                  color: mainAppColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 20 , bottom: 10),
                child: Column(
              children: [
                InformationTextWidget('اسم الفندق:  ' , userDataProvider.userData['name']),
                InformationTextWidget('الحساب:  ' , userDataProvider.userData['IsActive'] ? "مفعل" : "غير مفعل و سيفعل قريبا"),
                InformationTextWidget('عدد النجوم:  ' , userDataProvider.userData['starRating'].toString()),
                InformationTextWidget('نسبة الخصم المقدمة:  ' , '${userDataProvider.userData['discountValue'].toString()} %'),
              ],
            )),
            Container(
              height: 200,
                child: GoogleMapWidget(userDataProvider.userData['latitude'] , userDataProvider.userData['longitude'])
              ,),
            SizedBox(height: 30,),
            InformationImageViewer(userDataProvider.userData['img']),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
