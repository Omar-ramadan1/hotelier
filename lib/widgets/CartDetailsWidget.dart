import 'package:flutter/material.dart';

class CartDetailsWidget extends StatelessWidget {
  final Map data;

  const CartDetailsWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30 , bottom: 30),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text("الطلب:" , textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
              SizedBox(width: 15,),
              Text(data["isMinorRenewal"] ,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ],
          ),

          SizedBox(height: 20,),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text("حالة الطلب:" , textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
              SizedBox(width: 15,),
              Text(data["IsDelivered"] ,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text("تاريخ تقديم الطلب:" , textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
              Text(data["date"] ,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ],
          ),
        ],
      ),
    );
  }
}
