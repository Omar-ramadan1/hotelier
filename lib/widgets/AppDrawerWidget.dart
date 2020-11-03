import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LogedInDrawer.dart';

class AppDrawerWidget extends StatefulWidget {
  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Container(
      //height: 500,
      color: Color(0xFFFFFFFF),
      width: sizes.width / 1.555,
      child: LogedInDrawer(),
    );
  }
}
