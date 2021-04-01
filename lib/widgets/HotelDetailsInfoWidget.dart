import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/main.dart';
import 'package:hotelier/screens/GoogleMapInfoScreen.dart';
import 'package:hotelier/widgets/GoogleMapWidget.dart';
import 'package:hotelier/widgets/VideoPlayerWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetailsInfoWidget extends StatelessWidget {
  final Map data;

  const HotelDetailsInfoWidget(this.data);
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
              data["Name"],
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
                rating: data['starRating'].toDouble(),
                isReadOnly: true,
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
              Container(
                width: 200,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    data['Address'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold ,),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              IconButton(icon: Icon(Icons.phone), onPressed: null),
              MaterialButton(
                splashColor: mainAppColor,
                onPressed: ()async{
                  String url = 'tel://${data['PhoneNumber']}';
                  if (await canLaunch(url)) {
                  await launch(url);
                  }
                },
                child: Text(
                  data['PhoneNumber'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              // Text("088564749")
            ],
          ),
          Container(
            width: size.width / 1.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${data["netPrice"]}",
                  style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 15,),
                Text(
                  "${data["RoomPrice"].toString()}",
                  style: TextStyle(fontSize: 17  , color: Colors.red , fontWeight: FontWeight.w600 ,decoration: TextDecoration.lineThrough),
                ),
                SizedBox(width: 15,),
                Image.asset("assets/Riyal-512.png" , width: 30,)
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              IconButton(icon: Icon(Icons.money), onPressed: null),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  data['IsReservationsAvailable'] ? "الحجز متاح" : "الحجز غير متاح",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              // Text("088564749")
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              IconButton(icon: Icon(Icons.sticky_note_2_outlined), onPressed: null),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: size.width - 150,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      data['Notes'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
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

          SizedBox(height: 75),
          InkWell(
            onTap: (){
            //  GoogleMapInfoScreen
               Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => GoogleMapInfoScreen(data['lat'] , data['lng'])));
            },
            child: Container(
              height: size.height / 5,
              width: size.width / 1.5,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.3,
                    blurRadius: 4,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Center(child: InkWell(
                  child: GoogleMapWidget(data['lat'] , data['lng']))),
            ),
          ),
          SizedBox(height: 15),
          data["video"] == "" || data["video"] == "null"  || data["video"] == null?
          Container() :
          Container(
            height: size.height / 5,
            width: size.width / 1.5,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0.3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
            ),
            child: VideoPlayerWidget(data["video"]),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
