import 'package:flutter/material.dart';

class CreditCardChoiceWidget extends StatelessWidget {
  final String cardValue;
  final Function changeCardValueFunction;

  const CreditCardChoiceWidget(this.cardValue, this.changeCardValueFunction);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            changeCardValueFunction("mastercard");
          },
          child: Container(
              width: width / 6,
              height: width / 9,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cardValue == "mastercard"
                    ? Color(0xFFFBDBBF)
                    : Colors.transparent,
                border: cardValue == "mastercard"
                    ? Border.all(width: 3, color: Color(0xFFB29368))
                    : null,
              ),
              child: Image.asset(
                "assets/mastercard_logo.jpg", fit: BoxFit.fill,
              )
          ),
        ),
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(width: 1.0, color: Colors.black12),
          ),
        ),
        InkWell(
          onTap: () {
            changeCardValueFunction("visa");
          },
          child: Container(
              width: width / 6,
              height: width / 9,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cardValue == "visa"
                    ? Color(0xFFFBDBBF)
                    : Colors.transparent,
                border: cardValue == "visa"
                    ? Border.all(width: 3, color: Color(0xFFB29368))
                    : null,
              ),
              child: Image.asset(
                "assets/visa_logo.png", fit: BoxFit.fill,
              )
          ),
        ),
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(width: 1.0, color: Colors.black12),
          ),
        ),
        InkWell(
          onTap: () {
            changeCardValueFunction("mada");
          },
          child: Container(
              width: width / 6,
              height: width / 9,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cardValue == "mada"
                    ? Color(0xFFFBDBBF)
                    : Colors.transparent,
                border: cardValue == "mada"
                    ? Border.all(width: 3, color: Color(0xFFB29368))
                    : null,
              ),
              child: Image.asset(
                "assets/mada_logo.png", fit: BoxFit.fill,
              )
          ),
        ),
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(width: 1.0, color: Colors.black12),
          ),
        ),
        InkWell(
          onTap: () {
            changeCardValueFunction("payAtArrive");
          },
          child: Container(
              width: width / 6,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: cardValue == "payAtArrive"
                    ? Color(0xFFFBDBBF)
                    : Colors.transparent,
                border: cardValue == "payAtArrive"
                    ? Border.all(width: 2, color: Color(0xFFB29368) )
                    : null,
              //  Color(0xFFB29368)
              ),
              child: Image.asset(
                "assets/cash-01.png",
              ),),
        ),
      ],
    );
  }
}
