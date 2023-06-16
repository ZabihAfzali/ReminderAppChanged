
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/theme_texts.dart';


class WidgetsReusing {


  static Widget GetTextButtonfill(
      context, String text, onTap, ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,

        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:  Color(0xFF222951),
            border: Border.all(
              // color: Theme.of(context).colorScheme.secondary,
              color: Colors.black87,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 50,
        child: Text(
            text,
            style: ThemeTexts.button_text_fill
        ),
      ),

    );
  }

  static Widget GetTextButtonTransparent(
      context, String text, onTap, ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,

        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFFFFBD12),
            border: Border.all(
              // color: Theme.of(context).colorScheme.secondary,
              color: Colors.black87,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 50,
        child: Text(
            text,
            style: ThemeTexts.button_text_transparent
        ),
      ),
    );
  }





//========= Get Appbar Widgets ============================================

}
