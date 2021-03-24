import 'package:feedme/adminPanel/addProduct.dart';
import 'package:feedme/adminPanel/manageProduct.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:flutter/material.dart';



class AdminHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Color(0xFF2c425e),
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                SizedBox(height: width*0.3,),
               SizedBox(width: width),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddProduct();
                    }));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 75,
                    child: Text('Add product',style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
            SizedBox(height: 15,),
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
    );
  }
}
