import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/screens/my_orders_screen.dart';
import 'package:fastfood/widgets/button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  const OrderScreen({Key key, this.orderId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: FlareActor(
                        "assets/animation/transporte.flr",
                        animation: "animation 1",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      child: Text(
                        "Pedido realizado com sucesso!",
                        style: styleOrderTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Obrigado! Aguarde, em poucos minutos você receberá uma confirmação pelo seu WhatsApp, ou se preferir acesse o menu 'Minhas Encomendas'",
                      style: styleOrderSubTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Código do pedido: ',
                        style: styleFinTitle2,
                        children: <TextSpan>[
                          TextSpan(text: '$orderId', style: styleFinTitle2),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 30),
                    ButtonPrimary(
                      label: "Minhas Encomendas",
                      function: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()));
                      },
                      minWidth: MediaQuery.of(context).size.width / 2.2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
