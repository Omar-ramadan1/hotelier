import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/TextFieldWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class PaymentScreen extends StatelessWidget {
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
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFieldWidget("الاسم" , double.infinity ,TextDirection.rtl , "" ,),
              SizedBox(height: 10),
              TextFieldWidget("رقم الكارت", double.infinity ,TextDirection.rtl , "0000    0000    0000   0000" ,),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget("EXPIRY DATE" , 140 ,TextDirection.ltr , "MM | YY" ,),
                  TextFieldWidget("Cvv CODE" , 140 ,TextDirection.ltr , "000" ,),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ButtonChildWidget("تاكيد" , Color(0xFFF7BB85) , 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
