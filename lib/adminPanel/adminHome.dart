import 'package:feedme/adminPanel/addMarket.dart';
import 'package:feedme/adminPanel/addProduct.dart';
import 'package:feedme/adminPanel/manageMarket.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:flutter/material.dart';

import 'manageProduct.dart';



class AdminHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Color(0xFF2c425e),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(15),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  SizedBox(height: height*0.2,),

                  Row(
                    children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AddMarket();
                        }));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 75,
                        child: Text('Add Market',style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                      SizedBox(width: width*.05),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AddProduct();
                        }));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 75,
                        child: Text('Add Product',style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ],),

              SizedBox(height: 15,),
              Row(children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return MangeMarket();
                    }));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 75,
                    child: Text('Mange Market',style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
                SizedBox(width: width*.05),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return MangeProduct();
                    }));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 75,
                    child: Text('Mange Product',style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ],),


              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomePage();
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 75,
                  child: Text('Home page',style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold
                  ),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
