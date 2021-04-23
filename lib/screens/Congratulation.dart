import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class Congratulation extends StatelessWidget {
  static const routeName = '/Congrautlation';

  @override
  Widget build(BuildContext context) {
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
          flexibleSpace: AppBarWidget("assets/hotelAppBarImage.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: ),
              height: 140,
              width: 150,
              // child:Text("jhjk") ,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/likePhoto.jpg").image,
                    fit: BoxFit.cover , ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(45, 8, 8, 8),
                child: Text(
                  "تهانينا",
                  style: TextStyle(
                      fontSize: 45,
                      color: Color(0xFFF7BB85),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              "تم الدفع بنجاح و سيتم توصيل البطاقة  لكم",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            SizedBox(height: 25),
            InkWell(
              child: ButtonChildWidget(
                  " الرجوع الي الرئيسيه ", Color(0xFFF7BB85), 20, 190),
              onTap: () {
                Navigator.of(context)
                    .popUntil((route) {
                  print(route.settings.name);
                  if(route.settings.name == "null" || route.settings.name == null){
                    return true;
                  }else{
                    return false;
                  }

                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
