import 'package:flutter/material.dart';
class PaymentAlertDialogMessage  {
  showInMessageWidget(context , String text){
    return showDialog(
        context: context,
        builder: (BuildContext context1) {
          return AlertDialog(
            title: Center(child: Text("تنبيه")),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(text),),
            actions: [
              Container(
                margin: EdgeInsets.only(right:110),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("حسنا", style: TextStyle(fontSize: 20),),
                ),
              ),
            ],
          );
        }
    );
  }
}
