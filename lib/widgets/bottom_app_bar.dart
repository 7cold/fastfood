import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'button.dart';

bottomAppBarCustom(context, ProductData product, Function funcaoBotao) {
  var precoTotalMask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  precoTotalMask.updateValue(product.preco);
  return BottomAppBar(
    elevation: 10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(primaryColor),
              ),
              child: Icon(
                Icons.room_service,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                precoTotalMask.text,
                style: styleProdDetCat,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: ButtonPrimary(
            function: funcaoBotao,
            label: "Add ao Carrinho",
            minWidth: MediaQuery.of(context).size.width / 1.8,
          ),
        )
      ],
    ),
  );
}

bottomAppBarCustomNav(
    context, Function funcaoBotao, Widget preco, String label) {
  return BottomAppBar(
    elevation: 10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(primaryColor),
              ),
              child: Icon(
                Icons.room_service,
                size: 20,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0), child: preco)
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: ButtonPrimary(
            function: funcaoBotao,
            label: label,
            minWidth: MediaQuery.of(context).size.width / 1.8,
          ),
        )
      ],
    ),
  );
}
