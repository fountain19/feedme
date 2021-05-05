
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/adminPanel/editMarket.dart';
import 'package:feedme/model/market.dart';
import 'package:feedme/widget/customMenu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MangeMarket extends StatefulWidget {


  @override
  _MangeMarketState createState() => _MangeMarketState();
}

class _MangeMarketState extends State<MangeMarket> {
  final Reference productRef = FirebaseStorage.instance
      .ref()
      .child('Logo');
final FirebaseFirestore firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: StreamBuilder<QuerySnapshot>(
          stream : firestore.collection('MarketName').snapshots(),

          builder:(context,snapshot,) {
            if(snapshot.hasData){

              List<Market> markets=[];
              for (var doc in snapshot.data.docs) {

                var data = doc.data();
                markets.add(Market(
                    id:doc.id,
                    image: data['marketLogo'],
                    name: data['marketName'],
                    lessPrice: data['marketLessPrice'],
                    description: data['marketDescription'],
                  time: data['marketTime'],

                ));
              }
              return  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 0.8),

                itemCount: markets.length,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
                      child: GestureDetector(
                        onTapUp: (details){
                          double dx=details.globalPosition.dx;
                          double dy=details.globalPosition.dy;
                          double dx1=MediaQuery.of(context).size.width-dx;
                          double dy1=MediaQuery.of(context).size.width-dy;
                          showMenu(context: context,
                              position: RelativeRect.fromLTRB(dx,dy,dx1, dy1),
                              items:[
                                MyPopupMenuItem(
                                  child: Text('Edit'),
                                  onClick:()async{
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return EditMarket(market :markets[index]);
                                    }));
                                  },
                                ),
                                MyPopupMenuItem(
                                  onClick: ()async{
                                    Navigator.pop(context);
                                    firestore.collection('MarketName').doc(markets[index].id).delete();
                                    Reference productRef = FirebaseStorage.instance
                                        .ref()
                                        .child('Logo').child(markets[index].id);
                                    await productRef.delete();

                                  },
                                  child: Text('Delete'),),
                              ]);
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child:    CachedNetworkImage(
                        imageUrl: markets[index].image,
                          placeholder: (context, url) => CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.6,
                                child: Container(
                                  height: 60.0,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(markets[index].name,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Text('\$ ${markets[index].lessPrice}'),

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
              return Center(child: Text('Loading......'));
            }
          }
      ),
    );
  }
}
