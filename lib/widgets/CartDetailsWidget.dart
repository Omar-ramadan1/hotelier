import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';

class CartDetailsWidget extends StatelessWidget {
  final Map data;

  const CartDetailsWidget(this.data);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(5),
        width: size.width - 20,
        decoration: BoxDecoration(
          color: mainAppColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 20 , bottom: 10),
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text("الطلب:" , textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                SizedBox(width: 15,),
                Text(data["isMinorRenewal"] ,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey),),
              ],
            ),

            SizedBox(height: 10,),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text("حالة الطلب:" , textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                SizedBox(width: 15,),
                Text(data["IsDelivered"] ,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text("تاريخ تقديم الطلب:" , textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                Text(data["date"].toString().substring(0 , 10) ,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: Colors.blueGrey ), ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
