import 'package:flutter/material.dart';

class MainScreenCardWidget extends StatelessWidget {
  final String arWord , enWord;

  MainScreenCardWidget(this.arWord ,  this.enWord);


  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 3.0, color: Color(0xFFB99659)),
        color: Colors.blue,
      ),
      height: size.height / 5.5,
      width: size.width / 1.322,

      child: Container(
        margin: EdgeInsets.only(top: 70 , left: 10 , right: 10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Text(arWord , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w900 )),
            Text(enWord , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w900),),

          ],
        ),
      ),
    );
  }
}
