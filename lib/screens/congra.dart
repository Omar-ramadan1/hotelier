
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/TextFieldWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';


class Congratulation extends StatelessWidget {
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
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:130),
            Center(child: Padding(
              padding: const EdgeInsets.fromLTRB(45,8,8,8),
              child: Text("تهانينا",style: TextStyle(fontSize:65,color:Color(0xFFF7BB85),fontWeight: FontWeight.bold),),
            ),
            ),
            Text("تم الدفع بنجاح",style: TextStyle(fontSize:17,fontWeight:FontWeight.bold),),
            Text("يمكنك الان التوجه لمنافذنا",style: TextStyle(fontSize:17,fontWeight:FontWeight.bold),),
            Text("وتقديم الرقم الخاص  بك",style: TextStyle(fontSize:17,fontWeight:FontWeight.bold),),
                                    SizedBox(height:20),

                        Text("   رقم العضويه",style: TextStyle(fontSize:37,fontWeight:FontWeight.bold),),
           Padding(
             padding: const EdgeInsets.fromLTRB(100,0,100,8),
             child: TextFieldWidget(
                  "",
                  double.infinity,
                  TextDirection.rtl,
                  "2020120",
                ),
           ),
           SizedBox(height:25),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               IconButton(icon: Icon(Icons.picture_as_pdf,size: 50,), onPressed: null),
                IconButton(icon: Icon(Icons.copy,size: 50,), onPressed: null)

             ],
           ),
                      SizedBox(height:25),

              InkWell(
                        child: ButtonChildWidget(
                            " الرجوع الي الرئيسيه ",
                                Color(0xFFF7BB85),
                                
                            20 , 190),
                        onTap: () {
                          
                        },
                      ),



          ],
        ),
      ) ,
            bottomNavigationBar : BottomBarWidget(),

    );
  }
}