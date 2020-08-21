import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/screens/cart_screen.dart';
import 'package:fastfood/screens/home_screen.dart';
import 'package:fastfood/screens/index_screen.dart';
import 'package:fastfood/screens/my_orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

drawer() {
  return ScopedModelDescendant<UserModel>(
    builder: (context, child, model) {
      String nomeSplit = model.userData['nome'].toString();
      List nomeLista = nomeSplit.split(" ");
      String nomeFormatado = nomeLista[0];
      return new Drawer(
        elevation: 0.5,
        child: model.userData['nome'] == null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Color(primaryColor),
                child: CupertinoActivityIndicator())
            : SafeArea(
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(nomeFormatado, style: styleDrawerTitle),
                            SizedBox(height: 10),
                            Text(model.firebaseUser.email,
                                style: styleDrawerEmail),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.8,
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Item(FontAwesomeIcons.home, "Home",
                                    HomeScreen(), true),
                                Item(FontAwesomeIcons.shoppingCart, "Carrinho",
                                    CartScreen(), false),
                                Item(FontAwesomeIcons.shoppingCart,
                                    "Meus Pedidos", MyOrdersScreen(), false),
                                Item(FontAwesomeIcons.userAlt, "Meu Perfil",
                                    HomeScreen(), false),
                                Item(FontAwesomeIcons.commentAlt, "Mensagens",
                                    HomeScreen(), false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            child: Text("Sair"),
                            onPressed: () {
                              model.signOut(onSucess: () {
                                print('suc');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => IndexScreen()));
                              }, onFail: () {
                                print('fail');
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
      );
    },
  );
}

class Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget rota;
  final bool replace;

  const Item(this.icon, this.label, this.rota, this.replace);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            replace == true
                ? Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => rota))
                : Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => rota));
          },
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                FaIcon(icon),
                SizedBox(width: 15),
                Text(label, style: styleDrawerMenu)
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
