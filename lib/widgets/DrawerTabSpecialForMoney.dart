import 'package:flutter/material.dart';

class DrawerTabSpecialForMoney extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const DrawerTabSpecialForMoney( this.text, this.onTap);
  // Icons.person
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Image.asset("assets/Riyal-512.png" , width: 25,),
                Text(
                  text,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Icon(Icons.arrow_back_ios_rounded),
              ],
            ),
          ),
          onTap: onTap,
        ),
        Divider(
          thickness: 0.5,
          endIndent: 20,
          indent: 20,
          color: Colors.black,
        )
      ],
    );
  }
}
