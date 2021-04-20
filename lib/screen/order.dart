import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          leading: IconButton(

            icon:Icon(Icons.keyboard_backspace),color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },

          ),
          title: Text(
            'Order Screen',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff193044),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Container(
                height: height*.5,
                width: width * .5,
                child: Image.asset('images/icon/cart.png'),
              ),
              Text('Your cart is empty ',style: TextStyle(
                  color: Colors.white,
                      fontWeight: FontWeight.bold,
                fontSize: 25
              )),
              SizedBox(
                height: height*0.025,
              ),
              Text('Please add some items from the menu ',style: TextStyle(color: Colors.white)),
            ],
          ),
        )));
  }
}
