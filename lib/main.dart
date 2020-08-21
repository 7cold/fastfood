import 'package:fastfood/model/cart_model.dart';
import 'package:fastfood/screens/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/search_model.dart';
import 'model/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              return ScopedModel<SearchModel>(
                model: SearchModel(),
                child: ScopedModelDescendant<SearchModel>(
                  builder: (context, child, model) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: IndexScreen(),
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
