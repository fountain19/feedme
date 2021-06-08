import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/customerRequest.dart';
import 'package:feedme/model/market.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/endPrice.dart';
import 'package:feedme/provider/marketInfo.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';
import 'package:feedme/screen/checkOut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EditCart extends StatefulWidget {
  @override
  _EditCartState createState() => _EditCartState();
}

class _EditCartState extends State<EditCart> {
  double endPrice;
  List<int> counter;
  List<double> price;
  List<Product> product;
  List<Market> market;
int itemCount;


  @override
  Widget build(BuildContext context) {

    // String Id = Uuid().v4();
    //


   counter = Provider
        .of<ItemCount>(context)
        .count;
    product = Provider
        .of<ProductInfo>(context)
        .product;
     price = Provider
        .of<TotalPrice>(context)
        .price;
     itemCount = Provider
        .of<ItemCount>(context)
        .item;
     endPrice = Provider
        .of<EndPrice>(context)
        .Endprice;

    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        // actions: [
        //   TextButton(
        //       onPressed: () {
        //         emptyCart();
        //       },
        //       child:itemCount == null || itemCount == 0?Text(''):Text('Cancel', style: TextStyle(
        //         color: Colors.white,
        //       ),))
        // ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
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
      body: itemCount == null || itemCount == 0
          ? SingleChildScrollView(
        physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: height * .5,
                  width: width * .5,
                  child: Image.asset('images/icon/cart.png'),
                ),
                Text('Your cart is empty ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                SizedBox(
                  height: height * 0.025,
                ),
                Text('Please add some items from the menu ',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ))
          : Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Market name:',
                                style: TextStyle(color: Colors.white,fontSize: 25),
                              ),
                              Text(
                                product[0].marketName,
                                style: TextStyle(color: Colors.white,),
                              ),
                            ],
                          ),
                     ),

                  ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: height * .12,
                            width: width * .95,
                            decoration: BoxDecoration(
                              color: Color(0xff193044),
                              border:
                              Border.all(color: Colors.white, width: 1),
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
                                    height: height * .10,
                                    width: width * .2,
                                    child: Image.network(
                                      product[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width * .2,
                                  height: height * .07,
                                  child: Text(
                                    product[index].productName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  //color: Colors.white,
                                  width: width * .3,
                                  height: height * .05,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              counter[index] =
                                                  counter[index] + 1;
                                              endPrice = endPrice +
                                                  double.parse(
                                                      product[index].price);
                                              price[index] = price[index] +
                                                  double.parse(
                                                      product[index].price);
                                              itemCount = itemCount + 1;
                                            });
                                            Provider.of<EndPrice>(context,
                                                listen: false)
                                                .getPrice(endPrice);
                                            Provider.of<TotalPrice>(context,
                                                listen: false)
                                                .savePrice(price[index]);
                                            Provider.of<ItemCount>(context,
                                                listen: false)
                                                .addCounter(counter[index]);
                                            Provider.of<ItemCount>(context,
                                                listen: false)
                                                .addItem(itemCount);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                      Container(
                                        child: Text(counter[index] != null ?
                                        counter[index].toString() : '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (counter[index] > 1) {
                                              setState(() {
                                                counter[index] =
                                                    counter[index] - 1;
                                                endPrice = endPrice -
                                                    double.parse(
                                                        product[index]
                                                            .price);
                                                price[index] =
                                                    price[index] -
                                                        double.parse(
                                                            product[index]
                                                                .price);
                                                itemCount = itemCount - 1;
                                              });
                                              Provider.of<EndPrice>(context,
                                                  listen: false)
                                                  .getPrice(endPrice);
                                              Provider.of<TotalPrice>(
                                                  context,
                                                  listen: false)
                                                  .savePrice(price[index]);
                                              Provider.of<ItemCount>(
                                                  context,
                                                  listen: false)
                                                  .addCounter(
                                                  counter[index]);
                                              Provider.of<ItemCount>(
                                                  context,
                                                  listen: false)
                                                  .addItem(itemCount);
                                            }
                                            else
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (_) =>
                                                          new AlertDialog(
                                                            title: new Text(
                                                                "Remove"),
                                                            content: new Text(
                                                                "Are you sure to want remove this item from cart"),
                                                            actions: <
                                                                Widget>[
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'No')),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (product.length !=
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        endPrice =
                                                                            endPrice - double.parse(product[index].price);
                                                                        itemCount =
                                                                            itemCount - 1;
                                                                        counter[index] =  counter[index] - 1;
                                                                        price[index] = price[index] -
                                                                            double.parse(
                                                                                product[index]
                                                                                    .price);

                                                                      });
                                                                      print('counter and price : ${counter[index]} && ${price[index]}');
                                                                      Provider.of<EndPrice>(context, listen: false)
                                                                          .getPrice(endPrice);

                                                                      Provider.of<TotalPrice>(context, listen: false)
                                                                          .deletePrice(price[index]);
                                                                      Provider.of<ItemCount>(context, listen: false)
                                                                          .deleteCounter(counter[index]);
                                                                      Provider.of<ItemCount>(context, listen: false)
                                                                          .addItem(itemCount);
                                                                      Provider.of<ProductInfo>(context, listen: false)
                                                                          .deleteProduct(product[index]);

                                                                      Navigator.pop(
                                                                          context);
                                                                    } else if (product.length ==
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                            endPrice =
                                                                                endPrice - double.parse(product[index].price);
                                                                            itemCount =
                                                                                itemCount - 1;
                                                                            counter[index] =  counter[index] - 1;
                                                                            price[index] = price[index] -
                                                                                double.parse(
                                                                                    product[index]
                                                                                        .price);
                                                                      });
                                                                      Provider.of<EndPrice>(context, listen: false)
                                                                          .getPrice(endPrice);
                                                                      Provider.of<TotalPrice>(context, listen: false)
                                                                          .deletePrice(price[index]);
                                                                      Provider.of<ItemCount>(context, listen: false)
                                                                          .deleteCounter(counter[index]);
                                                                      Provider.of<ItemCount>(context, listen: false)
                                                                          .addItem(itemCount);
                                                                      Provider.of<ProductInfo>(context, listen: false)
                                                                          .deleteProduct(product[index]);

                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                      'Yes'))
                                                            ],
                                                          ));
                                            // _showMaterialDialog(product[index],counter[index],
                                            //    price[index],itemCount
                                            // );
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Container(
                                    //color: Colors.white,
                                    width: width * .132,
                                    height: height * .05,
                                    child: Text(price[index] != null ?
                                    price[index].toStringAsFixed(2) : '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                       SizedBox(height: height*0.2,)
                ],
              ),
            ),
          ),

          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white38,
                  ),
                  height: height * 0.15,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(left: width * 0.01),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left: width * 0.01),
                                child: Text(
                                  '(Excluding taxes and other Charges)',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Text(endPrice.toStringAsFixed(2))
                        ],
                      ),
                      Container(
                        color: Color(0xff193044),
                        height: height * 0.07,
                        width: width,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder:(context)=>Checkout()));
                            },
                            child: Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            )),
                      ),
                    ],
                  ))),
        ],
      ),

      // SingleChildScrollView(
      //   physics: ScrollPhysics(),
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       StreamBuilder(
      //           stream:
      //            FirebaseFirestore.instance.collection('CustomerRequests').doc(userId).
      //            collection('request').snapshots(),
      //           builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
      //             List<CustomerRequest> customerRequest=[];
      //             if (snapshot.hasError) {
      //
      //
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 16),
      //                 child: Text('Error: ${snapshot.error}'),
      //               );
      //
      //
      //             } else {
      //               switch (snapshot.connectionState) {
      //                 case ConnectionState.none:
      //
      //                   const Padding(
      //                     padding: EdgeInsets.only(top: 16),
      //                     child: Text('Select a lot'),
      //                   );
      //
      //                   break;
      //                 case ConnectionState.waiting:
      //
      //                   SizedBox(
      //                     child: const CircularProgressIndicator(),
      //                     width: 60,
      //                     height: 60,
      //                   );
      //
      //                   break;
      //                 case ConnectionState.active:
      //                   for (var doc in snapshot.data.docs) {
      //
      //                     customerRequest.add(CustomerRequest(
      //                     marketName: doc['marketName'],
      //                     counter: doc['counter'],
      //                       productImage:  doc['marketImage'],
      //                     productName:doc['productName'],
      //                     productPrice: doc['productPrice'],
      //                     totalPrice:  doc['totalPrice'],
      //
      //                     ));
      //                   }
      //
      //                   break;
      //                 case ConnectionState.done:
      //
      //
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 16),
      //                     child: Text('\$${snapshot.data} (closed)'),
      //                   );
      //
      //                   break;
      //               }
      //             }
      //             return  ListView.builder(
      //
      //                 scrollDirection: Axis.vertical,
      //                 itemCount:customerRequest.length ,
      //                 physics: ScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemBuilder: (context,index){
      //                   return Padding(
      //                     padding:  EdgeInsets.only(top: 10),
      //                     child: Container(
      //
      //                       height: height*.12,width: width*.95,
      //                       decoration: BoxDecoration(
      //                         color: Color(0xff193044),
      //                         border: Border.all(color: Colors.white,width: 1),
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Container(
      //                               decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                               ),
      //
      //                               height: height*.10,width: width*.2,
      //                               child: Image.network(
      //                                 customerRequest[index].productImage,
      //                                 fit: BoxFit.cover,
      //                               ),
      //                             ),
      //                           ),
      //                           Container(
      //
      //                             width: width*.2,
      //                             height: height*.07,
      //                             child: Text(
      //                               customerRequest[index].productName,style: TextStyle(
      //                                 color: Colors.white
      //                             ),),
      //                           ),
      //                           Container(
      //
      //                             //color: Colors.white,
      //                             width: width*.3,
      //                             height: height*.05,
      //                             child: Row(
      //                               children: [
      //                                 IconButton(
      //
      //                                     onPressed: (){
      //                                       setState(() {
      //                                         counter[index]=counter[index]+1;
      //                                         price[index]=price[index]+double.parse(product[index].price);
      //                                         itemCount=itemCount+1;
      //                                       });
      //                                       Provider.of<TotalPrice>(context,listen: false).savePrice(price[index]);
      //                                       Provider.of<ItemCount>(context,listen: false).addCounter(counter[index]);
      //                                       Provider.of<ItemCount>(context,listen: false).addItem(itemCount);
      //                                     },
      //                                     icon:Icon(Icons.add,color: Colors.white,size: 15,)
      //                                 ),
      //                                 Container(
      //
      //                                   child: Text(counter[index].toString(),style: TextStyle(
      //                                       color: Colors.white,fontSize: 10)),
      //                                 ),
      //                                 IconButton(
      //                                     onPressed: (){
      //                                       if(counter[index]>1){
      //                                         setState(() {
      //                                           counter[index]=counter[index]-1;
      //                                           price[index]=price[index]-double.parse(product[index].price);
      //                                           itemCount=itemCount-1;
      //                                         }
      //                                         );
      //                                         Provider.of<TotalPrice>(context,listen: false).savePrice(price[index]);
      //                                         Provider.of<ItemCount>(context,listen: false).addCounter(counter[index]);
      //                                         Provider.of<ItemCount>(context,listen: false).addItem(itemCount);
      //                                       }else{
      //                                         _showMaterialDialog(product[index],counter[index],
      //                                             price[index],itemCount
      //                                         );
      //                                       }
      //
      //                                     },
      //
      //                                     icon:Icon(Icons.remove,color: Colors.white,size: 15,)
      //                                 ),
      //                               ],),
      //                           ),
      //                           Padding(
      //                             padding:  EdgeInsets.only(top: 15),
      //                             child: Container(
      //                               //color: Colors.white,
      //                               width: width*.132,
      //                               height: height*.05,
      //                               child: Text(price[index].toStringAsFixed(2),style: TextStyle(
      //                                   color: Colors.white,fontSize: 12),
      //                               ),
      //                             ),
      //                           )],
      //                       ),
      //                     ),
      //                   );
      //                 });
      //           }),
      //     ],
      //   ),
      // ),
    );
  }

  // void emptyCart() {
  //   showDialog(
  //           context: context,
  //           builder:
  //               (_) =>
  //                   new AlertDialog(
  //                     title: new Text(
  //                         "Remove"),
  //                     content: new Text(
  //                         "Are you sure to want remove content of  cart"),
  //   actions: [
  //   TextButton(
  //                         onPressed:
  //                             () {
  //                           Navigator.pop(
  //                               context);
  //                         },
  //                         child: Text(
  //                             'No')),
  //   TextButton(
  //                         onPressed:
  //                             () {
  //                             setState(() {
  //
  //
  //                                 setState(() {
  //                                   endPrice =0;
  //
  //                                   itemCount =
  //                                   0;
  //                                   counter =
  //                                   null;
  //                                   price =
  //                                   null;
  //                                   product=null;
  //                                   market=null;
  //
  //                                 });
  //
  //                                 Provider.of<EndPrice>(context, listen: false)
  //                                     .getPrice(endPrice);
  //                                 Provider.of<TotalPrice>(context, listen: false)
  //                                     .savePrice(price[index]);
  //                                 Provider.of<ItemCount>(context, listen: false)
  //                                     .addCounter(counter[index]);
  //                                 Provider.of<ItemCount>(context, listen: false)
  //                                     .addItem(itemCount);
  //
  //                                 Provider.of<ProductInfo>(context, listen: false)
  //                                     .deleteProduct(product[index]);
  //
  //
  //                                 Provider.of<MarketInfo>(context, listen: false)
  //                                     .deleteMarket(market[index]);
  //
  //                             });
  //
  //
  //                         },
  //                         child: Text(
  //                             'Yes')),
  //   ],
  //
  //                   ));
  // }
}