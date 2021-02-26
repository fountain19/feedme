import 'package:flutter/material.dart';

class EndTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;
  EndTitle({this.title,this.subTitle,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
           subTitle ,
            style: TextStyle(color: Color(0xFFfcc319), fontSize: 20),
          ),
        ),
      ],
    );
  }
}
