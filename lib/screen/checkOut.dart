import 'package:feedme/widget/button.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget listTile({String image,String number,String name,String address,String price}){
      return  Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
      ,color:  Color(0xff193044),
      ),
      height: 100,
       child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('images/$image.jpg'),
        ),
        title: Row(
          children: [
            Text('$number',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,

            ),),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text('$name',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),),
                ),
                Container(
                  child: Text('$address',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),),
                )
              ],
            )
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 15,bottom: 15),
          child: Container(
            child: Text('\$$price',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,

      )))),));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: Container(
        height: 160,
        child:Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Total price',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,

                  ),
                  ),
                  Text(
                      '\$50',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,

                  ),
                  ),

                ],
              ),
            ),
            Button(
              title: 'Order',
              onPressed: (){},
            )
          ],
        )
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Check out',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        ),
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
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    height: double.infinity,
    width: double.infinity ,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

             listTile(image: 'pizza',
             name: 'Pizza',
             address: 'New york',
             number: 'x1',
             price: '50')
        ,SizedBox(
        height: 15,
    ),
             listTile(image: 'burgur',
               name: 'Burgur',
               address: 'London',
               number: 'x5',
             price: '25')


        ],
      ),
    ),
  ),
    );
  }
}
