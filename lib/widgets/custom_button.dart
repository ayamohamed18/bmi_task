import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
   CustomButon({ this.onTap ,required this.text}) ;
VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}