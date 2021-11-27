import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:http/http.dart' as http;

class TermsOfService extends StatefulWidget {
  static const routeName = '/Terms';
  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  late Map info;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getInfoFunction();
  }

  getInfoFunction()async{
    Uri url = Uri.parse('$serverURL/Pages/?id=2');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
     print(response.body);
     info = jsonDecode(response.body);
    });
    print(response.statusCode);
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace:
          AppBarWidget("assets/hotelAppBarImage.jpg", info == null ? "" : info['PageName']),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: mainAppColor),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 160 , left: 10 , right: 10 , bottom: 80),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(info==null ? "" : info['PageBody'] ,  style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),),
        ),
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),

    );
  }
}

