import 'package:flutter/material.dart';

class DrawerTabsWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const DrawerTabsWidget(this.icon , this.text);
  // Icons.person
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        
                   Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Icon(icon),
                Text(text , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w700) , ),
                Icon(Icons.arrow_back_ios_rounded),

              ],
            ),

          ),
        
        Divider(thickness: 0.5 , endIndent: 20, indent: 20, color: Colors.black,)
      ],
    );
  }
}
