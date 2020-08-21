import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/cart_product.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:fastfood/screens/products_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'nav_transition.dart';

class CardProduct extends StatefulWidget {
  final ProductData data;
  final String categoria;
  final DocumentSnapshot doc;

  const CardProduct({Key key, this.data, this.categoria, this.doc})
      : super(key: key);
  @override
  _CardProductState createState() => _CardProductState(data, categoria, doc);
}

class _CardProductState extends State<CardProduct> {
  final ProductData data;
  final String categoria;
  final DocumentSnapshot doc;

  _CardProductState(this.data, this.categoria, this.doc);

  double containerH = 30;
  double containerW = 30;

  final snackBar = SnackBar(
    elevation: 0.0,
    backgroundColor: CupertinoColors.activeGreen,
    behavior: SnackBarBehavior.floating,
    content: Text(
      "Adicionado ao carrinho! 🤩",
      style: styleProdDetTag,
    ),
  );

  @override
  Widget build(BuildContext context) {
    var precoTotalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    precoTotalMask.updateValue(data.preco);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, FadeRoute(page: ProductsDetailScreen(data, categoria)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(accentColor).withOpacity(0.85),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Hero(
                    tag: data.img,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          data.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.titulo,
                      style: styleProdCardTitle,
                    ),
                    data.peso == 0
                        ? Text(
                            data.ml.toString() + " ml",
                            style: styleProdCardSubTitle,
                          )
                        : Text(
                            data.peso.toString() + " g",
                            style: styleProdCardSubTitle,
                          )
                  ],
                ),
              ),
              Positioned(
                left: 15,
                bottom: 15,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantidade = 1;
                        cartProduct.pid = data.id;
                        cartProduct.categoria = doc.documentID;
                        cartProduct.productData = data;
                        CartModel.of(context).addCartItem(cartProduct);
                        setState(() {
                          containerH = 40;
                          containerW = 40;
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              containerH = 30;
                              containerW = 30;
                            });
                          });
                        });
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 800),
                        height: containerH,
                        width: containerW,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Color(accentColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        precoTotalMask.text,
                        style: styleProdCardTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
