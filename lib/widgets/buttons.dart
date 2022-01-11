import 'package:flutter/material.dart';

MaterialButton menuMaterialButton(
    String title,
    Image image, bool isActive, VoidCallback callback,
    {Color activeColor = Colors.teal,
    Color colorBackground = Colors.white30,
    double radiusCircular = 30}) {
  return MaterialButton(
    highlightElevation: 0,
    onPressed: callback,
    color: isActive ? activeColor : colorBackground,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title, style: TextStyle(color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: image,
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radiusCircular))),
  );
}

OutlinedButton menuOutlinedButton(String title, VoidCallback callback,
    {Color textColor: Colors.black87, double fontSize: 12, double borderRadius: 5, double horizontalPadding: 0}) {
  return OutlinedButton(
    onPressed: callback,
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.grey.shade100),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(title,
          style: TextStyle(color: textColor, fontSize: fontSize),
          strutStyle: const StrutStyle()),
    ),
  );
}

FloatingActionButton menuFloatingButton(
    Icon icon, bool isActive, VoidCallback callback,
    {Color color: Colors.black26, Color activeColor: Colors.teal}) {
  return FloatingActionButton(
    heroTag: null,
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
  required Widget child,
  double height = 100,
  double width = 100,
  Color backgroundColor = Colors.white,
  Color shadowColor = Colors.black,
}) {
  return Container(
    height: width,
    width: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
        color: backgroundColor,
    ),
    child: Center(
      child: child,
    ),
  );
}

MaterialButton authMaterialButton(Widget childWidget, VoidCallback callback,
    {Color color = Colors.teal, Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: callback,
    textColor: textColor,
    color: color,
    child: SizedBox(
      child: childWidget,
    ),
    height: 45,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
  );
}

OutlinedButton authOutlinedButton(String title, VoidCallback callback,
    {Color color = Colors.teal, Color textColor = Colors.white}) {
  return OutlinedButton(
    onPressed: callback,
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(15)),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      side: MaterialStateProperty.all(const BorderSide(color: Colors.teal, width: 2)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
    child: Text(title,
        style: TextStyle(color: textColor, fontSize: 12),
        strutStyle: const StrutStyle()),
  );
}

Widget readerFloatingActionButton(
    Widget icon, Alignment alignment, VoidCallback? callback,
    {Color color = Colors.white}) {
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


