
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/market.dart';

import 'package:feedme/screen/aboutPage.dart';
import 'package:feedme/screen/contact.dart';
import 'package:feedme/screen/detailScreen.dart';
import 'package:feedme/screen/marketContent.dart';
import 'package:feedme/screen/order.dart';
import 'package:feedme/screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'login.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String postId = Uuid().v4();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  String finalName='';
  String finalEmail='';
   String finalImage='';

  void getEmailAndName()async{
    final  SharedPreferences localStorage=await SharedPreferences.getInstance();
    finalName= localStorage.getString('userName');
    finalEmail = localStorage.getString('userEmail');
    finalImage = localStorage.getString('userImage');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEmailAndName();
  }
  @override
  Widget build(BuildContext context) {


final height=MediaQuery.of(context).size.height;
final width=MediaQuery.of(context).size.width;


    final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
    Widget buildCard({String image,String title})
    {
      return GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
            return DetailScreen();
          }));
        },
        child: Container(
          height: height*.5,width: width*.45,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            color: Color(0xff193044),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/$image.jpg'),
                ),
                Text(title, style: TextStyle(
                    fontSize: 20.0,color: Colors.white,
                    fontWeight:FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(

      backgroundColor: Colors.blueGrey,
      key: scaffold,
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff193044),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    height: height*.10,
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      GestureDetector(
                          child:Icon(Icons.sort,size: 40,color: Colors.white,)
                          , onTap:(){
                            scaffold.currentState.openDrawer();
                      }),
                          GestureDetector(
                              child:Stack(
                                children: [
                                  Icon(Icons.shopping_cart,size: 40,color: Colors.white,)

                                ],
                              ),
                              onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return OrderScreen();
                            }));
                          }),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    height: height*.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 45,backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/man.jpg'),
                          ),
                        ),
                        Container(
                          child: Text('We are at your service',
                          style: TextStyle(
                            fontSize: 20.0,color: Colors.white,
                              fontWeight:FontWeight.bold
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              color: Theme.of(context).accentColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color:Theme.of(context).accentColor ,
                    width: double.infinity,
                    height: height*.3,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: height*.3,
                            child: Row(
                              children: [
                                buildCard(image: 'pizza',title: 'pizza'),
                                buildCard(image: 'burgur',title: 'burgur'),
                                buildCard(image: 'sandwish',title: 'sandwish'),
                                buildCard(image: 'patato',title: 'patato'),
                                buildCard(image: 'salad',title: 'salad')
                              ],
                            ),
                          )
                        )
                      ],
                    )
                  ),
                  Align(
                    alignment:Alignment.topLeft ,
                    child: Text('Restaurants',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                  ),
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('MarketName').snapshots(),
                            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                              List<Market> markets=[];
                              if (snapshot.hasError) {


                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  );


                              } else {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:

                                      const Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Select a lot'),
                                      );

                                    break;
                                  case ConnectionState.waiting:

                                      SizedBox(
                                        child: const CircularProgressIndicator(),
                                        width: 60,
                                        height: 60,
                                      );

                                    break;
                                  case ConnectionState.active:
                                    for (var doc in snapshot.data.docs) {

                                      markets.add(Market(
                                          image: doc['marketLogo'],
                                          lessPrice: doc['marketLessPrice'],
                                          name: doc['marketName'],
                                          description: doc['marketDescription'],
                                          time: doc['marketTime'],

                                      ));
                                    }

                                    break;
                                  case ConnectionState.done:


                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text('\$${snapshot.data} (closed)'),
                                      );

                                    break;
                                }
                              }
                              return  ListView.builder(

                                scrollDirection: Axis.vertical,
                                  itemCount:markets.length ,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding:  EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, (MaterialPageRoute(
                                            builder: (context)=>MarketContent(marketName:markets[index].name)
                                          )));
                                        },
                                        child: Container(
                                          height: height*.25,
                                          width: width*.1,
                                          decoration:BoxDecoration(
                                            color: Color(0xff193044),
                                            borderRadius: BorderRadius.circular(25)
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                             Container(
                                               height:height*.20,
                                              width: width*0.25,
                                               child: Card(
                                                 color: Color(0xff193044),
                                                 child:CachedNetworkImage(
                                                   imageUrl: markets[index].image,
                                                   placeholder: (context, url) => CircularProgressIndicator(
                                                     backgroundColor: Colors.white,
                                                   ),
                                                   errorWidget: (context, url, error) => Icon(Icons.error),
                                                 ),
                                                 // Image(
                                                 //   fit: BoxFit.cover,
                                                 //   image: NetworkImage(markets[index].image),
                                                 // ),
                                               ),
                                             ),
                                              Padding(
                                                padding:  EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                child: Column(
                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(markets[index].name,style: TextStyle(
                                                      color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                                                    ),),
                                                    Container(
                                                      width:width*.3,
                                                      child: Text(
                                                        markets[index].description,
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                          color: Colors.white38,fontSize: 15
                                                      ),),
                                                    ),
                                                    Row(mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.access_time,color: Colors.white,),
                                                            Text(markets[index].time,style: TextStyle(
                                                                color: Colors.white
                                                            ),),
                                                            Text('mins',style: TextStyle(
                                                              color: Colors.white
                                                            ),)
                                                          ],
                                                        ),
                                                        SizedBox(width: width*0.05),
                                                        Column(children: [
                                                        Row(
                                                          children: [
                                                          Text(markets[index].lessPrice,style: TextStyle(
                                                              color: Colors.white
                                                          ),),
                                                          SizedBox(width: width*0.01,),
                                                          Text('tl',style: TextStyle(
                                                              color: Colors.white
                                                          ),),
                                                        ],),
                                                          Text('min order',style: TextStyle(
                                                              color: Colors.white
                                                          ),)
                                                        ],),

                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Container(
        color: Color(0xff193044),
        child: SafeArea(
          child: Drawer(
            child: Container(
              color: Theme.of(context).accentColor,
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xff193044)
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:finalImage=='' || finalImage==null ?AssetImage('images/icon/person.png'):NetworkImage(finalImage)
                    ),
                      accountName: Text(
                      finalName!=null?finalName:''

                      ),
                      accountEmail: Text(
                      finalEmail!=null?finalEmail:''

                      ),),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return HomePage();
                      }));
                    },
                    title: Text('Home Page', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                        child: Icon(Icons.home,size: 30,color:Color(0xff193044))),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return Contact();
                      }));
                    },
                    title: Text('Contact us', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.contact_phone_rounded,size: 30,color:Color(0xff193044))),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return AboutPage();
                      }));
                    },
                    title: Text('About page', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.info,size: 30,color:Color(0xff193044))),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return OrderScreen();
                      }));
                    },
                    title: Text('Order', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.shopping_cart,size: 30,color:Color(0xff193044))),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Profile()));
                    },
                    title: Text('Profile page', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,size: 30,color:Color(0xff193044))),
                  ),
                  ListTile(
                    onTap: ()async
                    {
                      SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                      localStorage.clear();
                      await FacebookAuth.instance.logOut();

                      await _googleSignIn.signOut();

                      await FirebaseAuth.instance.signOut();
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return Login();
                     }));

                    },
                    title: Text('Log out', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:FontWeight.bold
                    ),),
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.logout,size: 30,color:Color(0xff193044))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }





}
