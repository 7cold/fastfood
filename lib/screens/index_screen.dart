import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/screens/home_screen.dart';
import 'package:fastfood/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return model.isLoggedIn() == true ? HomeScreen() : LoginScreen();
      },
    );
  }
}
