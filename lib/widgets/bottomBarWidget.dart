import 'package:flutter/material.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/CartDetailsScreen.dart';
import 'package:hotelier/screens/PersonalInformationScreen.dart';
import 'package:hotelier/screens/SpecialOfferScreen.dart';
import 'package:hotelier/widgets/SignInMessageWidget.dart';
import 'package:provider/provider.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35) , topRight: Radius.circular(35)),
        border: Border.all(width: 2.0, color: Color(0xFFB99659),
        ),

        color: Color(0xFFF7BB85),
      ),
      height: 60,

      child: Container(

        margin: EdgeInsets.only(left: 30 , right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             GestureDetector(

              onTap: (){
                  Navigator.of(context).pushNamed (CartDetailsScreen.routeName);
             },

              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Image.asset("assets/Riyal-512.png" , width: 20,),
                    Text("المدفوعات" , style: TextStyle(fontWeight: FontWeight.w900),
                    )

                  ],
                ),
              ),
            ),
          GestureDetector(

              onTap: (){
                if(userDataProvider.userData == null){
                  SignInMessageWidget().showInMessageWidget(context);
                }else{
                  Navigator.of(context).pushNamed (PersonalInformationScreen.routeName);
                }
                },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Icon(Icons.person),
                    Text("حسابى" , style: TextStyle(fontWeight: FontWeight.w900),
                    )

                  ],
                ),
              ),
            ),
            GestureDetector(

              onTap: (){Navigator.of(context).pushNamed(SpecialOfferScreen.routeName);},
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Icon(Icons.card_giftcard_rounded),
                    InkWell(child: Text("العروض" , style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onTap: (){Navigator.of(context).pushNamed(SpecialOfferScreen.routeName);},
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

