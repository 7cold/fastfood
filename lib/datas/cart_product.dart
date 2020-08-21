import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/datas/product_data.dart';

class CartProduct {
  String cid;

  String categoria;
  String pid;
  int quantidade;
  Timestamp date;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    categoria = document.data['categoria'];
    pid = document.data['pid'];
    quantidade = document.data['quantidade'];
    //date = document.data['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria.toLowerCase(),
      "pid": pid,
      "quantidade": quantidade,
      //"date": date,
      "produto": productData.toResumeMap(),
    };
  }
}
