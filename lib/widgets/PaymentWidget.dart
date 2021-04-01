

import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/Model/ImportantInformationModel.dart';
import 'package:hotelier/Model/UserData.dart';
import 'package:hotelier/screens/Congratulation.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/CreditCardChoiceWidget.dart';
import 'package:hotelier/widgets/MainScreenCardWidget.dart';
import 'package:hotelier/widgets/PaymentAlertDialogMessage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentWidget extends StatefulWidget {
  final bool isItBuyScreen;
  static const routeName = '/PaymentScreen';

  const PaymentWidget(this.isItBuyScreen);
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String cardValue = "visa" , price , paymentText = "بفيزا كارد";
  Map data ;

  Function changeCardValueFunction(String cardValueParameter , String paymentTextParameter) {
    setState(() {
      cardValue = cardValueParameter;
      paymentText = paymentTextParameter;
      if(cardValueParameter == "payAtArrive"){
        price = data["Price2"];
      }else{
        price = data["Price"];
      }
    });
    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImportantInformationModel importantInformationModel =
    Provider.of<ImportantInformationModel>(context, listen: false);
    data = importantInformationModel.importantInformationMap;
    price = data["Price"];

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
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/paymentAppBarImage.jpg", ""),
        ),
      ),
      drawerEdgeDragWidth: 200,
      endDrawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MainScreenCardWidget("assets/paymentContainer.jpg", null),
              Text(
                " سعر البطاقه $price ريال شامل الضريبة و التوصيل",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "وسيتم توصيل البطاقة في خلال ${data["Days"]} أيام عمل",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CreditCardChoiceWidget(cardValue, changeCardValueFunction),
              SizedBox(height: 20),
              Text("الدفع $paymentText" , style: TextStyle(fontSize: 25),),
              SizedBox(
                height: 20,
              ),
              widget.isItBuyScreen
                  ? InkWell(
                      onTap: () async {
                        if (userDataProvider.userData == null) {
                          PaymentAlertDialogMessage().showInMessageWidget(
                              context,
                              "من فضلك قم بتسجيل الدخول لاتمام العملية");
                        } else {
                          if(cardValue == "mastercard" || cardValue == "mada" || cardValue == "visa"){
                            var response  = await http.post(
                              '$serverURL/Order/AddOrder?isMinorRenewal=false&IsOnlinePayment=true',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
                                'Content-Type': 'application/json'
                              },
                            );
                            print(response.statusCode);
                            String url = 'https://hoteliercard.com/Checkout.html?id=${userDataProvider.userData["userId"]}&firstTime=true';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }else{
                              PaymentAlertDialogMessage().showInMessageWidget(
                                  context,
                                  'من فضلك تاكد من وجود جوجل كروم على الهاتف');
                            }
                          }else{
                            var response  = await http.post(
                              '$serverURL/Order/AddOrder?isMinorRenewal=false&IsOnlinePayment=false',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
                                'Content-Type': 'application/json'
                              },
                            );
                            if(response.statusCode >= 200 && response.statusCode < 300){
                              Navigator.of(context).popAndPushNamed(Congratulation.routeName);
                            }else{
                              PaymentAlertDialogMessage().showInMessageWidget(
                                  context,
                                  'لقد حدث خطا ما');
                            }
                          }
                        }
                      },
                      child: ButtonChildWidget(
                          "شراء بطاقة", Color(0xFFF7BB85), 25, 150))
                  : InkWell(
                      onTap: () async {
                        if (userDataProvider.userData == null) {
                          PaymentAlertDialogMessage().showInMessageWidget(
                              context,
                              "من فضلك قم بتسجيل الدخول لاتمام العملية");
                        } else {
                          if(cardValue == "mastercard" || cardValue == "mada" || cardValue == "visa"){
                            var response  = await http.post(
                              '$serverURL/Order/AddOrder?isMinorRenewal=true&IsOnlinePayment=true',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
                                'Content-Type': 'application/json'
                              },
                            );
                            print(response.statusCode);
                            String url = 'https://hoteliercard.com/Checkout.html?id=${userDataProvider.userData["userId"]}&firstTime=false';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('من فضلك تاكد من وجود جوجل كروم على الهاتف')));
                            }
                          }else{
                            var response  = await http.post(
                              '$serverURL/Order/AddOrder?isMinorRenewal=true&IsOnlinePayment=false',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${userDataProvider.userData["access_token"]}',
                                'Content-Type': 'application/json'
                              },
                            );
                            if(response.statusCode >= 200 && response.statusCode < 300){
                              Navigator.of(context).popAndPushNamed(Congratulation.routeName);
                            }else{
                              PaymentAlertDialogMessage().showInMessageWidget(
                                  context,
                                  'لقد حدث خطا ما');
                            }
                          }
                        }
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
