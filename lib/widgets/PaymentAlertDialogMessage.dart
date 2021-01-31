import 'package:flutter/material.dart';
import 'package:hotelier/screens/CartDetailsScreen.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
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
                margin: EdgeInsets.only(right:70),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pop();
                    Navigator.of(context)
                        .pop();
                  },
                  child:ButtonChildWidget(
          "حسنا", Color(0xFFF7BB85), 18, 140),
                ),
              ),
            ],
          );
        }
    );
  }

  showSuccessMessageWidget(context , String text){
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
                margin: EdgeInsets.only(right:70),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popAndPushNamed(CartDetailsScreen.routeName);
                  },
                  child:ButtonChildWidget(
                      "حسنا", Color(0xFFF7BB85), 18, 140),
                ),
              ),
            ],
          );
        }
    );
  }
}
