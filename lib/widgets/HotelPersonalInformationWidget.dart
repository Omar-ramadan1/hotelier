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
            SizedBox(height: 20,),
            InformationTextWidget('اسم الفندق:  ' , userDataProvider.userData['name']),
            // userDataProvider.userData['commercialRegistrationNo'] == null ? InformationTextWidget('السجل التجارى:  ' , "") :InformationTextWidget('السجل التجارى:  ' , userDataProvider.userData['commercialRegistrationNo']),
            InformationTextWidget('عدد النجوم:  ' , userDataProvider.userData['starRating'].toString()),
            InformationTextWidget('نسبة الخصم المقدمة:  ' , '${userDataProvider.userData['discountValue'].toString()} %'),
            // InformationTextWidget('هل الحساب مفعل:  ' , userDataProvider.userData['IsActive'] ? "نعم" : "لا"),
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
