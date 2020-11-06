import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';



class Complaining extends StatefulWidget {
  static const routeName = '/Complaining';

  @override
  _ComplainingState createState() => _ComplainingState();
}


class _ComplainingState extends State<Complaining> {
  

String user;
String discountValue;
  


    
  @override

  
 
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/hotel-bell.jpg", "شكاوى و مقترحات"),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "ارسل شكوتك فقط وقم بملاء جميع البيانات  المطلوبه",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "انتظر الرد خلال 48 ساعه",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "الاسم",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        hintText: " ")),
                SizedBox(height: 10),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "الايميل",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        hintText: "")),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "الموضوع",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        hintText: "")),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "اكتب وصف الرساله",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TextField(
                    maxLines: 7,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "")),
                SizedBox(height: 20),
                ButtonChildWidget("ارسال" , Color(0xFFF7BB85) , 18 , 130),
              ]),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
