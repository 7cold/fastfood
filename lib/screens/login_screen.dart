import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/screens/sign_up_google_screen.dart';
import 'package:fastfood/screens/sign_up_screen.dart';
import 'package:fastfood/widgets/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Timer _timer;

  // showAlertDialog(BuildContext c) {
  //   showDialog(
  //       context: c,
  //       builder: (c) {
  //         Future.delayed(Duration(milliseconds: 130), () {
  //           Navigator.of(c).pop(true);
  //         });
  //         return AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           elevation: 0,
  //           content: Center(
  //             child: CupertinoActivityIndicator(),
  //           ),
  //         );
  //       });
  // }

  // _LoginScreenState() {
  //   _timer = new Timer(const Duration(milliseconds: 0), () {
  //     setState(() {
  //       Future.delayed(Duration.zero, () => showAlertDialog(context));
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/capa.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 270),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextForm(
                              readOnly: false,
                              controller: null,
                              hintText: "email",
                              inputType: TextInputType.emailAddress,
                              passTrue: false,
                              varValue: null)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: TextForm(
                              readOnly: false,
                              controller: null,
                              hintText: "pass",
                              inputType: TextInputType.text,
                              passTrue: false,
                              varValue: null)),
                      // ButtonPrimary(),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 20),
                      //   child: Center(
                      //     child: Text(
                      //       'Forgot your password?',
                      //       style: TextStyle(
                      //           fontSize: 15, fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                                TextSpan(
                                    text: "sign up",
                                    style: TextStyle(
                                      color: Color(0xffff2d55),
                                      fontSize: 15,
                                    ))
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: RaisedButton(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/icons/google.png",
                                    height: 30,
                                  ),
                                ),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: CupertinoColors.inactiveGray),
                                )
                              ],
                            ),
                            onPressed: () async {
                              await model.signInGoogle().then((value) {
                                model.userData != null
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()))
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpGoogleScreen()));
                              }).catchError((e) {
                                print("error");
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
