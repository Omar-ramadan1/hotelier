import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DataList extends ChangeNotifier{

  // first of all i want to apologies for this that may seem like mess
  // but i need MainList from server which is composed of Maps
  // and need seperated String List that Contain only Names from this Map

  List _citiesList;
  List get citiesList => _citiesList;
  set citiesList(List citiesListParameter) {
    _citiesList = citiesListParameter;
    notifyListeners();
  }

  List<String> _citiesNames;
  List<String> get citiesNames => _citiesNames;
  set citiesNames(List<String> citiesNamesParameter) {
    _citiesNames = citiesNamesParameter;
    notifyListeners();
  }
  Future<void> getCitiesListFunction() async {
    List<String> citiesNamesClone = [];
    var response  = await http.get('http://api.hoteliercard.com/api/City/List');
    citiesList = jsonDecode(response.body);
    print(citiesList);
    _citiesList.forEach((e) => {
      citiesNamesClone.add(e["Name"]),
    });
    print(citiesNamesClone);
    citiesNames = citiesNamesClone;
    notifyListeners();
  }


  List _categoryList;
  List get categoryList => _categoryList;
  set categoryList(List citiesListParameter) {
    _categoryList = citiesListParameter;
    notifyListeners();
  }

  List<String> _categoryNames;
  List<String> get categoryNames => _categoryNames;
  set categoryNames(List<String> citiesNamesParameter) {
    _categoryNames = citiesNamesParameter;
    notifyListeners();
  }
  Future<void> getTypesListFunction() async {
    List<String> categoryNamesClone = [];
    var response  = await http.get('http://api.hoteliercard.com/api/Types/List');
    categoryList = jsonDecode(response.body);
    print(_categoryList);

    _categoryList.forEach((e) => {
      categoryNamesClone.add(e["Name"]),
    });
    print(categoryNamesClone);
    categoryNames = categoryNamesClone;

    notifyListeners();
  }



}
