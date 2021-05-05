import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/widget/customMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarketContent extends StatefulWidget {
  final String marketName;
  MarketContent({this.marketName});

  @override
  _MarketContentState createState() => _MarketContentState();
}

class _MarketContentState extends State<MarketContent> {
  final FirebaseFirestore firestore =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Color(0xff193044),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(widget.marketName,textStyle:TextStyle(color: Colors.white ),
              )],
          isRepeatingAnimation: true,
        ),
        actions: [
          Container(

            height: height*0.1,
            width: width*.27,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,)
                    , onPressed: (){}),
                IconButton(icon: Icon(Icons.search,color: Colors.white,)
                    , onPressed: (){}),
              ],
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream : firestore.collection('Products').snapshots(),

          builder:(context,snapshot,) {
            if(snapshot.hasData){

              List<Product> products =[];
              for (var doc in snapshot.data.docs) {

                var data = doc.data();
                products.add(Product(
                  id:doc.id,
                  image: data['productImage'],
                  marketName : data['marketName'],
                  productName: data['productName'],
                  price:data['productPrice'],

                ));
              }
                  if(products[0].marketName==widget.marketName){
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: 0.8),

                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
                            child: GestureDetector(
                              onTap: (){},
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child:
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),

                                      child: CachedNetworkImage(
                                        imageUrl: products[index].image,
                                        placeholder: (context, url) => CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),

                                  ),

                                  Positioned(
                                    bottom: 0,
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        height: 60.0,

                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(products[index].productName,style: TextStyle(
                                                fontWeight: FontWeight.bold,color: Colors.white
                                              ),),
                                              Text('\$ ${products[index].price}',style: TextStyle(
                                                  color: Colors.white
                                              ),),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ) ,

                    );
                  }
                  else{
                    return
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sticky_note_2_outlined,
                            size: 75,
                            color: Colors.yellow.shade300,
                          ),
                          Text('No product yet......',style: TextStyle(
                            color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    );
                  }

            }
            else{
              return Center(child: Text('Loading......'));
            }
          }
      ),
    );
  }
}
