import 'package:flutter/material.dart';
import 'package:hotelier/widgets/ShowHotelContentWidget.dart';


class SpecialOfferScreen extends StatelessWidget {
  static const routeName = '/SpecialOfferScreen';
  @override
  Widget build(BuildContext context) {
    return ShowHotelContentWidget(isSpecialOfferScreen: true,);
  }
}



