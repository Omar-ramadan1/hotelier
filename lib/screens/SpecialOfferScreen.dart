import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/DropdownWidget.dart';
import 'package:hotelier/widgets/HotelContainerWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class SpecialOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(

                  children: [
                    Text(
                      "الفندق",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget( "عابدين" , ["عابدين" ,"اخر"] , 60 , 20,(value){print(value); }),
                  ],
                ),

                Column(

                  children: [
                    Text("نسبه الخصم",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget("10%" , ["10%" , "20%" , "30%" ] , 60 , 20,(value){print(value); }),
                  ],
                ),

                Column(

                  children: [
                    Text("التصنيف",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget("10%" , ["10%" , "20%" , "30%" ] , 60 , 20,(value){print(value); }),
                  ],
                ),
                Column(

                  children: [
                    Text("عدد النجوم",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    DropdownWidget('1' , ['1','2','3','4','5'] , 40 , 20,(value){print(value); }),
                  ],
                ),

              ],
            ),
            SizedBox(height: 50),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
            HotelContainerWidget(),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
