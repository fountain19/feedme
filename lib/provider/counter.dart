import 'package:flutter/cupertino.dart';

class ItemCount extends ChangeNotifier{

  int item;
  void addCounter(int newValue){
    item=newValue;
    notifyListeners();
  }


}