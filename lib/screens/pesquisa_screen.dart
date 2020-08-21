import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/datas/product_data.dart';
import 'package:fastfood/model/search_model.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/card_product.dart';
import 'package:fastfood/widgets/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: appBarCustom(context, null, true, false, true),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ScopedModelDescendant<SearchModel>(
            builder: (context, child, model) {
              return Column(children: <Widget>[
                FutureBuilder<QuerySnapshot>(
                  future: Firestore.instance
                      .collection('fastfood')
                      .document("fastfood")
                      .collection("categorias")
                      .getDocuments(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else {
                      return Container(
                        height: 40,
                        child: ListView(
                          padding: const EdgeInsets.only(right: 25, left: 25),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data.documents.map((doc) {
                            return GestureDetector(
                              onTap: () {
                                model.select(doc.documentID);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                    color: Color(
                                        doc.documentID == model.categoria
                                            ? accentColor
                                            : primaryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Text(doc.documentID.toUpperCase(),
                                        style: doc.documentID == model.categoria
                                            ? styleProdDetTag
                                            : styleProdDetCat),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Hero(
                    tag: "pesquisar",
                    child: Material(
                      child: TextForm(
                          readOnly: false,
                          controller: null,
                          hintText: "Pesquisar",
                          inputType: TextInputType.text,
                          passTrue: false,
                          onChanged: (val) {
                            model.initiateSearch(val);
                          },
                          varValue: null),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    primary: false,
                    shrinkWrap: true,
                    children: model.tempSearchStore.map((data) {
                      return buildResultCard(data, context, model.categoria);
                    }).toList())
              ]);
            },
          ),
        ));
  }
}

Widget buildResultCard(dataFire, context, categoria) {
  ProductData data = ProductData.fromDocument(dataFire);

  return CardProduct(
    data: data,
    doc: dataFire,
    categoria: categoria,
  );
}
