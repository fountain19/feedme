
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/endPrice.dart';
import 'package:feedme/provider/marketInfo.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String userId;
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  void getUserId()async{
    final  SharedPreferences localStorage=await SharedPreferences.getInstance();
    userId= localStorage.getString('userId');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    getUserLocation();
  }

  List<String> productName=[];
  List<String> productCounter=[];
  List<String> productPrice=[];

  String value = 'cash';
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'cash', title: 'Cash'),
    S2Choice<String>(value: 'card', title: 'Card'),
  ];


  TextEditingController textGeolocator=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textGeolocator.dispose();
    super.dispose();
  }

  void getUserLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark placemark=placemarks[0];

    String fullAddress=
        '${placemark.subLocality}'+','+
            '${placemark.thoroughfare}'+','+'No:'+'${placemark.subThoroughfare}';
    print('fullAddress is '"$fullAddress");

    textGeolocator.text=fullAddress;

  }

  double money;


  @override
  Widget build(BuildContext context) {

String marketName=Provider.of<MarketInfo>(context,listen: false).market[0].name;
    List<Product> product = Provider
        .of<ProductInfo>(context,listen: false)
        .product;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    List<int>   counter = Provider
        .of<ItemCount>(context,listen: false)
        .count;
    List<double>   price = Provider
        .of<TotalPrice>(context,listen: false)
        .price;
  double  endPrice = Provider
        .of<EndPrice>(context,listen: false)
        .Endprice;

    setState(() {
      money=endPrice+10;
    });


    return Scaffold(
      key: scaffold,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Color(0xff193044),
        title: Text(
          'CheckOut',style: TextStyle(
          color: Colors.white,
          fontSize: 25
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('CART SUMMARY',style: TextStyle(
                          color: Colors.yellow, fontSize: 20
                      ),),
                      Text('customize',style: TextStyle(
                          color: Colors.grey[800],fontSize: 15
                      ),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Market name',style: TextStyle(
                          color: Colors.white54,fontSize: 20
                      ),),
                      Text(marketName,
                        style: TextStyle(
                            color: Colors.white,fontSize: 20
                        ),),
                    ],),
                  ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                  productName.add(product[index].productName);
                   productCounter.add(counter[index].toString());
                   productPrice.add(product[index].price);
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
                                SizedBox(width: width*.09,),
                                Container(
                                  width: width * .1,
                                  height: height * .05,
                                  child: Container(
                                    child: Text('*${counter[index].toString()}'
                                        ,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20)),
                                  ),
                                ),
                                SizedBox(width: width*.05,),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Container(
                                    width: width * .132,
                                    height: height * .05,
                                    child: Text(
                                      price[index].toStringAsFixed(2),
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
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Item total',style: TextStyle(
                          color: Colors.white, fontSize: 20
                      ),),
                      Text(endPrice.toStringAsFixed(2),style: TextStyle(
                          color: Colors.white
                      ),)
                    ],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charges',style: TextStyle(
                          color: Colors.white60, fontSize: 15
                      ),),
                      Text('10.00',style: TextStyle(
                        color: Colors.white60,
                      ),)
                    ],),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total bill amount',style: TextStyle(
                          color: Colors.white, fontSize: 20
                      ),),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.yellow
                            )
                        ),
                        child: Text(money.toStringAsFixed(2),style: TextStyle(
                            color: Colors.blue[200],fontWeight: FontWeight.bold,fontSize: 25
                        ),),
                      )
                    ],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Address',style: TextStyle(
                          color: Colors.yellow, fontSize: 20
                      ),),
                      Text('Change',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                      ),)
                    ],),
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: textGeolocator,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      hintText: textGeolocator.text,
                      hintStyle: TextStyle(color: Colors.white),
                      hintMaxLines: 2,
                    ),
                  ),

                  Divider(color: Colors.white,),
                  Text('phone number'.toUpperCase(),style: TextStyle(
                  color: Colors.yellow,fontSize: 25
                  ),),
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      hintText:'please enter your telephone number',
                      hintStyle: TextStyle(color: Colors.white),
                      hintMaxLines: 1,
                    ),
                  ),
                  Divider(color: Colors.white,),
                  Text('Select payment mode : '.toUpperCase(),style: TextStyle(
                      color: Colors.yellow,fontSize: 25
                  ),),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                      title: 'Payment',
                      value: value,
                      choiceItems: options,
                      onChange: (state) => setState(() => value = state.value)
                  ),
                  SizedBox(height: height*.08,)
                ],
              ),
              Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    color: Colors.yellow,
                    height: height * 0.07,
                    width: width,
                    child: GestureDetector(
                        onTap: () {
                          valdlation();
                          FirebaseFirestore.instance.collection('costumerOrders').doc(userId).set(
                              {
                                'customerNumber':phoneNumber.text,
                                'marketName':marketName,
                               'productName':productName,
                                'productCounter': productCounter,
                                'productPrice': productPrice,
                                'totalPrice': money.toStringAsFixed(2),
                                'deliveryAddress': textGeolocator.text,
                                'paymentMethod':value,

                              }
                          );
                        },
                        child: Center(
                          child: Text(
                            'Pay',
                            style: TextStyle(
                               color: Color(0xff193044),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        )),
                  )),
            ],
          )

        ),
      ),
    );
  }
  void valdlation(){
    if (phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone number is empty"),
        ),
      );

    }
  }
}
