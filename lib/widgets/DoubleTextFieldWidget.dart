import 'package:flutter/material.dart';

class DoubleTextFieldWidget extends StatelessWidget {
  final Function onChangeFunction;
  final String errorText , phone1 , phone2  , parameterStringName , phone1Text , phone2Text;
  final bool isEditWidget;
  const DoubleTextFieldWidget(this.errorText , this.onChangeFunction , this.parameterStringName , {this.phone1 , this.phone2 , this.isEditWidget , this.phone1Text , this.phone2Text});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        onChangeFunction(value, parameterStringName);
                      },
                      decoration: InputDecoration(
                        labelText: phone1 != null ? phone1 : 'رقم الجوال',
                        errorText: errorText,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                isEditWidget != null ? Text(phone1Text) : Container(),
              ],
            ),
          ),
          Container(
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        onChangeFunction(value, 'phone2');
                      },
                      decoration: InputDecoration(
                        labelText: phone2 != null ? phone2 : 'رقم الهاتف',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                isEditWidget != null ? Text(phone2Text) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
