import 'package:flutter/material.dart';

MaterialButton menuMaterialButton(String title, bool isActive, VoidCallback callback,
    {Color color: Colors.teal, Color textColor: Colors.white, double radiusCircular : 30}) {
  return MaterialButton(
    highlightElevation: 0,
    onPressed: callback,
    textColor: textColor,
    color: isActive ? color : Colors.grey,
    child: SizedBox(
      child: Text(title),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radiusCircular))),
  );
}

OutlinedButton menuOutlinedButton(String title, VoidCallback callback,
    {Color textColor: Colors.black87}) {
  return OutlinedButton(
    onPressed: callback,
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.teal.shade100),
      //splashFactory: NoSplash.splashFactory,
      //foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      //MaterialStateProperty.all(color),
      shape:
      MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      // MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
      //   //if (states.contains(MaterialState.pressed)) {}
      //   return
      //     RoundedRectangleBorder(
      //       side: BorderSide(
      //       color: Colors.white, width: 3),
      //       borderRadius: BorderRadius.circular(20));
      // }),
    ),
    child: Text(title, style: TextStyle(color: textColor, fontSize: 12), strutStyle: StrutStyle()),
  );
}


FloatingActionButton menuFloatingButton(Icon icon, bool isActive, VoidCallback callback,
    {Color color : Colors.teal}) {
  return FloatingActionButton(
    highlightElevation: 0,
    splashColor: color,
    onPressed: callback,
    child: icon,
    foregroundColor: Colors.white,
    elevation: 0,
    backgroundColor: isActive ? color : Colors.grey,
  );
}
