import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';

class HotelImageViewer extends StatelessWidget {
  final List imgList;
  HotelImageViewer(this.imgList);

  @override
  Widget build(BuildContext context) {
    print(imgList);
    return Scaffold(
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      // the appbar part -------------------->>>>
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: mainAppColor,
          shadowColor: mainAppColor,
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3),
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return Container(
                margin:EdgeInsets.only(left: 3 , right:3 , top: 3),
                height: 200,
                child: Image.network("${anotherServerURL}Content/Images/${imgList[index]}" , fit: BoxFit.fill,));
          }),
    );
  }
}
