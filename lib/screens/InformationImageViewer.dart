import 'package:flutter/material.dart';
import 'package:hotelier/Constant/Constant.dart';


class InformationImageViewer extends StatelessWidget {
  final List imagesList;

  const InformationImageViewer(this.imagesList);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 20,
      child: Column(
        children: [
          for (int i = 0 ; i < imagesList.length ; i++)
            Row(
              children: List.generate(3, (k) {
                  return imagesList[0] == null ? Container(
                    child: Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.6,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 5 , left: 10 ),
                      child: Image.network('${anotherServerURL}Content/Images/${imagesList[0]['FileName']}' , fit: BoxFit.fill, errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ){
                        return Container();
                      },),
                    ),
                  ) : Container();

            }),
            ),
        ],
      ),
    );
  }
}
