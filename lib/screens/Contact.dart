import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'package:hotelier/widgets/bottomBarWidget.dart';

class Contact extends StatefulWidget {
  static const routeName = '/Contact';
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String phone1 = "",
      phone2 = "",
      whatsApp = "",
      faceBook = "",
      twitter = "",
      snapChat = "";
  getPhone1() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=3',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      phone1 = data["PageBody"];
      print(phone1);
    });
  }

  getPhone2() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=4',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      phone2 = data["PageBody"].toString();
      print(phone2);
    });
  }

  getWhatsApp() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=5',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      whatsApp = data["PageBody"].toString();
      print(whatsApp);
    });
  }

  getFaceBook() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=6',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      faceBook = data["PageBody"].toString();
      print(faceBook);
    });
  }

  getTwitter() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=7',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      twitter = data["PageBody"].toString();
      print(twitter);
    });
  }

  getSnapChat() async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=8',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      print(jsonDecode(response.body));
      data = jsonDecode(response.body);
      snapChat = data["PageBody"].toString();
      print(snapChat);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhone1();
    getPhone2();
    getFaceBook();
    getSnapChat();
    getTwitter();
    getWhatsApp();
  }

  @override
  //  flexibleSpace: AppBarWidget("assets/ContactAppBarImage.jpg","اتصل بنا"),
  Widget build(BuildContext context) {
    final _formKey = new GlobalKey<FormState>(),
        _formKey1 = new GlobalKey<FormState>(),
        _formKey2 = new GlobalKey<FormState>(),
        _formKey3 = new GlobalKey<FormState>(),
        _formKey4 = new GlobalKey<FormState>(),
        _formKey5 = new GlobalKey<FormState>();
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
              AppBarWidget("assets/ContactAppBarImage.jpg", "اتصل بنا"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Row(
              key: _formKey,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: phone1.toString()));
                    Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${phone1.toString()}"),
                    ));
                  },
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
                Text(phone1, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              key: _formKey2,
              children: [
                InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: phone2.toString()));
                      Scaffold.of(_formKey2.currentContext)
                          .showSnackBar(SnackBar(
                        content: Text("تم نسخ ${phone2.toString()}"),
                      ));
                    },
                    child: IconButton(
                        icon: Icon(
                          Icons.phone,
                        ),
                        onPressed: null)),
                Text(phone2, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              key: _formKey3,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: snapChat.toString()));
                    Scaffold.of(_formKey3.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${snapChat.toString()}"),
                    ));
                  },
                  child: IconButton(
                      icon: Icon(FontAwesomeIcons.snapchatGhost,
                          color: Colors.yellow),
                      onPressed: null),
                ),
                Text(snapChat, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              key: _formKey4,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: faceBook.toString()));
                    Scaffold.of(_formKey4.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${faceBook.toString()}"),
                    ));
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebookSquare,
                        color: Colors.blueAccent,
                      ),
                      onPressed: null),
                ),
                Text(faceBook, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              key: _formKey5,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: whatsApp.toString()));
                    Scaffold.of(_formKey5.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${whatsApp.toString()}"),
                    ));
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.whatsappSquare,
                        color: Colors.green,
                      ),
                      onPressed: null),
                ),
                Text(whatsApp, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              key: _formKey1,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: twitter.toString()));
                    Scaffold.of(_formKey1.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${twitter.toString()}"),
                    ));
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.twitterSquare,
                        color: Colors.lightBlueAccent,
                      ),
                      onPressed: null),
                ),
                Text(twitter, style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
  //
  // check() {
  //   bool check = true;
  //   data.forEach((key, value) {
  //     if (value == null || value == '') {
  //       print('$key   $value');
  //       setState(() {
  //         dataErrorMessage[key] = "من فضلك اكمل هذه الخانة";
  //       });
  //       check = false;
  //     }
  //   });
  //
  //   return check;
  // }

  // onChangeFunction(value, String variableName) {
  //   setState(() {
  //     data[variableName] = value;
  //     dataErrorMessage[variableName] = null;
  //   });
  // }

}

class ScaffoldSnackBar extends StatefulWidget {
  @override
  _ScaffoldSnackBarState createState() => _ScaffoldSnackBarState();
}

class _ScaffoldSnackBarState extends State<ScaffoldSnackBar> {
  @override
  Widget build(BuildContext context) {
    final _formKey = new GlobalKey<FormState>();
    return Container(
      key: _formKey,
    );
  }
}
