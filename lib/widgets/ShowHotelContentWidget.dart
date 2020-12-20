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
  int pageNumber = 0;
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
    DataList dataList = Provider.of<DataList>(context, listen: false);
    setState(() {
      cityId = dataList.citiesNames[0];
      typeId = dataList.categoryNames[0];
      citiesListClone = dataList.citiesList;
      categoryListClone = dataList.categoryList;
      data = {
        'cityId': cityId,
        'discountValue': 10,
        'typeId': typeId,
        'starRating': 1,
        'pageNumber': 1,
        'isSpecialOffer': widget.isSpecialOfferScreen,
        'searchWord' : ''
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
      if(jsonDecode(response.body).length == 0){

      }else{
        setState(() {
          data["pageNumber"] ++;
        });
      }
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
              widget.isSpecialOfferScreen ? "العروض المميزة" : typeId),
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
                          data["pageNumber"] = 1;
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
                          onChanged: (value){
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
                  HotelHeaderDropDownWidget(
                      "المدينة", cityId, dataList.citiesNames, (value) {
                    setState(() {
                      cityId = value;
                      hotelDataList = [];
                      data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }),
                  HotelHeaderDropDownWidget("نسبه الخصم",
                      data["discountValue"].toString(), discountList, (value) {
                    setState(() {
                      data["discountValue"] = int.parse(value);
                      hotelDataList = [];
                      data["pageNumber"] = 1;
                    });
                    refreshIndicatorFunction(true);
                  }),
                  HotelHeaderDropDownWidget(
                      "التصنيف", typeId, dataList.categoryNames, (value) {
                    setState(() {
                      typeId = value;
                      hotelDataList = [];
                      data["pageNumber"] = 1;
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
                      data["pageNumber"] = 1;
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
