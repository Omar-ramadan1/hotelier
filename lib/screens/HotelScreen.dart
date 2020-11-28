import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ShowHotelContentWidget.dart';

class HotelScreen extends StatelessWidget {
  static const routeName = '/HotelScreen';
  @override
  Widget build(BuildContext context) {
    return ShowHotelContentWidget(isSpecialOfferScreen: false,);
  }
}
