import 'package:flutter/material.dart';

class PasswordTextFd extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  PasswordTextFd({this.controller,this.title});

  @override
  _PasswordTextFdState createState() => _PasswordTextFdState();
}

class _PasswordTextFdState extends State<PasswordTextFd> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.blueGrey,
            filled: true,
            hintStyle: TextStyle(color: Colors.white),
            hintText: widget.title,

            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  obscureText = !obscureText;
                });
              },
                child:obscureText==true? Icon(Icons.visibility,color: Colors.white,)
                    :Icon(Icons.visibility_off,color: Colors.white,)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
