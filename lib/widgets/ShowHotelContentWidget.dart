import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hotelier/Model/DataList.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/HotelContainerWidget.dart';
import 'package:hotelier/widgets/HotelHeaderDropDownWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';
import 'package:provider/provider.dart';

class ShowHotelContentWidget extends StatefulWidget {
  final bool isSpecialOfferScreen;

  const ShowHotelContentWidget({this.isSpecialOfferScreen});

  @override
  _ShowHotelContentWidgetState createState() => _ShowHotelContentWidgetState();
}

class _ShowHotelContentWidgetState extends State<ShowHotelContentWidget> {
  var _scrollController = new ScrollController();
  String cityId = "الكل", typeId = "الكل", star = "الكل";
  List<String> citiesListClone = ["الكل"];
  List<String> categoryListClone = ["الكل"];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  double lastOffset;
  List hotelDataList = [] , hotelAd = [];
  List<String> discountList = [
    'الكل',
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100'
  ];
  Map data;

  @override
  initState() {
    super.initState();
    adsHotels();
    DataList dataList = Provider.of<DataList>(context, listen: false);
    setState(() {
      citiesListClone.addAll(dataList.citiesNames);
      categoryListClone.addAll(dataList.categoryNames);
      data = {
        'cityId': null,
        'discountValue': null,
        'typeId': null,
        'starRating': null,
        'pageNumber': null,
        'isSpecialOffer': widget.isSpecialOfferScreen,
        'searchWord': null,
      };
    });

    refreshIndicatorFunction(true);

    // _scrollController.addListener(() {
    //   if (_scrollController.position.atEdge) {
    //     if (_scrollController.position.pixels == 0) {
    //     }
    //     // you are at top position
    //     else {
    //       refreshIndicatorFunction(false);
    //     }
    //     // you are at bottom position
    //   }
    // });
  }
  adsHotels()async{
    var response = await http.post(
      '$serverURL/Hotels/V2/HotelsAd',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    print(response.statusCode);
    List body = jsonDecode(response.body);
    Map data1 = body[0];
    setState(() {
      print(data1["Address"]);
      hotelAd = body;
    });
  }

  refreshIndicatorFunction(bool isTrue) async {
    DataList dataList = Provider.of<DataList>(context, listen: false);
    refreshKey.currentState?.show(atTop: isTrue);
    print(data);
    if (cityId == "الكل") {
      data["cityId"] = null;
    } else {
      dataList.citiesList.forEach((e) => {
            if (e["Name"] == cityId.toString())
              {
                data["cityId"] = e["id"].toString(),
              }
          });
    }
    if (typeId == "الكل") {
      data["typeId"] = null;
    } else {
      dataList.categoryList.forEach((e) => {
            if (e["Name"] == typeId)
              {
                data["typeId"] = e["id"],
              }
          });
    }

    print(data);
    var response = await http.post(
      '$serverURL/Hotels/HotelsList',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    print(response.statusCode);
    print(response.body);
    setState(() {
      hotelDataList.addAll(jsonDecode(response.body));
      if (jsonDecode(response.body).length == 0) {
      } else {
        // setState(() {
        //   data["pageNumber"]++;
        // });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg",
              widget.isSpecialOfferScreen ? "العروض المميزة" : typeId),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: RefreshIndicator(
        notificationPredicate: (value) {
          return false;
        },
        key: refreshKey,
        displacement: 20,
        onRefresh: () async {
          refreshKey.currentState.show(atTop: false);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // typeId variable is same as CategoryNames variable
              // but i made this change here because on server side
              // names of variables is so important and he made it this way
              // despite the fact i send him the variable names
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          hotelDataList = [];
                          // data["pageNumber"] = 1;
                        });
                        refreshIndicatorFunction(true);
                      },
                      child: Container(
                        width: 20,
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 200,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          onChanged: (value) {
                            data['searchWord'] = value;
                          },
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'ادخل اسم المكان للبحث عنه',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HotelHeaderDropDownWidget("المدينة", cityId, citiesListClone,
                      (value) {
                    setState(() {
                      cityId = value;
                      hotelDataList = [];
                      // data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }, 70),
                  HotelHeaderDropDownWidget(
                      "نسبه الخصم",
                      data["discountValue"] == null
                          ? "الكل"
                          : data["discountValue"].toString(),
                      discountList, (value) {
                    setState(() {
                      if (value == "الكل") {
                        data["discountValue"] = null;
                      } else {
                        data["discountValue"] = int.parse(value);
                      }
                      hotelDataList = [];
                      // data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }, 50),
                  HotelHeaderDropDownWidget(
                      "التصنيف", typeId, categoryListClone, (value) {
                    setState(() {
                      typeId = value.toString();
                      hotelDataList = [];
                      // data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }, 80),
                  HotelHeaderDropDownWidget(
                      "عدد النجوم",
                      data["starRating"] == null
                          ? "الكل"
                          : data["starRating"].toString(),
                      ["الكل", '1', '2', '3', '4', '5'], (value) {
                    setState(() {
                      if (value == "الكل") {
                        data["starRating"] = null;
                      } else {
                        data["starRating"] = value.toString();
                      }
                      hotelDataList = [];
                      // data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }, 50),
                ],
              ),

              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>

              // VIP ad Hotels
              for (var data in hotelAd)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: HotelContainerWidget(data),
                ),

              // Container(
              //   width: MediaQuery.of(context).size.width - 20,
              //   height: 300,
              //   child: ListView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: hotelDataList.length,
              //     itemBuilder: (context, i) => Container(
              //       margin: EdgeInsets.only(top: 10),
              //       child: HotelContainerWidget(hotelDataList[i]),
              //     ),
              //   ),
              // ),
              // normal Hotels
              for (var data in hotelDataList)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: HotelContainerWidget(data),
                ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
