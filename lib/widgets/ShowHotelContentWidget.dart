import 'dart:convert';
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
  String cityId, typeId, star;
  var citiesListClone;
  var categoryListClone;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  double lastOffset;
  List hotelDataList = [];
  int i = 0;
  List<String> discountList = [
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
  // Map data = {
  //   'access_token': 'String',
  // };

  @override
  initState() {
    super.initState();
    DataList dataList = Provider.of<DataList>(context , listen: false);
    setState(() {
      cityId = dataList.citiesNames[0];
      typeId = dataList.categoryNames[0];
      citiesListClone = dataList.citiesList;
      categoryListClone = dataList.categoryList;
      data = {
        'cityId': cityId,
        'Discount': 10,
        'typeId': typeId,
        'starRating': 1,
        'pageNumber': 1,
        'isSpecialOffer': widget.isSpecialOfferScreen,
      };
    });

    refreshIndicatorFunction(true);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        }
        // you are at top position
        else {
          refreshIndicatorFunction(false);
        }
        // you are at bottom position
      }
    });
  }

  refreshIndicatorFunction(bool isTrue) async {
    refreshKey.currentState?.show(atTop: isTrue);
    print(data);
    citiesListClone.forEach((e) => {
          if (e["Name"] == cityId)
            {
              data["cityId"] = e["id"],
            }
        });
    categoryListClone.forEach((e) => {
          if (e["Name"] == typeId)
            {
              data["typeId"] = e["id"],
            }
        });
    data["pageNumber"] = ((hotelDataList.length / 5) + 1).floor();
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
    });
  }

  Widget build(BuildContext context) {
    DataList dataList = Provider.of<DataList>(context);
    double width = MediaQuery.of(context).size.width;
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
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg",
              widget.isSpecialOfferScreen ? "العروض المميزة" : typeId , isSearchAvailable: true,),
          title: Container(
            margin: EdgeInsets.only(left: width / 1.43),
            child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: RefreshIndicator(
        notificationPredicate: (value) {
          return false;
        },
        key: refreshKey,
        displacement: 20,
        onRefresh: () async {
          refreshKey.currentState.show(atTop: false);
          print("hello");
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(height: 25),
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // the header part -------------------->>>>>
              // typeId variable is same as CategoryNames variable
              // but i made this change here because on server side
              // names of variables is so important and he made it this way
              // despite the fact i send him the variable names
              InkWell(
                onTap: (){
                  return  showDialog(
                      context: context,
                      builder: (_) =>  AlertDialog(
                        title: Center(child: Text("البحث")),
                        content: TextField(decoration: InputDecoration(hintText: "من فضلك ادخل اسم الفندق للبحث عنه") ,textDirection: TextDirection.rtl, onChanged: (value){print(value);},),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('بحث'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('اغلاق'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                        actionsOverflowButtonSpacing: 100,
                        actionsPadding: EdgeInsets.only(right: 60),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.only(left: width / 1.13 , bottom: 10),
                  child: Icon(Icons.search, color: Colors.black),
                ),
              ),

              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HotelHeaderDropDownWidget(
                      "المدينة", cityId, dataList.citiesNames, (value) {
                    setState(() {
                      cityId = value;
                      hotelDataList = [];
                    });
                    refreshIndicatorFunction(true);
                  }),
                  HotelHeaderDropDownWidget(
                      "نسبه الخصم", data["Discount"].toString(), discountList,
                      (value) {
                    setState(() {
                      data["Discount"] = int.parse(value);
                      hotelDataList = [];
                    });
                    refreshIndicatorFunction(true);
                  }),
                  HotelHeaderDropDownWidget(
                      "التصنيف", typeId, dataList.categoryNames, (value) {
                    setState(() {
                      typeId = value;
                      hotelDataList = [];
                    });
                    refreshIndicatorFunction(true);
                  }),
                  HotelHeaderDropDownWidget(
                      "عدد النجوم",
                      data["starRating"].toString(),
                      ['1', '2', '3', '4', '5'], (value) {
                    setState(() {
                      data["starRating"] = int.parse(value);
                      hotelDataList = [];
                    });
                    refreshIndicatorFunction(true);
                  }),
                ],
              ),

              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>
              // the body part --------------------------->>>>>

              for (var data in hotelDataList)
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: HotelContainerWidget(data),),
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