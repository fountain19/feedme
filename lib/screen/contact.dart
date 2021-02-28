import 'package:flutter/material.dart';

import 'homepage.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();
    final TextEditingController _userMessage = TextEditingController();
    final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

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
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,

      ),
      key: scaffold,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        color: Theme.of(context).accentColor,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Center(child: Text('We always like hearing from you',
                  style:TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold) ,)),
                SizedBox(height: 50,),
                TextField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  controller: _email,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ) ,
                    hintText: 'Enter you email',
                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.email,color: Colors.white,),


                  ),
                ),



                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(12),

                  child: TextField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    controller: _userMessage,
                    cursorColor: Colors.white,
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Enter your message',labelStyle: TextStyle(
                        color: Colors.white
                    ),

                    ),
                  ),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Builder(
                    builder: (context) => FlatButton(

                      child: Text('Send a message',style: TextStyle(
                          color: Colors.white
                      ),),
                    color: Colors.pinkAccent,
                      onPressed: (){
                        if(_email.text==''){
                          showSnackBar('Email can\'t be empty', scaffold);
                          return;
                        }
                        if(_userMessage.text==''){
                          showSnackBar('The message can\'t be empty', scaffold);
                          return;
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ],
        ),
      ),
    );

  }
  showSnackBar(String message, final scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }
}
