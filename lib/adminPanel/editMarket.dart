
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/model/market.dart';
import 'package:feedme/widget/productTextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditMarket extends StatefulWidget {
 Market market ;
 EditMarket({this.market});

  @override
  _EditMarketState createState() => _EditMarketState();
}

class _EditMarketState extends State<EditMarket> {

  TextEditingController marketNameController = TextEditingController();
  TextEditingController marketLessPriceController = TextEditingController();
  TextEditingController marketDescriptionController = TextEditingController();
  TextEditingController marketTimeController = TextEditingController();


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  String postId = Uuid().v4();
  final picker = ImagePicker();
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Product products=ModalRoute.of(context).settings.arguments;
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
                  textTitle: 'Market Price',textType: TextInputType.number,
                  textHint: 'Enter Market Price',
                  controller: marketLessPriceController),
              SizedBox(
                height: 10.0,
              ),

              productTextField(
                  textTitle: 'Market Description',
                  textHint: 'Enter Market Description',
                  controller: marketDescriptionController),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                  textTitle: 'Market time',
                  textHint: 'Enter Market time',
                  controller: marketTimeController,
                  textType: TextInputType.number),

              SizedBox(height: 20,),
              RaisedButton(
                color: Color(0xFFebb775),
                onPressed: () async{
                  // if (_globalKey.currentState.validate()) {
                  // _globalKey.currentState.save();
                  if(_image==null){
                    showSnackBar('Market Image can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(marketNameController.text==''){
                    showSnackBar('Market Title can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(marketLessPriceController.text==''){
                    showSnackBar('Market Price can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(marketDescriptionController.text==''){
                    showSnackBar('Market Description can\'t be empty', scaffoldKey);
                    return;
                  }
                  if(marketTimeController.text==''){
                    showSnackBar('Market time can\'t be empty', scaffoldKey);
                    return;
                  }


                  firestore.collection('MarketName').doc(postId).update(
                      {
                        'marketLogo': _image,
                        'marketName': marketNameController.text,
                        'marketLessPrice': marketLessPriceController.text,
                        'marketDescription': marketDescriptionController.text,
                        'marketTime': marketTimeController.text,

                      });



                },
                child: Text('Update market'),),

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
    marketLessPriceController.text='';
    marketDescriptionController.text='';
    marketTimeController.text='';

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
