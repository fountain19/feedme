import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  TopTitle({this.subTitle,this.title});
  @override
  Widget build(BuildContext context) {
    return
        Container(
        height: 100,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Color(0xff193044),
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Color(0xff193044),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
    );
  }
}
