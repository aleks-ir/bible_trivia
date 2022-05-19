import 'package:flutter/material.dart';
import 'package:weekly_bible_trivia/global/constants.dart';
import 'package:weekly_bible_trivia/widgets/progress_indicators.dart';

class AppTextButton extends StatelessWidget {
  final Function() callback;
  final String title;
  final bool isLoading;
  final double radius;
  final Color? textColor;
  final Color? backgroundColor;

  const AppTextButton(
      {required this.callback,
        this.title = '',
        this.isLoading = false,
        this.radius = 10,
        this.textColor,
        this.backgroundColor,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)))),
        onPressed: callback,
        child: isLoading
            ? circularButtonProgressIndicator(color: textColor, size: 20)
            : Text(
          title,
          style: TextStyle(
              fontSize: 13, fontFamily: INTER, color: textColor),
        ));
  }
}



class MenuFloatingButton extends StatelessWidget {
  final Function() callback;
  final Widget child;
  final bool isActive;
  final Color? color;
  final Color? foregroundNoActiveColor;
  final Color? activeColor;

  const MenuFloatingButton({
    required this.callback,
    required this.child,
    this.isActive = false,
    this.color,
    this.foregroundNoActiveColor,
    this.activeColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      onPressed: callback,
      child: child,
      foregroundColor: isActive ? Colors.white : foregroundNoActiveColor,
      elevation: 0,
      highlightElevation: 0,
      backgroundColor: isActive ? activeColor : color,
    );
  }
}


FloatingActionButton menuFloatingButton(
    Icon icon, bool isActive, VoidCallback callback,
    {Color backgroundColor = Colors.white, Color activeColor = Colors.teal}) {
  return FloatingActionButton(
    highlightElevation: 2,
    onPressed: callback,
    child: icon,
    foregroundColor: Colors.white,
    elevation: 0,
    backgroundColor: isActive ? activeColor : backgroundColor,
  );
}

MaterialButton authMaterialButton(Widget childWidget, VoidCallback callback,
    {Color color = Colors.teal,
    Color textColor = Colors.white,
    splashColor = Colors.black12}) {
  return MaterialButton(
    onPressed: callback,
    textColor: textColor,
    color: color,
    child: SizedBox(
      child: childWidget,
    ),
    splashColor: splashColor,
    height: 45,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
  );
}

OutlinedButton authOutlinedButton(String title, VoidCallback callback,
    {Color color = Colors.teal,
    Color textColor = Colors.white,
    splashColor = Colors.black12}) {
  return OutlinedButton(
    onPressed: callback,
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      side: MaterialStateProperty.all(BorderSide(color: color, width: 2)),
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

Widget readerFloatingActionButton(Widget icon, VoidCallback? callback,
    {Color color = Colors.white}) {
  return FloatingActionButton.small(
    elevation: 10,
    backgroundColor: color,
    child: icon,
    onPressed: callback,
    heroTag: null,
  );
}

class TriviaButton extends StatelessWidget {


  final VoidCallback callback;
  final String title;
  final bool isLeft;
  final Color? color;
  final Color? textColor;

  const TriviaButton({
    required this.callback,
    this.title = '',
    required this.isLeft,
    this.color,
    this.textColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.topCenter,
      child: Card(
        color: color,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isLeft ? 10 : 30),
              bottomRight: Radius.circular(isLeft ? 30 : 10)),
        ),
        child: InkWell(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isLeft ? 10 : 30),
                bottomRight: Radius.circular(isLeft ? 30 : 10)),
            onTap: callback,
            child: Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )),
      ),
    );
  }
}
