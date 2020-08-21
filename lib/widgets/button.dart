import 'package:fastfood/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/const/fonts.dart';

class ButtonPrimary extends StatelessWidget {
  final String label;
  final double minWidth;
  final Function function;

  const ButtonPrimary({Key key, this.label, this.minWidth, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: function, //since this is only a UI app
      child: Text(
        label,
        style: styleButton,
      ),
      color: Color(accentColor),
      highlightColor: Color(primaryColor).withOpacity(0.4),
      splashColor: Colors.transparent,
      disabledElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      minWidth: minWidth,
      height: 50,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
