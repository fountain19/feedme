import 'package:flutter/material.dart';

class EndPrice extends ChangeNotifier{
  double Endprice;
  void getPrice(double value){
    Endprice=value;
    notifyListeners();
  }
}