
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/product.dart';
import 'package:feedme/widget/productTextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  Product product ;
  EditProduct({this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  TextEditingController marketNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  String postId = Uuid().v4();
  final picker = ImagePicker();
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

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

      body: ListView(
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              productImage(),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Market Name',
                  textHint: 'Enter Market Name',
                  controller: marketNameController),

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
                  textTitle: 'Product name',
                  textHint: 'Enter Product name',
                  controller: productNameController),

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
                  if(marketNameController.text==''){
                    showSnackBar('Market Title can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productPriceController.text==''){
                    showSnackBar('product Price can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(productNameController.text==''){
                    showSnackBar('product Name can\'t be empty', scaffoldKey);
                    return;
                  }


                  firestore.collection('Products').doc(postId).update(
                      {
                        'productImage':_image,
                        'marketName': marketNameController.text,
                        'productPrice': productPriceController.text,
                        'productName': productNameController.text,

                      }
                  );



                },
                child: Text('Update product'),),

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
  void resetEverything() {
    _image=null;
    marketNameController.text ='';
    productPriceController.text='';
    productNameController.text='';

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
