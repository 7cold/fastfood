import 'package:fastfood/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String fontHeavy = "FontHeavy";
const String fontBold = "FontBold";
const String fontLight = "FontLight";
const String fontMedium = "FontMedium";
const String fontRegular = "FontRegular"; //textos
const String fontSemiBold = "FontSemiBold";
const String fontThin = "FontThin";
const String fontUltraLight = "FontUltraLight";

TextStyle tituloAppBar = TextStyle(
  fontFamily: fontBold,
  color: Color(secondaryColor),
  fontSize: 22,
);

TextStyle tituloText = TextStyle(
  fontFamily: fontHeavy,
  color: Color(secondaryColor),
  fontSize: 24,
);

TextStyle styleButton = TextStyle(
  fontFamily: fontBold,
  color: Colors.white,
  fontSize: 16,
);

// Home Screen
TextStyle styleSaudacoes = TextStyle(
  fontFamily: fontSemiBold,
  color: CupertinoColors.inactiveGray,
  fontSize: 18,
);

TextStyle styleSaudacoesDia = TextStyle(
  fontFamily: fontBold,
  color: Color(secondaryColor),
  fontSize: 24,
);

TextStyle styleCatText = TextStyle(
  fontFamily: fontHeavy,
  color: Colors.white,
  fontSize: 14,
);

TextStyle styleSugText = TextStyle(
  fontFamily: fontHeavy,
  color: Color(secondaryColor),
  fontSize: 14,
);

//products

TextStyle styleProdTitle = TextStyle(
  fontFamily: fontHeavy,
  color: Color(secondaryColor),
  fontSize: 24,
);

TextStyle styleProdCardTitle = TextStyle(
  fontFamily: fontHeavy,
  color: Colors.white,
  fontSize: 18,
);

TextStyle styleProdCardSubTitle = TextStyle(
  fontFamily: fontSemiBold,
  color: Colors.white,
  fontSize: 16,
);

//products detail

TextStyle styleProdDetTitle = TextStyle(
  fontFamily: fontHeavy,
  color: Color(secondaryColor),
  fontSize: 20,
);

TextStyle styleProdDetCat = TextStyle(
  fontFamily: fontHeavy,
  color: Color(secondaryColor),
  fontSize: 16,
);

TextStyle styleProdDetTag = TextStyle(
  fontFamily: fontHeavy,
  color: Colors.white,
  fontSize: 16,
);

TextStyle styleProdDetTime = TextStyle(
  fontFamily: fontBold,
  color: Color(secondaryColor),
  fontSize: 14,
);

TextStyle styleProdDetDesc = TextStyle(
  fontFamily: fontBold,
  color: CupertinoColors.inactiveGray,
  height: 2,
  fontSize: 14,
);

TextStyle styleProdDetPromo = TextStyle(
    fontFamily: fontHeavy,
    color: CupertinoColors.inactiveGray,
    fontSize: 18,
    decoration: TextDecoration.lineThrough);

//cart

TextStyle styleProdCartTitle = TextStyle(
  fontFamily: fontHeavy,
  color: CupertinoColors.inactiveGray,
  fontSize: 16,
);

TextStyle styleProdCartCat = TextStyle(
  fontFamily: fontRegular,
  color: Color(darkColor),
  fontSize: 16,
);

// finalizar pedido

TextStyle styleFinTitle = TextStyle(
  fontFamily: fontHeavy,
  color: CupertinoColors.inactiveGray,
  fontSize: 18,
);

TextStyle styleFinTitle2 = TextStyle(
  fontFamily: fontHeavy,
  color: Color(darkColor),
  fontSize: 18,
);
TextStyle styleFinSubTitle = TextStyle(
  fontFamily: fontSemiBold,
  color: Color(darkColor),
  fontSize: 16,
);

TextStyle styleFinTagEnd = TextStyle(
  fontFamily: fontSemiBold,
  color: Colors.white,
  fontSize: 16,
);
TextStyle styleFinTag = TextStyle(
  fontFamily: fontSemiBold,
  color: Colors.white,
  fontSize: 14,
);

TextStyle styleFinCupon = TextStyle(
  fontFamily: fontHeavy,
  color: Color(darkColor),
  fontSize: 14,
);

// drawer

TextStyle styleDrawerTitle = TextStyle(
  fontFamily: fontHeavy,
  color: Color(darkColor),
  fontSize: 22,
);

TextStyle styleDrawerMenu = TextStyle(
  fontFamily: fontBold,
  color: Color(darkColor),
  fontSize: 18,
);

TextStyle styleDrawerEmail = TextStyle(
  fontFamily: fontMedium,
  color: CupertinoColors.inactiveGray,
  fontSize: 16,
);

// drawer

TextStyle styleOrderTitle = TextStyle(
  fontFamily: fontHeavy,
  color: Color(darkColor),
  fontSize: 24,
);
TextStyle styleOrderSubTitle = TextStyle(
  fontFamily: fontMedium,
  color: CupertinoColors.inactiveGray,
  fontSize: 18,
);
