import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/screens/SendSuccessfully.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:http/http.dart' as http;
class Complaining extends StatefulWidget {
  static const routeName = '/Complaining';

  @override
  _ComplainingState createState() => _ComplainingState();
}

class _ComplainingState extends State<Complaining> {
  Map data = {
    'Name': null,
    'Email': null,
    'Type': 'شكوى',
    'Message': null,
  };

  Map dataErrorMessage = {
    'Name': null,
    'Email': null,
    'Message': null,
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/complainAppBarImage.jpg", "شكاوى و مقترحات"),
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
          padding: EdgeInsets.only(left: 20 , right: 20 , top: 170 , bottom: 100),
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
                  textDirection: TextDirection.rtl,
                  children: [
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
                  onChanged: (value) {
                    onChangeFunction(value, 'Name');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['Name'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
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
                  onChanged: (value) {
                    onChangeFunction(value, 'Email');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['Email'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "الموضوع",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    DropdownWidget(data['Type'], ["شكوى", 'اقتراح'], 70, 30,
                        (value) {
                      setState(() {
                        data['Type'] = value;
                      });
                    }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
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
                  onChanged: (value) {
                    onChangeFunction(value, 'Message');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['Message'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: ()async{
                    if(check()){
                      print(data);
                      var response = await http.post(
                        '$serverURL/Comlains',
                        headers: <String, String>{
                          'Content-Type': 'application/json'
                        },
                        body: jsonEncode(data),
                      );
                      print(response.statusCode);
                      print(response.body);
                      if(response.statusCode < 300){
                            Navigator.of(context).popAndPushNamed(SendSuccessfully.routeName);
                      }
                    }
                  },
                  child: ButtonChildWidget("ارسال", Color(0xFFF7BB85), 18, 130),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  check() {
    bool check = true;
    data.forEach((key, value) {
      if (value == null || value == '') {
        print('$key   $value');
        setState(() {
          dataErrorMessage[key] = "من فضلك اكمل هذه الخانة";
        });
        check = false;
      }
    });

    return check;
  }

  onChangeFunction(value, String variableName) {
    setState(() {
      data[variableName] = value;
      dataErrorMessage[variableName] = null;
    });
  }



}
