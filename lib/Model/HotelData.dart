
import 'package:flutter/foundation.dart';

class HotelData extends ChangeNotifier{

  // first of all i want to apologies for this that may seem like mess
  // but i need MainList from server which is composed of Maps
  // and need seperated String List that Contain only Names from this Map

  late List _hotelChosen;
  List get hotelChosen => _hotelChosen;
  set hotelChosen(List hotelChosenParameter) {
    _hotelChosen = hotelChosenParameter;
    notifyListeners();
  }



}
