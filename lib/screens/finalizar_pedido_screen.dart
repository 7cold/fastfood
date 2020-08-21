import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/bottom_app_bar.dart';
import 'package:fastfood/widgets/cart_price.dart';
import 'package:fastfood/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:scoped_model/scoped_model.dart';

import 'order_screen.dart';

class FinalizarPedido extends StatefulWidget {
  @override
  _FinalizarPedidoState createState() => _FinalizarPedidoState();
}

class _FinalizarPedidoState extends State<FinalizarPedido> {
  updateTimer() {
    Timer(Duration(seconds: 10), () {
      CartModel.of(context).updatePrices();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTimer();
    double price = CartModel.of(context).getProductsPrice();
    double discount = CartModel.of(context).getDiscount();
    double ship = CartModel.of(context).getShipPrice();

    double total = (price + ship - discount);
    var totalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    totalMask.updateValue(total);

    return Scaffold(
      drawer: drawer(),
      appBar: appBarCustom(context, null, true, false, true),
      bottomNavigationBar: bottomAppBarCustomNav(context, () async {
        //_carregando();
        //await model.preferenceGetMP();
        String orderId = await CartModel.of(context).finishOrder();
        if (orderId != null) {
          //enviarNotificacao();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OrderScreen(orderId: orderId),
            ),
          );

          print("ok");
        }
      },
          totalMask.text != "R\$ 0,00"
              ? Text(
                  totalMask.text,
                  style: styleProdDetCat,
                )
              : CupertinoActivityIndicator(),
          "Finalizar"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return model.userData['nome'] == null
                    ? Center(child: CupertinoActivityIndicator())
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Endereço de entrega",
                              style: styleFinTitle,
                            ),
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Text(
                                          "Ouro Fino",
                                          style: styleFinTitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          model.userData['endereco'] +
                                              " ," +
                                              model.userData['endereco_num'],
                                          style: styleFinSubTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: Color(darkColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          model.userData['endereco_tipo'],
                                          style: styleFinTag,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    // return object of type AlertDialog
                                    child: new CupertinoAlertDialog(
                                      title: Text("Usar cupom de desconto"),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CupertinoTextField(
                                          onSubmitted: (text) {
                                            Firestore.instance
                                                .collection('fastfood')
                                                .document('fastfood')
                                                .collection('cupons')
                                                .document(text)
                                                .get()
                                                .then((docSnap) {
                                              if (docSnap.data != null) {
                                                CartModel.of(context).setCoupon(
                                                    text,
                                                    docSnap
                                                        .data['porcentagem']);
                                                print('ok');
                                                Navigator.of(context).pop();
                                              } else {
                                                CartModel.of(context)
                                                    .setCoupon(null, 0);
                                                Navigator.of(context).pop();
                                                // Scaffold.of(context).showSnackBar(SnackBar(
                                                //   content: Text("nao aplicado"),
                                                // ));
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: new Text("Cancelar"))
                                      ],
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Color(accentColor).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      CartModel.of(context)
                                                  .discountPercentage ==
                                              0
                                          ? "Adicionar cupom"
                                          : CartModel.of(context).couponCode,
                                      style: styleFinCupon,
                                    ),
                                    FlutterTicketWidget(
                                      height: 25,
                                      width: 100,
                                      isCornerRounded: false,
                                      color: Color(accentColor),
                                      child: Center(
                                          child: Text(
                                        CartModel.of(context)
                                                    .discountPercentage ==
                                                0
                                            ? "%"
                                            : CartModel.of(context)
                                                    .discountPercentage
                                                    .toString() +
                                                " %",
                                        style: styleFinTagEnd,
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(thickness: 0.8),
                          ],
                        ),
                      );
              },
            ),
            ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                if (model.products == null || model.products.length == 0) {
                  return CupertinoActivityIndicator();
                } else {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tipo de Entrega/Retirada",
                              textAlign: TextAlign.start,
                              style: styleFinTitle,
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ItemTipoRetirada(
                                  image: "assets/icons/entregador.png",
                                  label: "Entregar",
                                  tipo: "entregar",
                                  valor: 4.00,
                                ),
                                Stack(
                                  children: <Widget>[
                                    ItemTipoRetirada(
                                      image: "assets/icons/estou_aqui.png",
                                      label: "Estou Aqui",
                                      tipo: "estou_aqui",
                                      valor: 0.00,
                                    ),
                                    CartModel.of(context).getMesa() != ""
                                        ? Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black,
                                            ),
                                            child: Center(
                                              child: Text(
                                                CartModel.of(context).getMesa(),
                                                style: styleFinTagEnd,
                                              ),
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                ItemTipoRetirada(
                                  image: "assets/icons/pegar.png",
                                  label: "Irei Buscar",
                                  tipo: "irei_buscar",
                                  valor: 0.00,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Divider(thickness: 0.8),
                      ),
                      CartPrice(),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ItemTipoRetirada extends StatelessWidget {
  final String tipo;
  final String label;
  final String image;
  final double valor;

  const ItemTipoRetirada(
      {Key key, this.tipo, this.label, this.image, this.valor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CartModel.of(context).setShipping(tipo);
        CartModel.of(context).setShippingPrice(valor);
        tipo == "estou_aqui"
            ? showDialog(
                context: context,
                // return object of type AlertDialog
                child: new CupertinoAlertDialog(
                  title: Text("Qual o número da sua mesa?"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      onSubmitted: (text) {
                        CartModel.of(context).setMesa(text);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("Cancelar"))
                  ],
                ))
            : CartModel.of(context).setMesa("");
        print(CartModel.of(context).getShipping().toString());
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        decoration: CartModel.of(context).getShipping() == tipo
            ? BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: MediaQuery.of(context).size.width / 8,
            ),
            Text(
              label,
              style: styleProdDetTime,
            ),
          ],
        ),
      ),
    );
  }
}
