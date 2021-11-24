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
    {Color color: const Color(0xfff063057), Color textColor: Colors.black87}) {
  return OutlinedButton(
    onPressed: callback,
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      foregroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
        }
      }),
    ),
    child: Text(title, style: TextStyle(color: textColor, fontSize: 10),),
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
