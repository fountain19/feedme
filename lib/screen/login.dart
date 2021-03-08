import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/screen/signup.dart';
import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/endTitle.dart';
import 'package:feedme/widget/passwordTextFd.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:feedme/widget/toptitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp regExp = new RegExp(p);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  bool isLOading =false;
  bool isMale=true;

  UserCredential authResult;

  void submit()async{
    setState(() {
      isLOading=true;
    });
    try{
      authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
    }on PlatformException catch(e){
      String message ='Please check internet';
      if(e.message != null)
      {
        message = e.message.toString();
      }
      scaffold.currentState.showSnackBar(SnackBar(content: Text(message)));
      setState(() {
        isLOading=false;
      });
    }catch(e){
      setState(() {
        isLOading=false;
      });
      scaffold.currentState.showSnackBar(SnackBar(content: Text(e.toString())));
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
    setState(() {
      isLOading=false;
    });
  }

  void vaildation() {
    if (_email.text.isEmpty && _password.text.isEmpty) {
      scaffold.currentState.showSnackBar(
          SnackBar(content: Text("Please fill in the empty fields ")));
    } else if (_email.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email is empty")));
    } else if (!Login.regExp.hasMatch(_email.text)){
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email is not valid")));
    }
    else if (_password.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email is empty")));
    } else if (_password.text.length < 5) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Password is too short")));
    }else{
      submit();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopTitle(
                    title: 'Login',
                    subTitle:'Welcome back!' ,),
                  Center(
                    child: Container(
                      height: 300,
                      width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormFd(
                            title:'Email',
                            controller:_email ,),
                          SizedBox(
                            height: 15,
                          ),
                          PasswordTextFd(
                            title:'Password',
                            controller:_password ,),
                        ],
                      ),
                    ),
                  ),
                 isLOading==false? Button(
                    title:'Login' ,
                    onPressed: () {
                      vaildation();
                    },):Center(
                   child: CircularProgressIndicator(),
                 ),

                  SizedBox(
                    height: 15,
                  ),
                  EndTitle(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return SignUp();
                      }));
                    },
                    title: "Don't have an account?",
                    subTitle:  "Sign up",
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
