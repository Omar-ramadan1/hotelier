import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotelier/widgets/HotelDetailsInfoWidget.dart';
import 'package:hotelier/widgets/HotelDetailsSliderWidget.dart';

import '../widgets/AppBarWidget.dart';
import '../widgets/AppDrawerWidget.dart';
import '../widgets/bottomBarWidget.dart';

class HotelDetailsScreen extends StatefulWidget {
    static const routeName = '/OfferDetails';
    final Map data;
  HotelDetailsScreen(this.data) : super();

  final String title = "Carousel Demo";

  @override
  HotelDetailsScreenState createState() => HotelDetailsScreenState();
}

class HotelDetailsScreenState extends State<HotelDetailsScreen> {
  //
  CarouselSlider carouselSlider;
  ScrollController _controller;
  int _current = 0;
  Map data;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    data = widget.data;
  }
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   data = ModalRoute.of(context).settings.arguments;
    // });
// print("data[video]");
// print(data["video"]);
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          excludeHeaderSemantics: false,
          automaticallyImplyLeading: true,
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace:
          AppBarWidget("assets/hotelAppBarImage.jpg", data['Name']),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
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
                  text: data['Name'],
                  imgList: widget.data['img'],
                  currentIndex: _current,
                  onChange: (index , reason) {
                    setState(() {
                        _current = index;
                    });
                  },
                ),
                HotelDetailsInfoWidget(data)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
