import 'package:flutter/material.dart';
import 'package:hotelier/screens/SignInScreen.dart';
import 'package:hotelier/screens/SignUpScreen.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';


class RegistrationScreen extends StatefulWidget {
  static const routeName = '/RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String registration ;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context).settings.arguments;

      setState(() {
        registration = args;
      });
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: TextDirection.rtl,
                children: [
                  InkWell(
                    // ButtonChildWidget take parameters
                    // text , Color , text font and widget width
                    child: ButtonChildWidget(
                        "تسجيل الدخول",
                        registration == "signIn"
                            ? Color(0xFFF7BB85)
                            : Colors.white,
                        18 , 150),
                    onTap: () {
                      setState(() {
                        registration = "signIn";
                      });
                    },
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        registration = "signUp";
                      });
                    },
                    // ButtonChildWidget take parameters
                    // text , Color , text font and widget width
                    child: ButtonChildWidget(
                        "تسجيل حساب",
                        registration == "signUp"
                            ? Color(0xFFF7BB85)
                            : Colors.white,
                        18 , 150),
                  ),
                ],
              ),
              registration == "signIn" ?
              SignInScreen() : SignUpScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
