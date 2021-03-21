import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ControllingNumberOfHotelSSettingScreenHotelInfoWidget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ControllingNumberOfHotelSSettingScreen extends StatefulWidget {
  static const routeName = '/ControllingNumberOfHotelSSettingScreen';
  @override
  _ControllingNumberOfHotelSSettingScreenState createState() =>
      _ControllingNumberOfHotelSSettingScreenState();
}

class _ControllingNumberOfHotelSSettingScreenState
    extends State<ControllingNumberOfHotelSSettingScreen> {
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotelList();
  }
  getHotelList()async{
    UserData userData = Provider.of<UserData>(context , listen: false);
    var response = await http.post(
      '$serverURL/Hotels/V2/HotelsUserList',
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization" : "Bearer ${userData.userData["access_token"]}"
      },
    );
    print(response.statusCode);
    if(response.statusCode < 300){
      setState(() {
        data = jsonDecode(response.body);
      });
    }
  }
  filterDataList(int id){
    List dataClone = [];
    data.forEach((element) {
      if(element["id"] == id){

      }else{
        dataClone.add(element);
      }
      setState(() {
        data = dataClone;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          // ],
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/settingAppBarImage.jpg", "الاعدادات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            for(int i = 0 ; i < data.length ; i++)
            CNOHSSHIW(data[i] , filterDataList),
          ],
        ),
      ),
    );
  }
}
