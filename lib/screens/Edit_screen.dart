import 'package:flutter/material.dart';
import 'package:hotelier/widgets/AppBarWidget.dart';
import 'package:hotelier/widgets/AppDrawerWidget.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';
import 'package:hotelier/widgets/bottomBarWidget.dart';

class Edit_screen extends StatelessWidget {
    Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,8),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                                فندق المعمرين الرياض',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
      Widget _location() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                                العنوان علي الخريطه',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
      Widget _number() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                                      5555555555',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
      Widget _phone() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                                              الجوال ',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
      Widget _email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                                فندق المعمرين الرياض',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
    Widget _discount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(70,8,8,8),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '       10',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
      Widget _category() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(160,8,0,8),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: ' تصنيف',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
   Widget _password() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,8),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                      ******              كلمه المرور  ',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
  Widget _confirm_password() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,8),
      child:ListTile(
        title: TextFormField(
        decoration: InputDecoration(
          hintText: '                                      ******             تاكيد كلمه المرور  ',
          icon: Icon(Icons.edit),
        ),
        //   maxLength: 10,

        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is  Required';
          }
        },
      
      ),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          flexibleSpace: AppBarWidget("assets/hotel-bell.jpg"),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  Text("تعديل الحساب",style: TextStyle(fontSize:35),),
                                    Text("فندق المعمرين -الرياض",style: TextStyle(fontSize:35),),


                  SizedBox(height:90),
                  Container(
          
          child:Column(
            children:[

_buildName(),
_number(),
_location(),
_phone(),
_email(),
                   ListTile(
                     title: _discount(),
                     trailing: Padding(
                       padding: const EdgeInsets.fromLTRB(8,25,8,8),
                       child: Text("نسبه الخصم المقدمه ",style: TextStyle(fontSize:18),),
                     ),
                   ),  
                   ListTile(title: _category(),
                   trailing: Padding(padding: const EdgeInsets.fromLTRB(8, 28, 8, 8),
                   child: Text("تصنيف",style: TextStyle(fontSize:18),),),
                   ),
                   Divider(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                     children:[
                         InkWell(
                        child: ButtonChildWidget(
                            " ارفاق صوره ",
                                Color(0xFFF7BB85),
                                
                            18 , 150),
                        onTap: () {
                          
                        },
                      ),
                      InkWell(
                      
                        
                        child: ButtonChildWidget(
                            " ارفاق فديوا",
                           
                                 Color(0xFFF7BB85),
                                
                            18 , 
                            150),
                      
                     
                      )
                     ]
                   ),
                   _password(),
                   _confirm_password(),
                       InkWell(
                        child: ButtonChildWidget(
                            "حفظ التعديلات ",
                                Color(0xFFF7BB85),
                                
                            18 , 150),
                        onTap: () {
                          
                        },
                      ),
                          InkWell(
                        child: ButtonChildWidget(
                            " تجديد الاشتراك ",
                                Color(0xFFF7BB85),
                                
                            20 , 200),
                        onTap: () {
                          
                        },
                      ),
                   
                             
                  
            ]
            
          ) ,
          ),
                ],
              ),
      ),
              bottomNavigationBar : BottomBarWidget(),

    );
  }
}