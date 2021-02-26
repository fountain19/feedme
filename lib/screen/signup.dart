import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:feedme/screen/login.dart';
import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/endTitle.dart';
import 'package:feedme/widget/gender.dart';
import 'package:feedme/widget/passwordTextFd.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:feedme/widget/toptitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

 bool isLOading =false;
 bool isMale=true;

 UserCredential authResult;

 void submit()async{
   setState(() {
     isLOading=true;
   });
   try{
authResult = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: _email.text, password: _password.text);
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
  'userId':authResult.user.uid,
  'userName':_name.text,
  'userEmail':_email.text.trim(),
  'userNumber':_number.text,
  'userAddress':_address.text,
  'userGender':isMale==true?'Male':'Female',
});
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
   setState(() {
     isLOading=false;
   });
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
      resizeToAvoidBottomInset: false,
      key: scaffold,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopTitle(
                  title: 'Sign up',
                  subTitle:'Create an account' ,),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Container(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isMale = !isMale;
                              });
                            },
                            child: Container(
                              height:30.0,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isMale==false?'Female':'Male',style: TextStyle(
                                  fontSize: 16.0,color:Colors.black
                              ),
                                //   ),decoration: BoxDecoration(
                                //   color: Colors.white,
                                //   borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                          ),
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
      ),
    );
  }
}
