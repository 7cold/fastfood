import 'package:fastfood/const/colors.dart';
import 'package:fastfood/const/fonts.dart';
import 'package:flutter/material.dart';

appBarCustom(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
    bool menu, bool menuActive, bool menuPop) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "FastFood",
        style: tituloAppBar,
      ),
      leading: menu == true
          ? menuActive == true
              ? Padding(
                  padding:
                      EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(primaryColor)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 3,
                              width: 24,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              height: 3,
                              width: 18,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : menuPop == true
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(primaryColor)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Color(secondaryColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
          : SizedBox());
}
