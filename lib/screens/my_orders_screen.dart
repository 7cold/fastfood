import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/model/user_model.dart';
import 'package:fastfood/widgets/my_orders_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return Scaffold(
        body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection('fastfood')
                .document('fastfood')
                .collection("usuarios")
                .document(uid)
                .collection("ordens")
                .orderBy("date")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: snapshot.data.documents
                      .map((doc) => MyOrdersItems(doc.documentID))
                      .toList()
                      .reversed
                      .toList(),
                );
              }
            },
          ),
        ),
      );
    } else {
      return Scaffold(body: SizedBox());
    }
  }
}
