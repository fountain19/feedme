
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/adminPanel/editProduct.dart';
import 'package:feedme/model/Product.dart';
import 'package:feedme/widget/customMenu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MangeProduct extends StatefulWidget {


  @override
  _MangeProductState createState() => _MangeProductState();
}

class _MangeProductState extends State<MangeProduct> {
  final Reference productRef = FirebaseStorage.instance
      .ref()
      .child('Product images');
final FirebaseFirestore firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: StreamBuilder<QuerySnapshot>(
          stream : firestore.collection('product info').snapshots(),

          builder:(context,snapshot,) {
            if(snapshot.hasData){

              List<Product> products=[];
              for (var doc in snapshot.data.docs) {

                var data = doc.data();
                products.add(Product(
                    id:doc.id,
                    image: data['productImage'],
                    name: data['productName'],
                    price: data['productPrice'],
                    description: data['productDescription'],
                    weight: data['productWeight'],
                    calories: data['productCalories'],
                    components: data['productComponents']
                ));
              }
              return  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 0.8),

                itemCount: products.length,
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
                                      return EditProduct(product :products[index]);
                                    }));
                                  },
                                ),
                                MyPopupMenuItem(
                                  onClick: ()async{
                                    Navigator.pop(context);
                                    firestore.collection('product info').doc(products[index].id).delete();
                                    Reference productRef = FirebaseStorage.instance
                                        .ref()
                                        .child('Product images').child(products[index].id);
                                    await productRef.delete();
                                    // Reference storageReference=  FirebaseStorage.instance.refFromURL(products[index].image);
                                    //  await storageReference.delete();

                                  },
                                  child: Text('Delete'),),
                              ]);
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(products[index].image)
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
                                        Text(products[index].name,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Text('\$ ${products[index].price}'),

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
