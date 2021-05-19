import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class AddToBasket extends StatefulWidget {
 Product product;
 AddToBasket({this.product});
  @override
  _AddToBasketState createState() => _AddToBasketState();
}

class _AddToBasketState extends State<AddToBasket> {
int item;
  int counter=1;
double totalPrice;
  double price;
String userId;
String Id = Uuid().v4();

void getUserId()async{
  final  SharedPreferences localStorage=await SharedPreferences.getInstance();
   userId= localStorage.getString('userId');

  setState(() {});
}

@override
void initState() {
  super.initState();
  getUserId();
}

  @override
  Widget build(BuildContext context) {

    final  itemCount= Provider.of<ItemCount>(context).item;
    setState(() {
      price=double.parse(widget.product.price);
      totalPrice =price*counter;

    });


    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Color(0xff193044),
        title: AnimatedTextKit(
         animatedTexts: [
           TyperAnimatedText('Add to basket',textStyle:TextStyle(color: Colors.white )),
         ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:Column(
    children: [
      Container(
        width: width,
        height: height*.3,
         child: CachedNetworkImage(
           fit: BoxFit.cover,
           imageUrl: widget.product.image,
           placeholder: (context, url) => CircularProgressIndicator(
             backgroundColor: Colors.white,
           ),
           errorWidget: (context, url, error) => Icon(Icons.error),
         ),

      ),
      SizedBox(
        height: height*.1,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.product.productName,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            fontSize: 25
            )),
            Text('${widget.product.price} t',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
                fontSize: 25
            ))
          ],
        ),
      ),
      SizedBox(height: height*.2,),
      Container(
            decoration: BoxDecoration(
                color: Color(0xff193044),
                borderRadius: BorderRadius.circular(10)
            ),
            height: height*.09,width: width*.5,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(Icons.add,color: Colors.white,
                  size:35 ,),
                    onPressed: (){
                      setState(() {
                        counter=counter+1;

                      });
                    }),
                Text(counter.toString(),style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
fontSize: 25
                )),
                IconButton(icon: Icon(Icons.remove,color: Colors.white,
                  size:35 ,),
                    onPressed: (){
                      if(counter>1){
                        setState(() {
                          counter=counter-1;
                        });
                      }
                    }),
              ],
            ),
          ),
       Spacer(),
      Container(
        color:Color(0xff193044),
        width: width,
        height: height*.1,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Total ${totalPrice.toStringAsFixed(2)} t'
                  ,style:TextStyle(color: Colors.white )),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[700]
                ),
                height: height*.07,
                width: width*.3,
                child: TextButton(
                    onPressed: (){
                      // FirebaseFirestore.instance.collection('CustomerRequests').doc(userId)
                      //     .collection('request').doc(Id).set({
                      //   'marketName':widget.product.marketName,
                      //   'productImage':widget.product.image,
                      //
                      //   'productName':widget.product.productName,
                      //   'productPrice':widget.product.price,
                      //   'counter':counter,
                      //   'totalPrice':totalPrice.toStringAsFixed(2)
                      // });
                        if(itemCount==null){
                          setState(() {
                            item=counter;
                          });
                        }
                        else{
                          setState(() {
                            item=itemCount+counter;
                          });
                        }
                        Provider.of<ItemCount>(context,listen: false).addCounter(counter);
                      Provider.of<ItemCount>(context,listen: false).addItem(item);
                        Provider.of<TotalPrice>(context,listen: false).savePrice(totalPrice);
                        Provider.of<ProductInfo>(context,listen: false).addProduct(widget.product);
                      Navigator.pop(context);
                    },
                    child: Text('Add item',
                        style:TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold))),
              ),
            ],

          ),
        ),
      )


    ],
    ));
  }
}
