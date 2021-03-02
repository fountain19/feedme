
import 'package:feedme/screen/aboutPage.dart';
import 'package:feedme/screen/contact.dart';
import 'package:feedme/screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
    Widget buildCard({String image,String title})
    {
      return Container(
        height: 200,width: 150,
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
      );
    }

    Widget bottomCard({String image,String name,String rating,String price})
    {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              height: 200,width: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                color: Color(0xff193044),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text(name, style: TextStyle(
                          fontSize: 25.0,color: Colors.white,
                          fontWeight:FontWeight.bold
                      ),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.star,color: Colors.yellow,),
                          Text(rating,style: TextStyle(
                              fontSize: 10.0,color: Colors.blueGrey,
                              fontWeight:FontWeight.bold
                          ),),
                          Text(price,style: TextStyle(
                              fontSize: 15.0,color: Colors.blue,
                              fontWeight:FontWeight.bold
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('images/$image.jpg'),
          ),
        ],
      );
    }

    return Scaffold(
      key: scaffold,
      body:
      Container(
        color:Color(0xff193044),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Color(0xff193044),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          IconButton(
                              icon:Icon(Icons.sort,size: 40,color: Colors.white,)
                              , onPressed:(){
                                scaffold.currentState.openDrawer();
                          }),
                              IconButton(
                                  icon:Icon(Icons.notifications,size: 40,color: Colors.white,)
                                  , onPressed:(){}),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                          height: 85.0,
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
                          height: 250.0,
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  height: 250,
                                  child: Row(
                                    children: [
                                      buildCard(image: 'pizza',title: 'pizza'),
                                      buildCard(image: 'burgur',title: 'burgur'),
                                      buildCard(image: 'sandwish',title: 'sandwish'),
                                      buildCard(image: 'patato',title: 'patato'),
                                      buildCard(image: 'salad',title: 'salad')
                                    ],
                                  ),

                                ),
                              )
                            ],
                          )
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Featured',style: TextStyle(color: Colors.white,
                            fontSize: 25,fontWeight: FontWeight.bold),),
                            Text('View all',style: TextStyle(color: Colors.white,
                                fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Container(
                          color:Theme.of(context).accentColor ,
                          width: double.infinity,
                          height: 250.0,
                          child: Column(
                            children: [
                            SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                                height: 250,
                                child: Row(
                                  children: [
                                    bottomCard(
                                      image: "pizza",
                                      name: 'pizza',
                                      price: '\$50',

                                      rating: '4.5 Rating'
                                    ),
                                    bottomCard(
                                        image: "burgur",
                                        name: 'burgur',
                                        price: '\$35',

                                        rating: '5 Rating'
                                    ),
                                    bottomCard(
                                        image: "patato",
                                        name: 'patato',
                                        price: '\$10',

                                        rating: '3.5 Rating'
                                    ),
                                    bottomCard(
                                        image: "sandwish",
                                        name: 'sandwish',
                                        price: '\$25',

                                        rating: '1.5 Rating'
                                    ),
                                    bottomCard(
                                        image: "salad",
                                        name: 'salad',
                                        price: '\$4',

                                        rating: '2 Rating'
                                    ),
                                  ]),
                            ))],
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                      backgroundImage: AssetImage('images/man.jpg'),
                    ),
                      accountName: Text('Name'),
                      accountEmail: Text('Email'),),
                  ListTile(
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Profile()));
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
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Login()));
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
