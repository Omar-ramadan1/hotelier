import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EnableAddingNewHotel  extends ChangeNotifier{
  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;


  set isEnabled(bool isEnabledParameter){
    _isEnabled = isEnabledParameter;
    print(_isEnabled);
    notifyListeners();
  }

}

