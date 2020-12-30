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
    String cityName;
    UserData userDataProvider = Provider.of<UserData>(context);
    DataList dataListProvider = Provider.of<DataList>(context);
    dataListProvider.citiesList.forEach((element) {
      print(element);
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
            SizedBox(height: 20,),
            InformationTextWidget('اسم المستخدم:  ' , userDataProvider.userData['name']),
            InformationTextWidget('رقم الهاتف:  ' , userDataProvider.userData['phone']),
            // InformationTextWidget('رقم القومى:  ' , userDataProvider.userData['idNumber'].toString()),
            InformationTextWidget('المدينة:  ' , cityName),
          ],
        ),
      ),
    );
  }
}
