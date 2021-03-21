import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotelier/Model/ImportantInformationModel.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  static const routeName = '/Contact';
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Map data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImportantInformationModel importantInformationModel =
        Provider.of<ImportantInformationModel>(context, listen: false);

    data = importantInformationModel.importantInformationMap;
  }

  @override
  //  flexibleSpace: AppBarWidget("assets/ContactAppBarImage.jpg","اتصل بنا"),
  Widget build(BuildContext context) {
    final _formKey = new GlobalKey<FormState>(),
        _formKey1 = new GlobalKey<FormState>(),
        _formKey2 = new GlobalKey<FormState>(),
        _formKey3 = new GlobalKey<FormState>(),
        _formKey4 = new GlobalKey<FormState>(),
        _formKey5 = new GlobalKey<FormState>(),
        _formKey6 = new GlobalKey<FormState>(),
        _formKey7 = new GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
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
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
              AppBarWidget("assets/ContactAppBarImage.jpg", "اتصل بنا"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Row(
              key: _formKey6,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: data["Email"].toString()));
                    Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${data["Email"].toString()}"),
                    ));
                  },
                  child: IconButton(icon: Icon(Icons.email_rounded), onPressed: null),
                ),
                Text(data["Email"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: data["phone1"].toString()));
                    Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                      content: Text("تم نسخ ${data["phone1"].toString()}"),
                    ));
                  },
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
                Text(data["phone1"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey2,
              children: [
                InkWell(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: data["phone2"].toString()));
                      Scaffold.of(_formKey2.currentContext)
                          .showSnackBar(SnackBar(
                        content: Text("تم نسخ ${data["phone2"].toString()}"),
                      ));
                    },
                    child: IconButton(
                        icon: Icon(
                          Icons.phone,
                        ),
                        onPressed: null)),
                Text(data["phone2"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey3,
              children: [
                InkWell(
                  onTap: () async{
                    Clipboard.setData(new ClipboardData(text: "${data["snapChat"].toString()}"));
                    Scaffold.of(_formKey3.currentContext).showSnackBar(SnackBar(
                        content: Text('${data["snapChat"].toString()}تم نسخ ')));
                  },
                  child: IconButton(
                      icon: Icon(FontAwesomeIcons.snapchatGhost,
                          color: Colors.yellow),
                      onPressed: null),
                ),
                Text(data["snapChat"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey7,
              children: [
                InkWell(
                  onTap: () async{
                    String url = 'https://www.instagram.com/${data["Instagram"].toString()}/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('من فضلك تاكد من وجود متصفح على الهاتف')));
                    }
                  },
                  child: IconButton(icon: Icon(FontAwesomeIcons.instagramSquare , color: Colors.purple.shade400,), onPressed: null),
                ),
                Text(data["Instagram"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey4,
              children: [
                InkWell(
                  onTap: () async{
                    String url = 'https://www.facebook.com/${data["FaceBook"].toString()}';
                    if (await canLaunch(url)) {
                    await launch(url);
                    }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('من فضلك تاكد من وجود جوجل مابس على الهاتف')));
                    }
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebookSquare,
                        color: Colors.blueAccent,
                      ),
                      onPressed: null),
                ),
                Text(data["FaceBook"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey5,
              children: [
                InkWell(
                  onTap: () async{
                    String url = 'https://wa.me/${data["WhatsApp"].toString()}';
                    if (await canLaunch(url)) {
                    await launch(url);
                    }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('من فضلك تاكد من وجود جوجل مابس على الهاتف')));
                    }
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.whatsappSquare,
                        color: Colors.green,
                      ),
                      onPressed: null),
                ),
                Text(data["WhatsApp"].toString(),
                    style: TextStyle(color: Colors.black87))
              ],
            ),
            Row(
              key: _formKey1,
              children: [
                InkWell(
                  onTap: () async{
                    String url = 'https://mobile.twitter.com/${data["Twitter"].toString()}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('من فضلك تاكد من وجود متصفح على الهاتف')));
                    }
                  },
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.twitterSquare,
                        color: Colors.lightBlueAccent,
                      ),
                      onPressed: null),
                ),
                Text(data["Twitter"].toString(),
                    style: TextStyle(color: Colors.black87))
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
