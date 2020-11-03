import 'package:flutter/material.dart';

import '../widgets/AppBarWidget.dart';
import '../widgets/AppDrawerWidget.dart';
import '../widgets/bottomBarWidget.dart';




class Send_Successfully extends StatelessWidget {
    static const routeName = '/SendSucee';

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
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15,0,15,80),
            height: 240,
            width: 150,
            child: CircleAvatar(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 80),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: 
     //   AssetImage("assets/card.jpg"),
         NetworkImage(
      // "https://scontent.faly2-2.fna.fbcdn.net/v/t1.0-9/51877485_2277687155623321_6076822903532290048_o.jpg?_nc_cat=101&ccb=2&_nc_sid=8bfeb9&_nc_ohc=nQSqrNrPxlEAX-CjvzZ&_nc_ht=scontent.faly2-2.fna&oh=88bcdaa010846c64b8acf24de81be3ec&oe=5FC075F7"
          //    "https://previews.123rf.com/images/rawpixel/rawpixel1901/rawpixel190103913/115929028-green-right-tick-icon-isolated.jpg"
          ""
         ),
        fit: BoxFit.cover
        
        ),
        
      ),
      

    ),
            ),
          ),
          Container(
            child: Center(child: Text("تم ارسال شكوتك بنجاح ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF7BB85) ), textAlign: TextAlign.center,),),),
            

          Container(
            child: Center(child: Text("سيتم الرد عليك في اقرب وقت",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF7BB85)) , textAlign: TextAlign.center,),   ),
            
          ),
        ],
      ),




            bottomNavigationBar : BottomBarWidget(),

    );
  }
}