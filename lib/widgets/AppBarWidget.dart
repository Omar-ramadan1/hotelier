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

                      padding: EdgeInsets.only(top: 0),
                      child: Text(text,style: TextStyle(fontSize:30,color:Colors.white,fontWeight: FontWeight.w800),),),
                  ),
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


