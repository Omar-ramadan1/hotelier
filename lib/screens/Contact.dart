import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class Contact extends StatefulWidget {
  static const routeName = '/Contact';
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
  //  flexibleSpace: AppBarWidget("assets/ContactAppBarImage.jpg","اتصل بنا"),
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
          flexibleSpace: AppBarWidget("assets/ContactAppBarImage.jpg","اتصل بنا"),
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
              children: [
                IconButton(icon: Icon(Icons.email), onPressed: null),
                Text("info@Hoteliercard@gmail.com",
                    style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.phone), onPressed: null),
                Text("012748534585", style: TextStyle(color: Color(0xFFF7BB85)))
              ],
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.location_history), onPressed: null),
                Text("المملكه العربيه السعوديه/جده",
                    style: TextStyle(color: Color(0xFFF7BB85)))
              ],
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

