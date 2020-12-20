import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/CartDetailsWidget.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          flexibleSpace: AppBarWidget("assets/paymentAppBarImage.jpg", "المدفوعات"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "لقد قمت بالعمليات الشرائية التالية",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
