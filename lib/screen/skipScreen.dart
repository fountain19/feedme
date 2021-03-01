import 'package:carousel_pro/carousel_pro.dart';
import 'package:feedme/screen/login.dart';
import 'package:flutter/material.dart';

class SkipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Carousel(
              animationDuration: Duration(seconds: 2),
              autoplay: true,
              boxFit: BoxFit.cover,
              dotBgColor: Colors.black,
              dotSize: 10,
              images: [
                AssetImage('images/et.jpg'),
                AssetImage('images/izgara.jpg'),
                AssetImage('images/kofte.jpg'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
                    return Login();
                  }), (route) => false);
                },
                child: Text('Skip',style: TextStyle(
                  color: Colors.white,fontSize: 20
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
