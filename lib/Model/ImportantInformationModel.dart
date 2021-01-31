import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotelier/Constant/Constant.dart';
import 'package:http/http.dart' as http;

class ImportantInformationModel extends ChangeNotifier {
  // this model is used to get the contact us information
  // and will be triggered at the splash screen to eliminate
  // the time difference between the openning screen
  // and the appearance of information

  Map _importantInformationModelMap;

  Map get importantInformationMap => _importantInformationModelMap;

  set importantInformationMap(Map contactUsDataParameter) {
    _importantInformationModelMap = contactUsDataParameter;
    notifyListeners();
  }

  getContactUsDataListFunction() {
    Map<String, String> newContactUsDataMap = {};
    httpContactDataRequest(3).then((String data) {
      newContactUsDataMap["phone1"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(4).then((String data) {
      newContactUsDataMap["phone2"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(5).then((String data) {
      newContactUsDataMap["WhatsApp"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(6).then((String data) {
      newContactUsDataMap["FaceBook"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(7).then((String data) {
      newContactUsDataMap["Twitter"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(8).then((String data) {
      newContactUsDataMap["snapChat"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(9).then((String data) {
      newContactUsDataMap["Price"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(10).then((String data) {
      newContactUsDataMap["Days"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(11).then((String data) {
      newContactUsDataMap["Email"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(12).then((String data) {
      newContactUsDataMap["Instagram"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    httpContactDataRequest(13).then((String data) {
      newContactUsDataMap["Price2"] = data;
      importantInformationMap = newContactUsDataMap;
    });
    // contactUsDataList = citiesNamesClone;
    // notifyListeners();
  }


  Future<String> httpContactDataRequest(int idNumber) async {
    Map data;
    var response = await http.get(
      '$serverURL/Pages/?id=$idNumber',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    data = jsonDecode(response.body);
    return data["PageBody"].toString();
  }

}