import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/card_product.dart';
import 'package:fastfood/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ProductsScreen extends StatefulWidget {
  final DocumentSnapshot doc;
  final String titulo;

  ProductsScreen({@required this.doc, @required this.titulo});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final GlobalKey<ScaffoldState> skProd = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skProd,
      appBar: appBarCustom(context, skProd, true, true, false),
      drawer: drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  widget.titulo,
                  style: styleProdTitle,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<QuerySnapshot>(
                  future: Firestore.instance
                      .collection('fastfood')
                      .document('fastfood')
                      .collection('categorias')
                      .document(widget.doc.documentID)
                      .collection('items')
                      .getDocuments(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CupertinoActivityIndicator());
                    } else {
                      return snapshot.data.documents.length >= 1
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.only(left: 25, right: 25, top: 20),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                ProductData data = ProductData.fromDocument(
                                    snapshot.data.documents[index]);

                                var precoTotalMask =
                                    new MoneyMaskedTextController(
                                        leftSymbol: 'R\$ ');
                                precoTotalMask.updateValue(data.preco);

                                data.categoria = this.widget.doc.documentID;

                                return CardProduct(
                                    data: data,
                                    categoria: widget.titulo,
                                    doc: widget.doc);
                              },
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Não há Produtos,\nvolte para continuar!",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
