import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  // final VoidCallback buy;

  // CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            double total = (price + ship - discount);

            var subMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            subMask.updateValue(price);
            var descMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            descMask.updateValue(discount);
            var shipMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            shipMask.updateValue(ship);
            var totalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
            totalMask.updateValue(total);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido",
                  style: styleFinTitle,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal",
                      style: styleFinSubTitle,
                    ),
                    Text(
                      subMask.text,
                      style: styleFinSubTitle,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Entrega",
                      style: styleFinSubTitle,
                    ),
                    Text(
                      shipMask.text,
                      style: styleFinSubTitle,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Desconto",
                      style: styleFinSubTitle,
                    ),
                    Text(
                      descMask.text,
                      style: styleFinSubTitle,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: styleFinTitle2,
                    ),
                    Text(
                      totalMask.text,
                      style: styleFinTitle2,
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
