import 'package:flutter/cupertino.dart';

class TotalPrice extends ChangeNotifier{

  List<double> price=[];
  void savePrice(double newValue){
   price.add(newValue);
    notifyListeners();
  }
}