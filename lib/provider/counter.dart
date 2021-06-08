import 'package:flutter/cupertino.dart';

class ItemCount extends ChangeNotifier{
List<int> count=[];
  int item;
  void addItem(int newValue){
    item=newValue;
    notifyListeners();
  }
void addCounter(int counter){
    count.add(counter);
    notifyListeners();
}
void deleteCounter(int counter){
  count.remove(counter);
  notifyListeners();
}

}