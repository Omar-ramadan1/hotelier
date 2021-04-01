import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/CartDetailsWidget.dart';
import 'package:hotelier/widgets/PaymentAlertDialogMessage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartDetailsScreen extends StatefulWidget {
  static const routeName = '/CartDetailsScreen';
  @override
  _CartDetailsScreenState createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  List data = [];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    UserData userDataProvider = Provider.of<UserData>(context, listen: false);
    if(userDataProvider.userData == null){
    }else{
      http.get(
        '$serverURL/Order/OrderList',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}'
        },
      ).then((response) => {
        setState(() {
          print(response.body);
          data = jsonDecode(response.body);
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context);
    Timer(Duration(seconds: 1), () {
      if(userDataProvider.userData == null){
        PaymentAlertDialogMessage().showInMessageWidget(context,
            "من فضلك قم بتسجيل الدخول لمتابعة مشترياتك");
      }
    });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/paymentAppBarImage.jpg", "المدفوعات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "لقد قمت بالعمليات الشرائية التالية:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              for(int i = 0 ; i < data.length ; i++) CartDetailsWidget(data[i]),
            ],
            //
          ),
        ),
      ),
    );
  }
}
