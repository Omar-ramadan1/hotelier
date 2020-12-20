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
  Map info;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getInfoFunction();
  }

  getInfoFunction()async{
    var response = await http.get(
      '$serverURL/Pages/?id=2',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
     print(response.body);
    });
    print(response.statusCode);
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          flexibleSpace:
          AppBarWidget("assets/hotelAppBarImage.jpg", info == null ? "" : info['PageName']),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(info==null ? "" : info['PageBody']),
      ),
      ),
      bottomNavigationBar : BottomBarWidget(),

    );
  }
}

