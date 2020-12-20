import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/CreditCardChoiceWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/PaymentAlertDialog.dart';
import 'package:hotelier/widgets/TextFieldWidget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentWidget extends StatefulWidget {
  final bool isItBuyScreen;
  static const routeName = '/PaymentScreen';

  const PaymentWidget(this.isItBuyScreen);
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String cardValue = "";

  Function changeCardValueFunction(String cardValueParamater) {
    setState(() {
      cardValue = cardValueParamater;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    UserData userDataProvider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/paymentAppBarImage.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MainScreenCardWidget("assets/paymentContainer.jpg", null),
              Text(
                "سعر البطاقه 150 ريال شامل الضريبة التوصيل",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "سيتم التواصل معك لتوصيل البطاقة فى اقرب وقت",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CreditCardChoiceWidget(cardValue, changeCardValueFunction),
              SizedBox(height: 20),
              Text(
                "برجاء اختيار طريقة الدفع",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              TextFieldWidget(
                "الاسم",
                double.infinity,
                TextDirection.rtl,
                "",
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                "رقم الكارت",
                double.infinity,
                TextDirection.rtl,
                "0000    0000    0000   0000",
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget(
                    "EXPIRY DATE",
                    140,
                    TextDirection.ltr,
                    "MM | YY",
                  ),
                  TextFieldWidget(
                    "Cvv CODE",
                    140,
                    TextDirection.ltr,
                    "000",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              widget.isItBuyScreen
                  ? InkWell(
                      onTap: () async {
                        var response = await http.post(
                          '$serverURL/Order/AddOrder/?isMinorRenewal=false',
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}'
                          },
                        );
                        print(response.statusCode);
                        print(response.body);
                        if (response.statusCode == 200) {
                          PaymentAlertDialog().showInMessageWidget(context,
                              "سيتم التواصل معك للتوصيل من فضلك تاكد من رقم هاتفك فى الاعدادات");

                        }else if(response.statusCode == 401){
                          PaymentAlertDialog().showInMessageWidget(context,
                              "من فضلك قم بتسجيل الدخول مرة اخرى");
                          userDataProvider.userData = null;
                        }
                      },
                      child: ButtonChildWidget(
                          "شراء بطاقة", Color(0xFFF7BB85), 25, 150))
                  : InkWell(
                      onTap: () async {
                        print(
                            'Bearer ${userDataProvider.userData["access_token"]}');
                        var response = await http.post(
                          '$serverURL/Order/AddOrder/?isMinorRenewal=true',
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}'
                          },
                        );
                        print(response.statusCode);
                        if (response.statusCode == 200) {
                          PaymentAlertDialog().showInMessageWidget(context,
                              "لقد تمت العملية بنجاح");

                        }else if(response.statusCode == 401){
                          PaymentAlertDialog().showInMessageWidget(context,
                              "من فضلك قم بتسجيل الدخول مرة اخرى");
                          userDataProvider.userData = null;
                        }
                        print(response.body);
                      },
                      child: ButtonChildWidget(
                          "تجديد الاشتراك", Color(0xFFF7BB85), 25, 150)),
            ],
          ),
        ),
      ),
      //  bottomNavigationBar: BottomBarWidget(),
    );
  }
}
