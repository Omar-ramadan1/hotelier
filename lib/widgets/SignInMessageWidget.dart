import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';

 class SignInMessageWidget {

  showInMessageWidget(context){
    return showDialog(
        context: context,
        builder: (BuildContext context1) {
          return AlertDialog(
            title: Center(child: Text("تنبيه")),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text("قم بالتسجيل للدخول لهذه الصفحة"),),
            actions: [
              Container(
                margin: EdgeInsets.only(right:50),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: ButtonChildWidget("حسنا", Color(0xFFF7BB85), 18, 150),
                ),
              ),
            ],
          );
        }
    );
  }

}