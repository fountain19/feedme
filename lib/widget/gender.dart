import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gender extends StatefulWidget {
  final bool isMale;
  final Function onTap;
  Gender({this.onTap,this.isMale});
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height:30.0,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10.0),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.isMale==false?'Female':'Male',style: TextStyle(
          fontSize: 16.0,color:Colors.black
        ),
      //   ),decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10.0)
       ),
      ),
    );
  }
}
