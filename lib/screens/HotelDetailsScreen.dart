import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotelier/widgets/HotelDetailsInfoWidget.dart';
import 'package:hotelier/widgets/HotelDetailsSliderWidget.dart';

import '../widgets/AppBarWidget.dart';
import '../widgets/AppDrawerWidget.dart';
import '../widgets/bottomBarWidget.dart';

class HotelDetailsScreen extends StatefulWidget {
    static const routeName = '/OfferDetails';

  HotelDetailsScreen() : super();

  final String title = "Carousel Demo";

  @override
  HotelDetailsScreenState createState() => HotelDetailsScreenState();
}

class HotelDetailsScreenState extends State<HotelDetailsScreen> {
  //
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
          AppBarWidget("assets/hotelAppBarImage.jpg", "العروض المميزة"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFFFFFF),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height:),
                HotelDetailsSliderWidget(
                  imgList: imgList,
                  currentIndex: _current,
                  onChange: (index) {
                    setState(() {
                      setState(() {
                        _current = index;
                      });
                    });
                  },
                ),
                HotelDetailsInfoWidget()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
