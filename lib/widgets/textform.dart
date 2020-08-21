import 'package:fastfood/const/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool passTrue;
  final bool readOnly;
  final Function onTap;
  final Function onChanged;
  final Function onSubmited;
  String varValue;

  TextForm({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.inputType,
    @required this.passTrue,
    @required this.varValue,
    @required this.readOnly,
    this.onTap,
    this.onChanged,
    this.onSubmited,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            onChanged: onChanged,
            onFieldSubmitted: onSubmited,
            controller: controller,
            cursorColor: Color(accentColor),
            cursorWidth: 3.5,
            keyboardType: inputType,
            obscureText: passTrue,
            style: TextStyle(fontFamily: "FontBold"),
            decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(fontFamily: "FontBold"),
              fillColor: Color(textBackColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(primaryColor), width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 1.5),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo Obrigatório*';
              }
            },
            onSaved: (value) => varValue = value,
          )
        ],
      ),
    );
  }
}
