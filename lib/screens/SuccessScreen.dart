

import 'package:flutter/material.dart';
import 'package:hotelier/Model/ImportantInformationModel.dart';

import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  static const routeName = '/SuccessScreen';

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String cardValue = "payAtArrive";
  Map data ;

  Function changeCardValueFunction(String cardValueParamater) {
    setState(() {
      cardValue = cardValueParamater;
    });
    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImportantInformationModel importantInformationModel =
    Provider.of<ImportantInformationModel>(context, listen: false);
    data = importantInformationModel.importantInformationMap;

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
          flexibleSpace: AppBarWidget("assets/paymentAppBarImage.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/rightIconImage.jpg" , width: 200,),
                Text("تمت عملية الطلب بنجاح" , style: TextStyle(fontSize: 25),)
              ],
            ),
          ),
          ),
      ),
      //  bottomNavigationBar: BottomBarWidget(),
    );
  }
}
