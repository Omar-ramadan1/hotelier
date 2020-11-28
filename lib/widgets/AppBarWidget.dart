import 'package:flutter/material.dart';
import '../Clippers/AppBarClipper.dart';

class AppBarWidget extends StatelessWidget {
final String imageName;
final String text;
final bool isSearchAvailable;
  static const routeName = '/MainScreen';

  const AppBarWidget(this.imageName,this.text , {this.isSearchAvailable});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  ClipPath(
      clipper: AppBarClipper(),
        child: Container(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(

                      padding: EdgeInsets.only(top: 0 , left: isSearchAvailable != null ? text == "العروض المميزة" ? width / 4 : width / 2.6 : 0),
                      child: Text(text,style: TextStyle(fontSize:30,color:Colors.white,fontWeight: FontWeight.w800),),),
                  ),

                  isSearchAvailable != null ? InkWell(
                    onTap: (){
                      print("hello");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width / 1.15 , top: 90),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ) : Container(),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(imageName).image,
          ),
        ),
        
        ),
    );
  }
}


