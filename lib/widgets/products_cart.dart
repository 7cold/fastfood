import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/cart_product.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsCart extends StatelessWidget {
  final CartProduct cartProduct;

  ProductsCart(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildProducts() {
      var precoTotalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
      precoTotalMask
          .updateValue(cartProduct.productData.preco * cartProduct.quantidade);

      return Column(
        children: <Widget>[
          Divider(
            thickness: 0.8,
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                          cartProduct.productData.img,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              cartProduct.quantidade.toString() + " X",
                              style: styleProdDetCat,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(cartProduct.productData.titulo,
                                style: styleProdDetCat),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              precoTotalMask.text,
                              style: styleProdCartTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconCategoria(cartProduct: cartProduct),
                            SizedBox(width: 20),
                            IconMgMl(cartProduct: cartProduct),
                          ],
                        ),
                        SizedBox(height: 10),
                        cartProduct.productData.tempoPreparo == 0
                            ? SizedBox()
                            : IconMinutos(cartProduct: cartProduct),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline,
                              color: cartProduct.quantidade > 1
                                  ? Color(darkColor)
                                  : CupertinoColors.inactiveGray),
                          onPressed: cartProduct.quantidade > 1
                              ? () {
                                  CartModel.of(context).decProduct(cartProduct);
                                }
                              : null,
                        ),
                        Text(
                          cartProduct.quantidade.toString(),
                          style: styleProdDetCat,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Color(darkColor),
                          ),
                          onPressed: () {
                            CartModel.of(context).incProduct(cartProduct);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            CartModel.of(context).removeCartItem(cartProduct);
                          },
                          icon: Icon(
                            CupertinoIcons.delete,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.8,
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('fastfood')
                  .document('fastfood')
                  .collection('categorias')
                  .document(cartProduct.categoria)
                  .collection('items')
                  .document(cartProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildProducts();
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            )
          : _buildProducts(),
    );
  }
}

class IconMinutos extends StatelessWidget {
  final CartProduct cartProduct;

  const IconMinutos({Key key, this.cartProduct}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(primaryColor),
          ),
          child: Icon(
            Icons.access_time,
            color: Color(secondaryColor),
            size: 12,
          ),
        ),
        SizedBox(width: 10),
        Text(cartProduct.productData.tempoPreparo.toString() + " min",
            style: styleProdDetTime),
      ],
    );
  }
}

class IconMgMl extends StatelessWidget {
  final CartProduct cartProduct;

  const IconMgMl({Key key, this.cartProduct}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(primaryColor),
          ),
          child: Icon(
            Icons.check,
            color: Color(darkColor),
            size: 12,
          ),
        ),
        SizedBox(width: 10),
        cartProduct.productData.ml == 0
            ? Text(cartProduct.productData.peso.toString() + " g",
                style: styleProdDetTime)
            : Text(cartProduct.productData.ml.toString() + " ml",
                style: styleProdDetTime),
      ],
    );
  }
}

class IconCategoria extends StatelessWidget {
  final CartProduct cartProduct;

  const IconCategoria({Key key, this.cartProduct}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(accentColor).withOpacity(0.4),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.utensils,
              color: Colors.white,
              size: 12,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(cartProduct.categoria, style: styleProdDetTime),
      ],
    );
  }
}
