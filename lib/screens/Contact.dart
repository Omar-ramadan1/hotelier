import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';


class Contact extends StatelessWidget {
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
      body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                         

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