import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField, String categoria) {
    return Firestore.instance
        .collection('fastfood')
        .document('fastfood')
        .collection('categorias')
        .document(categoria)
        .collection('items')
        .where('key', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
