import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpGoogleScreen extends StatefulWidget {
  @override
  _SignUpGoogleScreenState createState() => _SignUpGoogleScreenState();
}

class _SignUpGoogleScreenState extends State<SignUpGoogleScreen> {
  TextEditingController _controllerEndereco = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, null, false, false, false),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 20),
                  child: Text(
                    "Complete seu Login",
                    style: tituloText,
                  ),
                ),
                TextForm(
                    readOnly: false,
                    controller: _controllerEndereco,
                    hintText: "endereco",
                    inputType: TextInputType.text,
                    passTrue: false,
                    varValue: null),
                Divider(),
                SizedBox(height: 20),
                Center(
                  child: CupertinoButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      UserModel().signUpGoogle(
                          firebaseUID: model.firebaseUser.uid,
                          userData: {
                            'email': model.firebaseUser.email,
                            'nome': model.firebaseUser.displayName,
                            'endereco': _controllerEndereco.text
                          },
                          onSucess: () {
                            print("suc");
                          },
                          onFail: () {
                            print("fail");
                          });
                    },
                    color: Color(accentColor),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
