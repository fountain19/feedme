import 'package:feedme/model/product.dart';
import 'package:flutter/cupertino.dart';

class ProductInfo extends ChangeNotifier{
  List<Product> product=[];
  void addProduct(Product newValue){
    product.add(newValue);
    notifyListeners();
  }
  void deleteProduct(Product newValue){
    product.remove(newValue);
    notifyListeners();
  }

}