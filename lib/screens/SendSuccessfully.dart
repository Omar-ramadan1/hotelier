import 'package:flutter/material.dart';

import '../widgets/AppBarWidget.dart';
import '../widgets/AppDrawerWidget.dart';
import '../widgets/bottomBarWidget.dart';




class SendSuccessfully extends StatelessWidget {
    static const routeName = '/SendSucee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          flexibleSpace:
          AppBarWidget("assets/hotel-bell.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/rightIconImage.jpg" , width: 150,),
            Container(
              child: Center(child: Text("تم ارسال شكوتك بنجاح ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF7BB85) ), textAlign: TextAlign.center,),),),


            Container(
              child: Center(child: Text("سيتم الرد عليك في اقرب وقت",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF7BB85)) , textAlign: TextAlign.center,),   ),

            ),
          ],
        ),
      ),




            bottomNavigationBar : BottomBarWidget(),

    );
  }
}