import 'package:flutter/material.dart';
import 'package:hotelier/screens/EditUserData.dart';
import 'package:hotelier/screens/PaymentScreen.dart';
import 'package:hotelier/screens/SpecialOfferScreen.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35) , topRight: Radius.circular(35)),
        border: Border.all(width: 2.0, color: Color(0xFFB99659)),
        color: Color(0xFFF7BB85),
      ),
      height: 60,

      child: Container(
        margin: EdgeInsets.only(left: 30 , right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(

              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    InkWell(child: Text("المدفوعات" , style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onTap: (){Navigator.of(context).popAndPushNamed (PaymentScreen.routeName);},
                    )

                  ],
                ),
              ),
            ),
            GestureDetector(

              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Icon(Icons.person),
                    InkWell(child: Text("حسابى" , style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onTap: (){Navigator.of(context).popAndPushNamed (EditUserData.routeName);},
                    )

                  ],
                ),
              ),
            ),
            GestureDetector(

              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Icon(Icons.card_giftcard_rounded),
                    InkWell(child: Text("العروض" , style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onTap: (){Navigator.of(context).popAndPushNamed (SpecialOfferScreen.routeName);},
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

