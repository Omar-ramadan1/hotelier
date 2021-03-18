import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorWidget extends StatelessWidget {
  final Map data;


  const SponsorWidget(this.data);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10  ),
      width: size.width,
      child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, right: size.width / 4),
            height: 50,
            width: size.width / 1.5,
            decoration: BoxDecoration(
              color: mainAppColor,
              border: Border.all(color: Color(0xFFBD954F), width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                data["name"].toString(),
                style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w700),
              ),
            ),
          ),
          InkWell(

            onTap: ()async{
              String url =  data["link"].toString();
              if (await canLaunch(url)) {
              await launch(url);
              }else{
              Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('من فضلك تاكد من وجود متصفح على الهاتف')));
              }
            },
            splashColor: mainAppColor,
            child: Container(
              margin: EdgeInsets.all(3),
              height: 75,
              width: 130,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Color(0xFFBD954F), width: 2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '${anotherServerURL}Content/Images/${data["img"]}',
                    ).image,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Stack(
// children: [
// Center(
// child: Container(
// padding: EdgeInsets.all(5),
// width: size.width - 20,
// decoration: BoxDecoration(
// color: mainAppColor,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(10),
// topRight: Radius.circular(10),
// bottomLeft: Radius.circular(10),
// bottomRight: Radius.circular(10)
// ),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 5,
// blurRadius: 7,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// margin: EdgeInsets.only(top: 20 , bottom: 10),
// child: Column(
// children: [
// Row(
// textDirection: TextDirection.rtl,
// children: [
// Text("اسم الفندق:" , textDirection: TextDirection.rtl,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
// SizedBox(width: 15,),
// Text("فندق الشهداء" ,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey),),
// ],
// ),
//
// SizedBox(height: 10,),
// Row(
// textDirection: TextDirection.rtl,
// children: [
// Text("رقم الهاتف:" , textDirection: TextDirection.rtl,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
// SizedBox(width: 15,),
// Text("0125744401" ,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey),),
// ],
// ),
// SizedBox(height: 10,),
// Row(
// textDirection: TextDirection.rtl,
// children: [
// Text("سعر الغرفة:" , textDirection: TextDirection.rtl,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
// Text("250" ,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey ), ),
// ],
// ),
// Row(
// textDirection: TextDirection.rtl,
// children: [
// Text("الحجز:" , textDirection: TextDirection.rtl,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
// Text("متاح" ,
// style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey ), ),
// ],
// ),
// MaterialButton(
// splashColor: mainAppColor,
// onPressed: (){
// print("hello");
// },
// child: ButtonChildWidget("تعديل البيانات" , Colors.grey , 22 , 180),
// )
// ],
// ),
// ),
// ),
// InkWell(
// splashColor: Colors.blue,
// onTap: (){
// print("hello");
// },
// child: Container(
// width: 17,
// height: 17,
// margin: EdgeInsets.all(30),
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.all(Radius.circular(20),
// ),
// boxShadow: [
// BoxShadow(
// color: Colors.black,
// spreadRadius: 1.5,
// blurRadius: 8,
// offset: Offset(-1, 2), // changes position of shadow
// ),
// ],
// ),
// child: Center(child: Text("X")),
// ),
// )
// ],
// );
