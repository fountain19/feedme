import 'package:feedme/model/market.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/marketInfo.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCart extends StatefulWidget {

  @override
  _EditCartState createState() => _EditCartState();
}

class _EditCartState extends State<EditCart> {
  @override
  Widget build(BuildContext context) {

    List<int> counter= Provider.of<ItemCount>(context).count;
    List<Market> market= Provider.of<MarketInfo>(context).market;
    List<Product> product= Provider.of<ProductInfo>(context).product;
    List<double> price= Provider.of<TotalPrice>(context).price;
    int itemCount= Provider.of<ItemCount>(context).item;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          leading: IconButton(

            icon:Icon(Icons.arrow_back_rounded),color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },

          ),
          title: Text(
            'Edit Cart',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff193044),
        ),
        body:counter==null||price==null?
        SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Container(
                height: height*.5,
                width: width * .5,
                child: Image.asset('images/icon/cart.png'),
              ),
              Text('Your cart is empty ',style: TextStyle(
                  color: Colors.white,
                      fontWeight: FontWeight.bold,
                fontSize: 25
              )),
              SizedBox(
                height: height*0.025,
              ),
              Text('Please add some items from the menu ',style: TextStyle(color: Colors.white)),
            ],
          ),
        )):
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: height*.2,width: width*.2,
                      child: Image.network(
                        market[0].image
                      ),
                    ),
                    Container(
                      child: Text(
                        market[0].name
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: product.length,
                    itemBuilder:(context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          height: height*.12,width: width*.9,
                          decoration: BoxDecoration(
                            color: Color(0xff193044),
                            border: Border.all(color: Colors.white,width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),

                                  height: height*.10,width: width*.2,
                                  child: Image.network(
                                    product[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(product[index].productName,style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                              IconButton(

                                  onPressed: (){
                                    setState(() {
                                      counter[index]=counter[index]+1;
                                      price[index]=price[index]+(counter[index]*double.parse(product[index].price));
                                      itemCount=itemCount+counter[index];
                                    });
                                    Provider.of<TotalPrice>(context,listen: false).savePrice(price[index]);
                                    Provider.of<ItemCount>(context,listen: false).addCounter(counter[index]);
                                    Provider.of<ItemCount>(context,listen: false).addItem(itemCount);
                                  },
                                  icon:Icon(Icons.add,color: Colors.white,)
                              ),
                              Container(
                                child: Text(counter[index].toString(),style: TextStyle(
                                    color: Colors.white)),
                              ),
                              IconButton(
                                  onPressed: (){
                                    if(counter[index]>1){
                                      setState(() {
                                        counter[index]=counter[index]-1;
                                        price[index]=price[index]-(counter[index]*double.parse(product[index].price));
                                        Provider.of<TotalPrice>(context,listen: false).savePrice(price[index]);
                                        Provider.of<ItemCount>(context,listen: false).addCounter(counter[index]);
                                        itemCount=itemCount-counter[index];
                                        Provider.of<ItemCount>(context,listen: false).addItem(itemCount);
                                      });
                                    }else{
                                      _showMaterialDialog(product[index],counter[index],
                                          price[index],itemCount
                                      );


                                    }
                                  },

                                  icon:Icon(Icons.remove,color: Colors.white,)
                              ),
                              Container(
                                child: Text(price[index].toStringAsFixed(2),style: TextStyle(
                                    color: Colors.white),
                                ),
                              )],
                          ),
                        ),
                      );
                    } ),
              ],
            ),
          ),
        ));
  }
  _showMaterialDialog(Product _product, int _counter,double _price,int _itemCount) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Remove"),
          content: new Text("Are you sure to want remove this item from cart"),
          actions: <Widget>[
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }
                , child: Text('No')),
            TextButton(
                onPressed: (){

                  setState(() {
                    _counter=_counter-1;
                    _price=_price-(_counter*double.parse(_product.price));
                    _itemCount=_itemCount-_counter;
                  });
                  Provider.of<ProductInfo>(context,listen: false).deleteProduct(_product);
                  Provider.of<TotalPrice>(context,listen: false).savePrice(_price);
                  Provider.of<ItemCount>(context,listen: false).addCounter(_counter);
                  Provider.of<ItemCount>(context,listen: false).addItem(_itemCount);

                  Navigator.pop(context);
                },
                child: Text('Yes'))
          ],
        ));
  }
}
