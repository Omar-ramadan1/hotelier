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
  Map data = {
    'name': null,
    'email': null,
    'subject': 'شكوى',
    'message': null,
  };

  Map dataErrorMessage = {
    'name': null,
    'email': null,
    'message': null,
  };


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
                    onChangeFunction(value, 'name');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['name'],
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
                    onChangeFunction(value, 'email');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['email'],
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
                    DropdownWidget(data['subject'], ["شكوى", 'اقتراح'], 40, 0,
                        (value) {
                      setState(() {
                        data['subject'] = value;
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
                    onChangeFunction(value, 'message');
                  },
                  decoration: InputDecoration(
                    errorText: dataErrorMessage['message'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    check();
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
