import 'package:flutter/material.dart';

class TextFormFd extends StatelessWidget {
  final TextInputType input;
  final String title;
  final TextEditingController controller;
  TextFormFd({this.controller,this.title, this.input,});
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      cursorColor: Colors.white,
style: TextStyle(color: Colors.white),
      keyboardType: input,
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.blueGrey,
          filled: true,
          hintText: title,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );
  }
}
