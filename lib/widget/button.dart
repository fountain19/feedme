

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  Button({this.title,this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 400,
      child: RaisedButton(
        onPressed: onPressed,
        color: Color(0xff193044),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
