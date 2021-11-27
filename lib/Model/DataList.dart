import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataList extends ChangeNotifier{

  // first of all i want to apologies for this that may seem like mess
  // but i need MainList from server which is composed of Maps
  // and need seperated String List that Contain only Names from this Map
  Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();
  late List _citiesList;
  List get citiesList => _citiesList;
  set citiesList(List citiesListParameter) {
    _citiesList = citiesListParameter;
    notifyListeners();
  }

  late List<String> _citiesNames;
  List<String> get citiesNames => _citiesNames;
  set citiesNames(List<String> citiesNamesParameter) {
    _citiesNames = citiesNamesParameter;
    notifyListeners();
  }
  Future<void> getCitiesListFunction() async {
    List<String> citiesNamesClone = [];
    Uri url = Uri.parse('$serverURL/City/List');
    var response  = await http.get(url);
    citiesList = jsonDecode(response.body);
    _citiesList.forEach((e) => {
      if(e["Name"] == "الكل"){

      }else{
        citiesNamesClone.add(e["Name"]),
      }

    });

    citiesNames = citiesNamesClone;
    _prefs.then((SharedPreferences prefs) {
      prefs.setString("citiesNames" , jsonEncode(_citiesNames));
    });
    notifyListeners();
  }


  late List _categoryList;
  List get categoryList => _categoryList;
  set categoryList(List citiesListParameter) {
    _categoryList = citiesListParameter;
    notifyListeners();
  }

  late List<String> _categoryNames;
  List<String> get categoryNames => _categoryNames;
  set categoryNames(List<String> citiesNamesParameter) {
    _categoryNames = citiesNamesParameter;
    notifyListeners();
  }
  Future<void> getTypesListFunction() async {
    List<String> categoryNamesClone = [];
    Uri url = Uri.parse('$serverURL/Types/List');
    var response  = await http.get(url);
    print('$serverURL/Types/List');
    print(response.body);
    categoryList = jsonDecode(response.body);

    _categoryList.forEach((e) => {
      if(e["Name"] == "الكل"){

      }else{
        categoryNamesClone.add(e["Name"]),
      }
    });
    categoryNames = categoryNamesClone;
    _prefs.then((SharedPreferences prefs) {
      prefs.setString("categoryNames" , jsonEncode(_categoryNames));
    });
    notifyListeners();
  }


  checkCache(){
    _prefs.then((SharedPreferences prefs) {
      if( prefs.get("categoryNames") == null ){
      } else{
        categoryNames = jsonDecode(prefs.getString("categoryNames")!).cast<String>();
      }

      if( prefs.get("citiesNames") == null ){
      } else{
        categoryNames = jsonDecode(prefs.getString("citiesNames")!).cast<String>();
      }

    });
  }



}
