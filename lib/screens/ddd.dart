// @ -0,0 +1,131 @@
// import 'package:flutter/material.dart';

// import '../widgets/AppBarWidget.dart';
// import '../widgets/AppDrawerWidget.dart';
// import '../widgets/ButtonWidget.dart';
// import '../widgets/TextFieldWidget.dart';
// import '../widgets/bottomBarWidget.dart';


// class Offer_Details extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//             Size size =  MediaQuery.of(context).size;

//     return Scaffold(
//            drawerScrimColor: Colors.transparent,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(90.0),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           shadowColor: Colors.transparent,
//           flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"),
//         ),
//       ),
//       drawerEdgeDragWidth: 200,
//       drawer: AppDrawerWidget(),
//       body:SingleChildScrollView(
//               child: Column(
//           children: [
//             SizedBox(height:15),
//             Row(children: [

//               Spacer(),
                                    
//                  Text("النجوم",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),
//                       ),
                      
//                  Spacer(),
//                  Text("التنصيف",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
//              //    TextField(),
//                  Spacer(),
//                  Text("نسبه الخصم",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
//                  Spacer(),
//                  Text("الاسم",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                 
              
               
              
              
        
//          ],),

//          SizedBox(height:50),
//    Container(
     
//      child: Row(
//      children:[
//          Container(child: Column(
//            children:[
//              Padding(
//                padding: const EdgeInsets.fromLTRB(42,8,0,8),
//                child: Text("فندق المعمرين الرياض",style: TextStyle(fontSize:20),
//                ),
               
//              ),
//               Padding(
//                padding: const EdgeInsets.fromLTRB(50,8,0,8),
//                child: Text("شارع اجياد 23 الرياض\nالمملكه العربيه السعوديه",style: TextStyle(fontSize:16),
//                ),
               
//              ),
//             //  MaterialButton(onPressed: null,
//             //  splashColor: Colors.green,
//             //  color: Colors.red,
//             //  child:Text("المزيد من التفاصيل",style:TextStyle(fontSize: 20,
//             //  color:Color(0xFFF7BB85)
             
//             //  ),
//             //  ),
             
//             //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             //  )
            
//                          ButtonChildWidget("المزيد من التفاصيل",Color(0xFFF7BB85),14),
//                          Spacer()

  
//            ]
//          ),
//          ),
//          //Spacer(),
//          Container(
//            width: 173,
//            child: Column(
//            children:[
//              Padding(padding: EdgeInsets.fromLTRB(50, 8, 0, 8),
//              child: Text(""),
             
//              ),
             

//            ]
//          ),
//          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//        //  image: DecorationImage(image:NetworkImage("https://image.freepik.com/free-photo/image-human-brain_99433-298.jpg")),
//          color: Colors.green
//          ),
//          )
//      ]
//    ),
//         decoration: BoxDecoration(
//                       borderRadius:  BorderRadius.circular(40),
//                       color: Colors.blue ,
                      
//                       ),
//                       height: 200,
//             width: size.width / 1.1,
   
//    ),
//           ],



//         ),
//       ) ,
//                         bottomNavigationBar : BottomBarWidget(),

      
//     );
//   }
// }