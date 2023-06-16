import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeTexts {
  ThemeTexts._();

  static const String font_bold = "Inter-Bold";
  static const String font_semi_bold = "Inter-SemiBold";
  static const String font_medium = "Inter-Medium";
  static const String font_regular = "Inter-Regular";



  static const textStyleBold = TextStyle(
      fontSize: 23,
      color: Color(0xFF222951),
      letterSpacing: 1,
      decoration: TextDecoration.none,
      fontFamily: font_bold);

  static const textStyleSemiBold = TextStyle(
      fontSize: 20,
      color: Color(0xFF222951),

      decoration: TextDecoration.none,
      fontFamily: font_semi_bold);

  static const textStyleMedium = TextStyle(
      fontSize: 18,
      color: Color(0xFF222951),

      decoration: TextDecoration.none,
      fontFamily: font_medium );

  static const textStyleRegular = const TextStyle(
      fontSize: 23,
      color: Color(0xFF222951),
      fontWeight: FontWeight.w400,

      decoration: TextDecoration.none,
      fontFamily: font_regular);

  static var appbar_text_style = textStyleRegular.copyWith(color: Colors.black);
  static var action_text_style =
  textStyleRegular.copyWith(color: Colors.black);

  static var button_text_fill = textStyleRegular.copyWith(color: Colors.white ,fontWeight: FontWeight.w700, fontSize: 15);
  static var button_text_transparent = textStyleRegular.copyWith(fontWeight: FontWeight.w700 , fontSize: 15);
  static var snakbar_text = TextStyle(
      color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w600);

  static const textCupertinoTitleStyle = textStyleRegular;



  static var textormfield_lable = TextStyle(
    fontSize: 20,
    fontFamily: font_regular,
    fontWeight: FontWeight.w600,
  );

  static var textormfield_value = TextStyle(
    fontSize: 3,
    fontFamily: font_regular,
    //fontWeight: FontWeight.w200,
  );

  static var textormfield_hint = TextStyle(
    fontSize: 20,
    fontFamily: font_regular,
    fontWeight: FontWeight.w600,
      color: Colors.grey
  );



}
