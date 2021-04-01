import 'package:flutter/material.dart';
import 'package:hotelier/Model/ImportantInformationModel.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'MainScreen.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  void initState() {
    // TODO: implement initState
    super.initState();
    DataList dataList = Provider.of<DataList>(context, listen: false);
    ImportantInformationModel contactUsModel =
        Provider.of<ImportantInformationModel>(context, listen: false);
    UserData userData = Provider.of<UserData>(context, listen: false);
    dataList.checkCache();
    dataList.getCitiesListFunction();
    userData.checkIfUserDataOnMobileStorage();
    dataList.getTypesListFunction();
    contactUsModel.getContactUsDataListFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      imageBackground: Image.asset("./assets/SplashScreenImage.jpg").image,
      loaderColor: Colors.transparent,
      navigateAfterSeconds: MainScreen.routeName,
    );
  }
}
