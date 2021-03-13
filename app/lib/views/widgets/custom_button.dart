import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key,
      @required this.lable,
      @required this.onPress,
      @required this.color,
      @required this.radius})
      : super(key: key);

  final String lable;
  final Function onPress;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline2;
    return MaterialButton(
        color: color,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Center(
          child: Text(lable,
              style: headingStyle.copyWith(
                color: Colors.white,
              )),
        ),
        onPressed: onPress);
  }
}
