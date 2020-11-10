import 'package:flutter/material.dart';
import 'package:hotelier/screens/OfferDetailsScreen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'ButtonWidget.dart';

class HotelDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      width: size.width / 1.9,
      margin: EdgeInsets.only(top: 10),
      child: Column(
          textDirection: TextDirection.rtl,

          children: [
            Text(
              "فندق المعمرين الرياض",
              style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w800),
            ),

            Container(
              width: size.width / 2.0,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "شارع اجياد 23 الرياض المملكه العربيه السعوديه",
                  style: TextStyle(fontSize: 16 ),
                ),
              ),
            ),
            SmoothStarRating(
                allowHalfRating: false,
                isReadOnly: true,
                starCount: 5,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                rating: 3,
                size: 30.0,
                color: Colors.amberAccent,
                borderColor: Colors.amberAccent,
                spacing:0.0
            ),
            InkWell(
              onTap: (){Navigator.of(context).pushNamed(OfferDetailsScreen.routeName);},
              child: ButtonChildWidget(
                  "المزيد من التفاصيل", Colors.transparent, 15, 120),
            ),
          ]),
    );
  }
}
