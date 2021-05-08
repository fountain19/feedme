import 'package:feedme/model/market.dart';
import 'package:flutter/cupertino.dart';

class MarketInfo extends ChangeNotifier{
  List<Market> market=[];
  void addMarket(Market newValue){
    market.add(newValue);
    notifyListeners();
  }
  void deleteMarket(Market newValue){
    market.remove(newValue);
    notifyListeners();
  }

}