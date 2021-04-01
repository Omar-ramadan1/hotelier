import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ControllingNumberOfHotelSSettingScreenHotelInfoWidget.dart';
import 'package:hotelier/widgets/SponserWidget.dart';
import 'package:http/http.dart' as http;
class SponsorsScreen extends StatefulWidget {
  static const routeName = '/SponsorsScreen';
  @override
  _SponsorsScreenState createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
  List data = [];
  final key = new GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotelList();
  }
  getHotelList()async{
    var response = await http.get(
      '$serverURL/SuccessPartners/List',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if(response.statusCode < 300){
      List body = jsonDecode(response.body);
      setState(() {
        data = body;
      });
    }
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
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace:
          AppBarWidget("assets/settingAppBarImage.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainAppColor, width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text("شركاء النجاح" , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 30 , color: mainAppColor), ),),

              for(int i = 0 ; i < data.length ; i++)
              SponsorWidget(data[i]),
              // CNOHSSHIW(),
              // CNOHSSHIW(),
              // CNOHSSHIW(),
              // CNOHSSHIW(),
            ],
          ),
        ),
      ),
    );
  }
}
