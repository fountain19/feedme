import 'package:flutter/material.dart';

class EndPrice extends ChangeNotifier{
  List<double> price=[];
  void getPrice(double value){
    price.add(value);
    notifyListeners();
  }
}