import 'dart:async';

import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/bottom_app_bar.dart';
import 'package:fastfood/widgets/drawer.dart';
import 'package:fastfood/widgets/products_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';
import 'finalizar_pedido_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> skCart = new GlobalKey<ScaffoldState>();

  updateTimer() {
    Timer(Duration(seconds: 5), () {
      CartModel.of(context).updatePrices();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTimer();
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        double price = model.getProductsPrice();
        var priceMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
        priceMask.updateValue(price);

        return Scaffold(
            key: skCart,
            drawer: drawer(),
            appBar: appBarCustom(context, skCart, true, false, true),
            bottomNavigationBar: bottomAppBarCustomNav(
                context,
                price == 0.0
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FinalizarPedido()));
                      },
                price != 0.0
                    ? Text(
                        priceMask.text,
                        style: styleProdDetCat,
                      )
                    : CupertinoActivityIndicator(),
                "Pedir"),
            body: model.products.length == 0
                ? Center(
                    child: Text(
                    "Nenhum produto, volte para continuar",
                    style: styleFinTitle,
                  ))
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: model.products.map((product) {
                          return ProductsCart(product);
                        }).toList(),
                      ),
                    ],
                  ));
      },
    );
  }
}
