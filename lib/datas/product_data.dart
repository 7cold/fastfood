import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String categoria;
  String id;
  String titulo;
  String descricao;
  String img;
  int peso;
  int ml;
  int tempoPreparo;
  double preco;
  double precoAntigo;
  List listaImg;
  List tags;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    titulo = snapshot.data['titulo'];
    peso = snapshot.data['peso'];
    preco = snapshot.data['preco'] + 0.0;
    ml = snapshot.data['ml'];
    img = snapshot.data['img'];
    tempoPreparo = snapshot.data['tempo_preparo'];
    precoAntigo = snapshot.data['preco_antigo'] + 0.0;
    listaImg = snapshot.data['lista_img'];
    tags = snapshot.data['tags'];
    descricao = snapshot.data['descricao'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "titulo": titulo,
      "descricao": descricao,
      "preco": preco,
    };
  }
}
