import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'homepage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userId = Uuid().v4();



  User user;
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _address = TextEditingController();

  String name = '';
  String number = '';
  String address = '';
  String email ;
  String id ;
  String gender ;
  String image;



  bool isLoading=false;

  File _image;
  final picker = ImagePicker();

  void readData() async
  {
    final SharedPreferences  localStorage = await SharedPreferences.getInstance();
    number = localStorage.getString('userNumber');
    address= localStorage.getString('userAddress');
    name = localStorage.getString('userName');
    email=localStorage.getString('userEmail');
    id=localStorage.getString('userId');
    gender=localStorage.getString('userGender');
    image=localStorage.getString('userImage');

    _name = TextEditingController(text: name);
    _number = TextEditingController(text: number);
    _address = TextEditingController(text: address);

    setState(() {

    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

      }

      else {
        print('No image selected.');

      }
    uploadImageToFireStoreAndAndStorage();
    }

    );
  }

  Future uploadImageToFireStoreAndAndStorage() async {
    final SharedPreferences  localStorage = await SharedPreferences.getInstance();
    final Reference productRef = FirebaseStorage.instance
        .ref()
        .child('Users images').child(id);
    final UploadTask uploadTask = productRef.putFile(_image);
    uploadTask.then((TaskSnapshot task) {
      task.ref.getDownloadURL().then((_image){


      FirebaseFirestore.instance.collection('userData').doc(id).update({
        'userImage':_image,
        'userId':id,
        'userName':name,
        'userEmail':email,
        'userNumber':number,
        'userAddress':address,
        'userGender':gender,
          }).then((data) async {
            await localStorage.setString('userImage', _image);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: ' The image updated Successfully');
          });
        }, onError: (errorMsg) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'Error ocurred in getting  Download Url');
        });

    }, onError: (errorMsg) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: errorMsg.toString());
    });
  }



  @override
  void initState() {
    super.initState();
    readData();
  }


  @override
  Widget build(BuildContext context) {


    final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();



    void vaildation() {
      setState(() {
        isLoading=true;
      });
      if (_name.text.isEmpty&&_number.text.isEmpty&&_address.text.isEmpty) {
        setState(() {
          isLoading=false;
        });
        scaffold.currentState.showSnackBar(
            SnackBar(content: Text("Please fill in the empty fields ")));
      }else if (_name.text.isEmpty) {
        setState(() {
          isLoading=false;
        });
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text("Name is empty")));
      }

      else if (_number.text.isEmpty) {
        setState(() {
          isLoading=false;
        });
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text("Phone number is empty")));
      }
      else if (_address.text.isEmpty) {
        setState(() {
          isLoading=false;
        });
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text("Address is empty")));
      }
    }



    return Scaffold(
      key: scaffold,
      backgroundColor:  Theme.of(context).accentColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile page',style: TextStyle(
            color: Colors.white,fontSize: 20
        ),
        ),
        leading: GestureDetector(
          child: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
          onTap: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
              return HomePage();
            }), (route) => false);
          },
        ),
        backgroundColor:Color(0xff193044),
        elevation: 0.0,
      ),
      body:
      Container(
height: double.infinity,width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    color: Color(0xff193044),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 80),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                              _image==null?(image != '' && image!=null )?
                              NetworkImage(image):
                              AssetImage('images/icon/person.png'):FileImage(_image)
                            ),
                          ),
                          Positioned(
                            right: 0.0,bottom: 0.0,
                            child: GestureDetector(
                              onTap: (){
                                getImage();
                              },
                              child: CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.edit),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
             isLoading==false? Button(
                onPressed: (){
                  vaildation();
                   updateData();
                },
                title: 'Update'
              ):CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
  void updateData()async{
setState(() {
  isLoading=true;
});
    final SharedPreferences  localStorage = await SharedPreferences.getInstance();
if(_name.text ==  localStorage.getString('userName')
    &&_address.text==localStorage.getString('userAddress')&&
_number.text==localStorage.getString('userNumber')
  ){
  setState(() {
    isLoading=false;
  });
  Fluttertoast.showToast(msg: 'The data has been updated previously');
}else {


  FirebaseFirestore.instance.collection('userData').doc(id).update({
     // 'userImage':image==''?'':_image,
    'userName':_name.text.trim(),
    'userNumber':_number.text.trim(),
    'userAddress':_address.text.trim(),
    'userEmail':email,
    'userId':id,
    'userGender':gender
  });
  await  localStorage.setString('userNumber', _number.text);
  await  localStorage.setString('userAddress', _address.text);
  await localStorage.setString('userName', _name.text);
  await localStorage.setString('userImage', image);

  Fluttertoast.showToast(msg: 'The data updated',toastLength: Toast.LENGTH_LONG);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
  setState(() {
    isLoading=false;
  });
}
  }
}
