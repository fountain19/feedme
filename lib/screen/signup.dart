

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/adminPanel/adminHome.dart';


import 'package:feedme/screen/homepage.dart';
import 'package:feedme/screen/login.dart';
import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/endTitle.dart';

import 'package:feedme/widget/passwordTextFd.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:feedme/widget/toptitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class SignUp extends StatefulWidget {

  
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp regExp = new RegExp(p);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _number = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  String userId = Uuid().v4();

 bool isLOading =false;
 bool isMale=true;

 UserCredential authResult;
  final admin = 'admin@gmail.com';



 void submit()async{

   setState(() {
     isLOading=true;
   });
   final  SharedPreferences localStorage=await SharedPreferences.getInstance();

   try{
authResult = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: _email.text.trim(), password: _password.text);

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
  FirebaseFirestore.instance.collection('userData').doc(authResult.user.uid).set({
    'userImage':'',
  'userId':authResult.user.uid,
  'userName':_name.text.trim(),
  'userEmail':_email.text,
  'userNumber':_number.text.trim(),
  'userAddress':_address.text.trim(),

});
   await  localStorage.setString('userImage', '');
   await  localStorage.setString('userNumber', _number.text);
   await  localStorage.setString('userAddress', _address.text);
   await  localStorage.setString('userEmail', _email.text);
   await localStorage.setString('userName', _name.text);
   await localStorage.setString('userId', authResult.user.uid);

   if(_email.text!=admin){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
     setState(() {
       isLOading=false;
     });
   }
   else{
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>AdminHome()));
     setState(() {
       isLOading=false;
     });
   }

 }

  void vaildation() {
    if (_email.text.isEmpty && _password.text.isEmpty&&_name.text.isEmpty&&_number.text.isEmpty&&_address.text.isEmpty) {
      scaffold.currentState.showSnackBar(
          SnackBar(content: Text("Please fill in the empty fields ")));
    }else if (_name.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Name is empty")));
    }
    else if (_email.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Email is empty")));
    }
    else if (_number.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Phone number is empty")));
    }
    else if (_address.text.isEmpty) {
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Address is empty")));
    } else if (!SignUp.regExp.hasMatch(_email.text)){
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
backgroundColor: Colors.white,
      key: scaffold,
      body:ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SafeArea(

              child: Column(

                children: [
                  TopTitle(
                    title: 'Sign up',
                    subTitle:'Create an account' ,),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        children: [

                              CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                backgroundImage: AssetImage('images/icon/person.png'),
                                radius: 75,
                              ),

                          SizedBox(
                            height: 15,
                          ),
                          TextFormFd(
                            title:'Full name',
                            controller:_name ,),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormFd(
                            title:'Email',
                            controller:_email ,),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormFd(
                            input: TextInputType.number,
                            title:'Phone number',
                            controller:_number ,),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormFd(
                            title:'Address',
                            controller:_address ,),
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
                  isLOading==false?Button(
                    title:'Sign up' ,
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
                        return Login();
                      }));
                    },
                    title: "I've already an account",
                    subTitle:  "Login",
                  ),
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}
