import 'package:feedme/screen/homepage.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
          onTap: (){
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
             return HomePage();
           }), (route) => false);
          },
        ),
        backgroundColor:Color(0xff193044),
        elevation: 0.0,
      ),
    body: Container(
        color: Theme.of(context).accentColor,
      child:Column(
       children: [
         Material(

          color:Color(0xff193044),
           child: Container(
             width: double.infinity,
             height: 200,
             child: Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Text('About us',style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 40,

               ),),
             ),
           ),
         ),
         Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
           child: Text(''
               "This simple technology in its idea facilitated the lives of many after the menus became available in minutes with the possibility of registering the order from them by simply pressing a button, waiting for a short period, and then following the path of the driver from leaving the restaurant until he arrived at the customer's home on an electronic application.",style: TextStyle(
             color: Colors.white,
             fontSize: 25,

           ),),
         ),
       ],
      )
    ),
    );
  }
}
