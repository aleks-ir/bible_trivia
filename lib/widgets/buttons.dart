import 'package:flutter/material.dart';

MaterialButton menuMaterialButton(
    String title, bool isActive, VoidCallback callback,
    {Color activeColor: Colors.teal,
    Color colorBackground: Colors.white30,
    double radiusCircular: 10}) {
  return MaterialButton(
    height: 40,
    highlightElevation: 0,
    onPressed: callback,
    color: isActive ? activeColor : colorBackground,
    child: SizedBox(
      child: Text(title, style: TextStyle(wordSpacing: 5, fontWeight: FontWeight.w400, letterSpacing: 1, color: isActive ? Colors.white : Colors.black, fontSize: 15),),
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
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    child: Text(title,
        style: TextStyle(color: textColor, fontSize: 12),
        strutStyle: StrutStyle()),
  );
}

FloatingActionButton menuFloatingButton(
    Icon icon, bool isActive, VoidCallback callback,
    {Color color: Colors.black26, Color activeColor: Colors.teal}) {
  return FloatingActionButton(
    highlightElevation: 0,
    splashColor: activeColor,
    onPressed: callback,
    child: icon,
    foregroundColor: Colors.white,
    elevation: 0,
    backgroundColor: isActive ? activeColor : color,
  );
}

Widget animatedHomeButton({
  required String title,
  double height: 100,
  double width: 100,
}) {
  return Container(
    height: width,
    width: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.greenAccent,
            Colors.teal,
          ],
        )),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}

MaterialButton authButton(Widget childWidget, VoidCallback callback,
    {Color color: Colors.teal, Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: callback,
    textColor: textColor,
    color: color,
    child: SizedBox(
      child: childWidget,
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
  );
}

Widget readerFloatingActionButton(
    Widget icon, Alignment alignment, VoidCallback callback,
    {Color color: Colors.white}) {
  return Align(
    alignment: alignment,
    child: Container(
      padding: EdgeInsets.only(
          left: alignment == Alignment.bottomLeft ? 0 : 30,
          right: alignment == Alignment.bottomRight ? 0 : 30,
          bottom: 80),
      height: 130,
      width: 130,
      child: FloatingActionButton(
        backgroundColor: color,
        child: icon,
        onPressed: callback,
        heroTag: null,
      ),
    ),
  );
}
