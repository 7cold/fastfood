import 'package:carousel_pro/carousel_pro.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/cart_product.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/bottom_app_bar.dart';
import 'package:fastfood/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cart_screen.dart';

class ProductsDetailScreen extends StatefulWidget {
  final ProductData product;
  final String categoria;

  const ProductsDetailScreen(this.product, this.categoria);

  @override
  _ProductsDetailScreenState createState() =>
      _ProductsDetailScreenState(product, categoria);
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  final ProductData product;
  final String categoria;

  _ProductsDetailScreenState(this.product, this.categoria);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> skProdDet = new GlobalKey<ScaffoldState>();
    var precoTotalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    precoTotalMask.updateValue(product.preco);
    var precoAntigoMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    precoAntigoMask.updateValue(product.precoAntigo);
    return Scaffold(
      key: skProdDet,
      appBar: appBarCustom(context, skProdDet, true, false, true),
      drawer: drawer(),
      bottomNavigationBar: bottomAppBarCustom(
        context,
        product,
        () {
          CartProduct cartProduct = CartProduct();
          cartProduct.quantidade = 1;
          cartProduct.pid = product.id;
          cartProduct.categoria = categoria;
          cartProduct.productData = product;
          CartModel.of(context).addCartItem(cartProduct);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CartScreen()));
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Hero(
              tag: product.img,
              child: Container(
                height: 200,
                color: Colors.white,
                child: Carousel(
                  animationCurve: Curves.elasticOut,
                  boxFit: BoxFit.cover,
                  autoplay: false,
                  dotSize: 0.0,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: Color(secondaryColor),
                  dotIncreasedColor: Color(primaryColor),
                  images: product.listaImg.map((url) {
                    return (NetworkImage(url));
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(product.titulo, style: styleProdDetTitle),
                  Text(precoTotalMask.text, style: styleProdDetTitle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
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
                      Text(categoria.toLowerCase(), style: styleProdDetCat),
                    ],
                  ),
                  product.preco == product.precoAntigo
                      ? SizedBox()
                      : Text(precoAntigoMask.text, style: styleProdDetPromo),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  product.tempoPreparo == 0
                      ? SizedBox()
                      : Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                  product.tempoPreparo.toString() + " min",
                                  style: styleProdDetTime),
                            ),
                          ],
                        ),
                  Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(right: 10, left: 0),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(primaryColor),
                          ),
                          child: product.ml == 0
                              ? Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 12,
                                  ),
                                )
                              : Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 12,
                                  ),
                                )),
                      product.ml == 0
                          ? Text(product.peso.toString() + " g",
                              style: styleProdDetTime)
                          : Text(product.ml.toString() + " ml",
                              style: styleProdDetTime),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                child: Text(
                  product.descricao,
                  style: styleProdDetDesc,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 15),
                  scrollDirection: Axis.horizontal,
                  children: product.tags.map((resultTag) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(accentColor).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(
                            resultTag,
                            style: styleProdDetTag,
                          ),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
