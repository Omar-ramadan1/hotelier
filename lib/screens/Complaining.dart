import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';


class Complaining extends StatelessWidget {
  static const routeName = '/Complaining';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg","شكاوي وافتراحات\n COMPLAINT"),
          
        ),
        
        
      ),
      body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 
              Text("ارسل شكوتك فقط وقم بملاء جميع البيانات  المطلوبه",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                 Text("انتظر الرد خلال 48 ساعه",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                 SizedBox(height:20),
                          Row(
                            children: [
                              Spacer(),
                              Text("الاسم",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                            ],
                          ),
                            TextField(
                              decoration:InputDecoration(
                                
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                hintText: " "
                              )
                            ),
                            SizedBox(height:10),
                              Row(
                            children: [
                              Spacer(),
                              Text("الايميل",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                            ],
                          ),
                            TextField(
                              decoration:InputDecoration(
                                
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                hintText: "                  "
                              )
                            ),
                            Row(
                            children: [
                              Spacer(),
                              Text("الموضوع",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                            ],
                          ),
                            TextField(
                              decoration:InputDecoration(
                                
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                hintText: "                  "
                              )
                            ),
                            
                            
                            
                              Row(
                            children: [
                              Spacer(),
                              Text("اكتب وصف الرساله",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                            ],
                          ),
                            TextField(
                              maxLines: 7,
                              decoration:InputDecoration(
                                
                                
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                hintText: "         "
                              )
                            ),
                            
                            SizedBox(height:20),
                               RaisedButton(
                        child: Text( 'ارسال شكوه',style: TextStyle(fontSize: 20,color: Colors.black),),
                        onPressed: null,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                              color: Color(0xFFF7BB85),
                              textColor: Theme.of(context).primaryTextTheme.button.color
                      ),


               ]

            ),



        ),
      ),
            bottomNavigationBar : BottomBarWidget(),

    );
  }
}