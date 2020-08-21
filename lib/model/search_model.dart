import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/widgets/pesquisa.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchModel extends Model {
  var queryResultSet = [];
  var tempSearchStore = [];
  String categoria = "bebidas";

  select(docID) {
    categoria = docID;
    print(categoria);
    notifyListeners();
  }

  initiateSearch(value) {
    if (value.length == 0) {
      queryResultSet = [];
      tempSearchStore = [];
      notifyListeners();
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value, categoria).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i]);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['titulo'].startsWith(capitalizedValue)) {
          tempSearchStore.add(element);
          notifyListeners();
        }
      });
    }
  }
}
