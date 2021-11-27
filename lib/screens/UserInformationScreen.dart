import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/InformationTextWidget.dart';
import 'package:hotelier/widgets/SignUpButtonWidget.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String cityName = "";
    UserData userDataProvider = Provider.of<UserData>(context);
    DataList dataListProvider = Provider.of<DataList>(context);
    dataListProvider.citiesList.forEach((element) {
      if (userDataProvider.userData["cityName"] == element["id"]) {
        cityName = element["Name"];
      }
    });
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
          flexibleSpace: AppBarWidget("assets/settingAppBarImage.jpg", "حسابى"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
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
            SizedBox(height: 20,),
            Center(
              child: Container(
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
                      InformationTextWidget('الحساب :  ' , userDataProvider.userData['email']),
                      InformationTextWidget('رقم الهاتف:  ' , userDataProvider.userData['phone']),
                      // InformationTextWidget('رقم القومى:  ' , userDataProvider.userData['idNumber'].toString()),
                      InformationTextWidget('المدينة:  ' , cityName),
                    ],
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
