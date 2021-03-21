import 'dart:convert';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';

class About extends StatefulWidget {
  static const routeName = '/About';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  Map info;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getInfoFunction();
  }

  getInfoFunction()async{
    var response = await http.get(
      '$serverURL/Pages/?id=1',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    setState(() {
      info = jsonDecode(response.body);
    });
    print(response.statusCode);
    print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          // ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
          AppBarWidget("assets/hotelAppBarImage.jpg", "عن التطبيق"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: Container(decoration: BoxDecoration(

      ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: mainAppColor),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 40 , left: 10 , right: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text("تطبيق متميز في تقديم خدمة ترفيهيه لرواد الفنادق والمنتجعات حيث يقدم بطاقة خصم مباشرة للعميل يقدر يستفيد من خلالها بخصومات ويحصل على تخفيض عند الحجز طوال السنة ويستطيع تجديدها بكل سهولة عند انتهاء فترة الاشتراك وذلك على كافة فنادق - منتجعات - اجنحة فندقية شاليهات شقق مفروشة - استراحات المسجلة في انحاء المملكة داخل التطبيق" ,
            style: TextStyle(
              fontWeight: FontWeight.w700,
                  fontSize: 20,
            ),),
          ),
        ),
      ),
      bottomNavigationBar : BottomBarWidget(),

    );
  }
}
