import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HotelDetailsInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Color(0xFFB99659)),
        borderRadius: BorderRadius.circular(40),
        color: Colors.transparent,
      ),
      width: size.width / 1.2,
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 70),
            child: Text(
              "فندق المعمرين الرياض",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 140),
            child: SmoothStarRating(
                allowHalfRating: false,
                starCount: 5,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                rating: 3,
                size: 25.0,
                color: Colors.amberAccent,
                borderColor: Colors.amberAccent,
                spacing:0.0
            ),
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(Icons.gps_fixed),
              ),
              Text(
                "  اشارع اجياد23 الرياض \nالمملكه العريبه السعوديه",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              IconButton(icon: Icon(Icons.phone), onPressed: null),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "088564749",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              // Text("088564749")
            ],
          ),
          Divider(
            height: 3,
            thickness: 1,
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Text("متاح اليوم" ,style: TextStyle(color: Colors.green),),
            Text("10 AM"),
            Text("8 PM"),
            Text("جميع الاوقلات" ,style: TextStyle(color: Colors.blue),),
          ]),
          Divider(
            height: 3,
            thickness: 1,
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(height: 75),
          Container(
            height: size.height / 5,
            width: size.width / 1.5,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.greenAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.3,
                  blurRadius: 5,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Center(child: Text("googlemaps Container")),
          ),
          SizedBox(height: 15),
          Container(
            height: size.height / 5,
            width: size.width / 1.5,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              color: Colors.greenAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0.3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
            ),
            child: Center(child: Text("video Container")),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
