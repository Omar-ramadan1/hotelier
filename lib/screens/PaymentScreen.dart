//
// import 'package:flutter/material.dart';
// import 'package:hotelier/widgets/AppBarWidget.dart';
// import 'package:hotelier/widgets/AppDrawerWidget.dart';
// import 'package:hotelier/widgets/ButtonWidget.dart';
// import 'package:hotelier/widgets/CreditCardChoiceWidget.dart';
// import 'package:hotelier/widgets/MainScreenCardWidget.dart';
// import 'package:hotelier/widgets/TextFieldWidget.dart';
//
// class PaymentScreen extends StatefulWidget {
//   static const routeName = '/PaymentScreen';
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   String cardValue = "" ;
//
//   Function changeCardValueFunction(String cardValueParamater){
//     setState(() {
//       cardValue = cardValueParamater;
//     });
//     return null;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       drawerScrimColor: Colors.transparent,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(125.0),
//         child: AppBar(
//           automaticallyImplyLeading: true,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//           backgroundColor: Colors.white,
//           shadowColor: Colors.transparent,
//           flexibleSpace:
//           AppBarWidget("assets/paymentAppBarImage.jpg", ""),
//         ),
//       ),
//       drawerEdgeDragWidth: 200,
//       drawer: AppDrawerWidget(),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               MainScreenCardWidget("assets/paymentContainer.jpg",null),
//               Text("سعر البطاقه 150 ريال شامل التوصيل",style: TextStyle(fontWeight:FontWeight.bold,),),
//                            SizedBox(height: 20),
//               CreditCardChoiceWidget(cardValue , changeCardValueFunction),
//               SizedBox(height: 20),
//               Text(
//                 "برجاء اختيار طريقة الدفع",
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
//               ),
//               TextFieldWidget(
//                 "الاسم",
//                 double.infinity,
//                 TextDirection.rtl,
//                 "",
//               ),
//               SizedBox(height: 10),
//               TextFieldWidget(
//                 "رقم الكارت",
//                 double.infinity,
//                 TextDirection.rtl,
//                 "0000    0000    0000   0000",
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextFieldWidget(
//                     "EXPIRY DATE",
//                     140,
//                     TextDirection.ltr,
//                     "MM | YY",
//                   ),
//                   TextFieldWidget(
//                     "Cvv CODE",
//                     140,
//                     TextDirection.ltr,
//                     "000",
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ButtonChildWidget("تاكيد", Color(0xFFF7BB85), 25, 150),
//             ],
//           ),
//         ),
//       ),
//     //  bottomNavigationBar: BottomBarWidget(),
//     );
//   }
// }
