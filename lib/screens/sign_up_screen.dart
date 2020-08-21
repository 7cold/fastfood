import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _controllerEmail = TextEditingController();

  TextEditingController _controllerSenha = TextEditingController();

  TextEditingController _controllerNome = TextEditingController();

  TextEditingController _controllerSobrenome = TextEditingController();

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
                    "Cadastre-se",
                    style: tituloText,
                  ),
                ),
                TextForm(
                    readOnly: false,
                    controller: _controllerEmail,
                    hintText: "email",
                    inputType: TextInputType.emailAddress,
                    passTrue: false,
                    varValue: null),
                TextForm(
                    readOnly: false,
                    controller: _controllerSenha,
                    hintText: "senha",
                    inputType: TextInputType.visiblePassword,
                    passTrue: true,
                    varValue: null),
                Divider(),
                SizedBox(height: 20),
                TextForm(
                    readOnly: false,
                    controller: _controllerNome,
                    hintText: "nome",
                    inputType: TextInputType.text,
                    passTrue: false,
                    varValue: null),
                TextForm(
                    readOnly: false,
                    controller: _controllerSobrenome,
                    hintText: "sobrenome",
                    inputType: TextInputType.text,
                    passTrue: false,
                    varValue: null),
                Center(
                  child: CupertinoButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      UserModel().signUp(
                          userData: {
                            'email': _controllerEmail.text,
                            'nome': _controllerNome.text,
                            'sobrenome': _controllerSobrenome.text
                          },
                          pass: _controllerSenha.text,
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
