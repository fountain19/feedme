import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/adminPanel/adminHome.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:feedme/widget/productTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' ;







class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {


  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productWeightController = TextEditingController();
  TextEditingController productCaloriesController = TextEditingController();
  TextEditingController productComponentsController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  final picker = ImagePicker();

// this verbal for give id user post
  String postId = Uuid().v4();


  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF2c425e),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton.icon(
              onPressed: () {
                pickImage();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                'Add Image',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xFFfcbb6c),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF2c425e),
      body:
      ListView(
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              productImage(),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Product Name',
                  textHint: 'Enter Product Name',
                  controller: productNameController),

              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Product Price',textType: TextInputType.number,
                  textHint: 'Enter Product Price',
                  controller: productPriceController),
              SizedBox(
                height: 10.0,
              ),

              productTextField(
                  textTitle: 'Product Description',
                  textHint: 'Enter Product Description',
                  controller: productDescriptionController),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Product weight',
                  textHint: 'Enter Product weight',
                  controller: productWeightController,
              textType: TextInputType.number),
              SizedBox(
                height: 10.0,
              ),

              productTextField(
                  textTitle: 'Product Calories',
                  textHint: 'Enter Product Calories',
                  controller: productCaloriesController,
                  textType: TextInputType.number),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Product Components',
                  textHint: 'Enter Product Components',
                  controller: productComponentsController,
                  textType: TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Color(0xFFebb775),
                onPressed: () async{
                  // if (_globalKey.currentState.validate()) {
                  // _globalKey.currentState.save();
                  if(_image==null){
                    showSnackBar('Product Image can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productNameController.text==''){
                    showSnackBar('Product Title can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productPriceController.text==''){
                    showSnackBar('product Price can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productDescriptionController.text==''){
                    showSnackBar('product Description can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productWeightController.text==''){
                    showSnackBar('product Weight can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productCaloriesController.text==''){
                    showSnackBar('product Calories can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productComponentsController.text==''){
                    showSnackBar('product Components can\'t be empty', scaffoldKey);
                    return;
                  }


                    displayProgressDialog(context);
                  uploadImageUrlAndSaveToFireStore();


                },
                child: Text('Add Product'),),

            ],
          ),
        ],
      ),
    );
  }

  Future pickImage() async {


    var pickedFile =await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);

    });
  }

  Widget productImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: _image == null
          ? Container()
          : SizedBox(
        height: 150.0,
        child: Stack(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(100),
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_image)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundColor: Colors.red[600],
                        child: IconButton(
                          color: Colors.red,
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ), onPressed: () {
                          removeImage();
                        },
                        ),
                      ),
                    ),
                  ],
                ),
    )
            );

  }

  removeImage() async {
   setState(() {
     _image=null;
   });
  }





// this method for starting upload photo to storage fire base
 void uploadImageUrlAndSaveToFireStore() async {
   final Reference productRef = FirebaseStorage.instance
       .ref()
       .child('Product images').child(postId);
 final UploadTask uploadTask = productRef.putFile(_image);
 uploadTask.then((TaskSnapshot task) {
   task.ref.getDownloadURL().then((_image){
     return saveDataToFireStore(_image);
   } );
 }).catchError((error){

     closeProgressDialog(context);

   showSnackBar('Error is : ${error.toString()}', scaffoldKey);
 });
  }


  void saveDataToFireStore(String image){
    FirebaseFirestore.instance.collection('product info').doc(postId).set(
      {
        'productImage':image,
        'productName': productNameController.text,
        'productPrice': productPriceController.text,
        'productDescription': productDescriptionController.text,
        'productWeight': productWeightController.text,
        'productCalories': productCaloriesController.text,
        'productComponents': productComponentsController.text,
      }
    ).whenComplete((){

       closeProgressDialog(context);
       showSnackBar('Product added successfully', scaffoldKey);
      resetEverything();
       Navigator.push(context, MaterialPageRoute(builder: (context){
         return AdminHome();
       }));
    }).catchError((error){

        closeProgressDialog(context);
        showSnackBar('Error is : ${error.toString()}', scaffoldKey);

    });
  }


  void resetEverything() {
    _image=null;
    productNameController.text ='';
    productPriceController.text='';
    productDescriptionController.text='';
    productWeightController.text='';
    productCaloriesController.text='';
    productComponentsController.text='';
    setState(() {
    });
  }
  showSnackBar(String message, final scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }
  displayProgressDialog(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Material(
        color: Colors.black.withAlpha(200),
        child: Center(child: Container(
          padding: EdgeInsets.all(30),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 15,),
                Text('Please Wait',style: TextStyle(color: Colors.white),),
              ],
            )),
          ),
        )),
      );
    }));
  }
  closeProgressDialog(BuildContext context) {
    Navigator.pop(context);
  }

}