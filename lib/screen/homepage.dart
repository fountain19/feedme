
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
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
                              , onPressed:(){}),
                              IconButton(
                                  icon:Icon(Icons.notifications,size: 40,color: Colors.white,)
                                  , onPressed:(){}),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                  child: Container(
                    color: Theme.of(context).accentColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
// IconButton(icon: Icon(Icons.exit_to_app),
// onPressed: ()async{
// await FirebaseAuth.instance.signOut();
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Login()));})