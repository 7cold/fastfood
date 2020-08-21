import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/screens/pesquisa_screen.dart';
import 'package:fastfood/screens/products_screen.dart';
import 'package:fastfood/widgets/appBar.dart';
import 'package:fastfood/widgets/drawer.dart';
import 'package:fastfood/widgets/nav_transition.dart';
import 'package:fastfood/widgets/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController pesquisar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> skHome = new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: skHome,
        appBar: appBarCustom(context, skHome, true, true, false),
        drawer: drawer(),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            String nomeSplit = model.userData['nome'].toString();
            List nomeLista = nomeSplit.split(" ");
            String nomeFormatado = nomeLista[0];
            return model.userData['nome'] == null
                ? Center(child: CupertinoActivityIndicator())
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                          child: Text(
                            DateTime.now().hour > 4 && DateTime.now().hour < 12
                                ? "Bom dia $nomeFormatado"
                                : DateTime.now().hour >= 12 &&
                                        DateTime.now().hour < 18
                                    ? "Boa Tarde $nomeFormatado"
                                    : DateTime.now().hour >= 18 &&
                                            DateTime.now().hour <= 24
                                        ? "Boa Noite $nomeFormatado"
                                        : DateTime.now().hour >= 0 &&
                                                DateTime.now().hour <= 4
                                            ? "Boa Madrugada $nomeFormatado"
                                            : "",
                            style: styleSaudacoes,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text(
                            DateTime.now().weekday == 1
                                ? "Boa Segunda-Feira"
                                : DateTime.now().weekday == 2
                                    ? "Boa Terça-Feira"
                                    : DateTime.now().weekday == 3
                                        ? "Boa Quarta-Feira"
                                        : DateTime.now().weekday == 4
                                            ? "Boa Quinta-Feira"
                                            : DateTime.now().weekday == 5
                                                ? "Boa Sexta-Feira"
                                                : DateTime.now().weekday == 6
                                                    ? "Bom Sábado"
                                                    : DateTime.now().weekday ==
                                                            7
                                                        ? "Bom Domingo"
                                                        : "",
                            style: styleSaudacoesDia,
                          ),
                        ),
                        SizedBox(height: 20),
                        Hero(
                          tag: "pesquisar",
                          child: Material(
                            child: TextForm(
                              onTap: () {
                                Navigator.push(
                                    context, FadeRoute(page: PesquisaScreen()));
                              },
                              readOnly: true,
                              controller: pesquisar,
                              hintText: "Pesquisar",
                              inputType: null,
                              passTrue: false,
                              varValue: null,
                              onChanged: (a) {
                                pesquisar.text = "";
                                Navigator.push(
                                    context, FadeRoute(page: PesquisaScreen()));
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                height: 45,
                                child: ListView(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: snapshot.data.documents.map((doc) {
                                    return CustomCardCategoria(
                                      doc: doc,
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                          child: Text(
                            "Sugestões para você 😉",
                            style: styleSaudacoesDia,
                          ),
                        ),
                        FutureBuilder<QuerySnapshot>(
                          future: Firestore.instance
                              .collection('fastfood')
                              .document("fastfood")
                              .collection("sugestoes")
                              .getDocuments(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else {
                              return Container(
                                child: Column(
                                  children: snapshot.data.documents.map((doc) {
                                    return CustomCardSugestoes(doc: doc);
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
          },
        ));
  }
}

class CustomCardSugestoes extends StatelessWidget {
  final DocumentSnapshot doc;

  CustomCardSugestoes({this.doc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('fastfood')
          .document('fastfood')
          .collection('categorias')
          .document(doc['categoria'])
          .collection('items')
          .document(doc['idProduto'])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new CupertinoActivityIndicator();
          default:
            return new Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(snapshot.data['lista_img'][0]),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Material(
                  color: Colors.white.withOpacity(0.8),
                  elevation: 10,
                  shadowColor: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 120,
                    child: Center(
                      child: Text(
                        snapshot.data['titulo'],
                        style: styleSugText,
                      ),
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class CustomCardCategoria extends StatelessWidget {
  final DocumentSnapshot doc;

  CustomCardCategoria({this.doc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductsScreen(
                    doc: doc,
                    titulo: doc['titulo'],
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(accentColor).withOpacity(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(doc['icon']),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                  child: Text(
                    doc['titulo'],
                    style: styleCatText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
