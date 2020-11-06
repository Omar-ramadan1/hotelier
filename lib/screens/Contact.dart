import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class Contact extends StatelessWidget {
  static const routeName = '/Contact';
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
                    hintText: "                  ")),
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
                        borderRadius: BorderRadius.circular(45),),), ),
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
                )),
            SizedBox(height: 20),
            ButtonChildWidget("ارسال", Color(0xFFF7BB85), 19, 150),
          ]),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
