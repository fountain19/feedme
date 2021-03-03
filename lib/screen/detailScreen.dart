import 'package:feedme/widget/button.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
              return HomePage();
            }), (route) => false);
          },
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage:  AssetImage('images/pizza.jpg'),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).accentColor,
                ),
                Container(
                  color: Theme.of(context).accentColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pizza',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                      ),
           SizedBox(height: 15,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('\$${50}',style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 25,
               )),
               Container(
                 decoration: BoxDecoration(
                     color: Color(0xff193044),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 height: 35,width: 120,

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     IconButton(icon: Icon(Icons.add,color: Colors.white,), onPressed: (){}),
                     Text('1',style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,

                     )),
                     IconButton(icon: Icon(Icons.remove,color: Colors.white,), onPressed: (){}),
                   ],
                 ),
               )
             ],
           ),
                      SizedBox(height: 15,),
                      Text('Weight',style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      )),
                      Text('120kg',style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                      SizedBox(height: 15,),
                      Text('Calories',style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      )),
                      Text('430 ccal',style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                      SizedBox(height: 15,),
                      Text('components',style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      )),
                      Container(
                        child: Text('Tomato, capsicum, cheese, flour, sausage',style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Button(
                  title: 'Submit',
                  onPressed: (){},
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}
