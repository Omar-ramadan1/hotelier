import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:hotelier/screens/EditHotelData.dart';
import 'package:hotelier/widgets/PaymentAlertDialogMessage.dart';
import 'package:http/http.dart' as http;

class CNOHSSHIW extends StatelessWidget {
  final Map data;
final Function func;

  const CNOHSSHIW(this.data , this.func);
  @override
  Widget build(BuildContext context) {
    print(data);
    List imageUrl = data["img"];
    Map imageMap = imageUrl[0];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: size.width,
      child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          // Container(
          //   margin: EdgeInsets.only(right: size.width - 30),
          //   width: 20,
          //   height: 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     color: Colors.red,
          //   ),
          //   child: InkWell(
          //     splashColor: mainAppColor,
          //     onTap: () async{
          //       print('$serverURL/api/User/DeleatHotel?id=${data["id"]}');
          //       var response  = await http.post(
          //       '$serverURL/api/User/DeleatHotel?id=${data["id"]}',
          //       headers: <String, String>{
          //         'Authorization': 'Bearer ${data["access_token"]}',
          //         'Content-Type': 'application/json'
          //       },
          //     );
          //     print(response.statusCode);
          //     if(response.statusCode < 300){
          //       func(data["id"]);
          //     }else{
          //       PaymentAlertDialogMessage().showInMessageWidget(
          //           context,
          //           response.body);
          //     }
          //     },
          //     child: Center(child: Text("X")),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 25, right: size.width / 4),
            height: 50,
            width: size.width / 1.5,
            decoration: BoxDecoration(
              color: mainAppColor,
              border: Border.all(color: Color(0xFFBD954F), width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                data["Name"].toString(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditHotelData(data)));
            },
            splashColor: mainAppColor,
            child: Container(
              margin: EdgeInsets.all(3),
              height: 75,
              width: 130,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Color(0xFFBD954F), width: 2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '${anotherServerURL}Content/Images/${imageMap["FileName"]}',
                    ).image,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
