
import 'package:flutter/material.dart';
import 'package:hotelier/widgets/PaymentWidget.dart';

class BuyCardScreen extends StatelessWidget {
  static const routeName = '/BuyCardScreen';
  @override
  Widget build(BuildContext context) {
    return PaymentWidget(true);
  }
}