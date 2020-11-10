import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserData  extends ChangeNotifier{
   Map _userData;
   Map get userData => _userData;
   bool _isUserDataLoaded = false;
   bool get isUserDataLoaded => _isUserDataLoaded;
   Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();

   set userData(Map userDataParameter){
     _userData = userDataParameter;
     print(_userData);
     _isUserDataLoaded = true;
       notifyListeners();
   }
   set isUserDataLoaded(bool isUserDataLoadedParameter){
     _isUserDataLoaded = isUserDataLoadedParameter;
     notifyListeners();
   }


   void checkIfUserDataOnMobileStorage(){

     _prefs.then((SharedPreferences prefs) {
       if( prefs.get("userData") == null ){
       } else{
         userData = jsonDecode(prefs.get("userData"));
       }

     });
   }

   void updateUserInfo(Map userNewInfo){
     userData = userNewInfo;
     _prefs.then((SharedPreferences prefs) {
       prefs.setString("userData" , jsonEncode(userNewInfo));
     });
   }

   }

