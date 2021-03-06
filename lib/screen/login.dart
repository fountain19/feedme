
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/adminPanel/adminHome.dart';


import 'package:feedme/screen/signup.dart';
import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/endTitle.dart';
import 'package:feedme/widget/passwordTextFd.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:feedme/widget/toptitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'homepage.dart';

class Login extends StatefulWidget {
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp regExp = new RegExp(p);


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  final admin = 'admin@gmail.com';
  bool isLOading =false;
  bool isMale=true;

  UserCredential authResult;





  void submit()async{
    setState(() {
      isLOading=true;
    });
    if(_email.text!=admin)
    {


    try{
      authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _password.text);
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
    final  SharedPreferences localStorage=await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('userData').doc(authResult.user.uid).get().then((dataSnapShot) async{

      await localStorage.setString('userImage', dataSnapShot['userImage']);
      await localStorage.setString('userNumber', dataSnapShot['userNumber']);
      await localStorage.setString('userAddress', dataSnapShot['userAddress']);
      await localStorage.setString('userName', dataSnapShot['userName']);
      await localStorage.setString('userEmail', dataSnapShot['userEmail']);
      await localStorage.setString('userId', dataSnapShot['userId']);
      await localStorage.setString('userGender', dataSnapShot['userGender']);
    }
    );


    setState(() {
      isLOading=false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
    }else{

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>AdminHome()));
    }
  }





    Future<UserCredential> signInWithFacebook() async {
      final SharedPreferences localStorage = await SharedPreferences
          .getInstance();


      final LoginResult result = await FacebookAuth.instance.login(
        permissions:['public_profile','email',],
      );

        final userData= await FacebookAuth.instance.getUserData();
        // Create a credential from the access token
        final OAuthCredential credential = FacebookAuthProvider.credential(
            result.accessToken.token);
        // Once signed in, return the UserCredential;
        final authResult = await FirebaseAuth.instance.signInWithCredential(
            credential);

        setState(() {
          _userData=userData;
        });

      //   print('userData${_userData['email']}');
      // print('userData${_userData['id']}');
      // print('userData${_userData['name']}');
      // print('userData${_userData['picture']}');


      if (authResult != null) {
          FirebaseFirestore.instance.collection('userData').doc(
              authResult.user.uid).set({
            'userImage': authResult.user.photoURL,
            'userId': authResult.user.uid,
            'userName': authResult.user.displayName,
            'userEmail': authResult.user.email,
            'userNumber': '',
            'userAddress': '',

          });
          await localStorage.setString('userImage', authResult.user.photoURL);
          await localStorage.setString('userNumber', '');
          await localStorage.setString('userAddress', '');
          await localStorage.setString('userEmail', authResult.user.email);
          await localStorage.setString('userName', authResult.user.displayName);
          await localStorage.setString('userId', authResult.user.uid);
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));

    }

  Future<UserCredential> signInWithGoogle() async {
    final  SharedPreferences localStorage=await SharedPreferences.getInstance();
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

   final authResult=await FirebaseAuth.instance.signInWithCredential(credential);
   if(authResult!=null){
        FirebaseFirestore.instance.collection('userData').doc(authResult.user.uid).set({
       'userImage':authResult.user.photoURL,
       'userId':authResult.user.uid,
       'userName':authResult.user.displayName,
       'userEmail':authResult.user.email,
       'userNumber':'',
       'userAddress':'',

     });
     await  localStorage.setString('userImage', '');
     await  localStorage.setString('userNumber', '');
     await  localStorage.setString('userAddress', '');
     await  localStorage.setString('userEmail',authResult.user.email);
     await localStorage.setString('userName', authResult.user.displayName);
     await localStorage.setString('userId', authResult.user.uid);
   }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
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
                            controller:_email,),
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
                  SizedBox(height: 10,),
                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(color:Color(0xff193044),thickness: 2,)
                        ),

                        Text("OR",style: TextStyle(
                          fontSize: 25,fontWeight: FontWeight.bold
                        ),),
                        Expanded(
                            child: Divider(color:Color(0xff193044),thickness: 2,)
                        ),
                      ]
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                      signInWithGoogle();

                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/icon/google.png'),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          signInWithFacebook();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/icon/face.png'),
                        ),
                      ),
                    ],
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
