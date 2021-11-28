import 'package:flutter/material.dart';

Card circularCard({String title : "", double size : 160}) {
  return Card(
    child: Container(
      height: size,
      width: size,
      child: Center(
        child: ListTile(
          title: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white)),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.lightGreenAccent,
            ],
          )),
    ),
    elevation: 6,
    shadowColor: Colors.green,

    color: Colors.white,
    //margin: EdgeInsets.all(20),
    shape: CircleBorder(
      //side: BorderSide(width: 1, color: Colors.),
    ),
  );
}
