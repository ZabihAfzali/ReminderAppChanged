import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils{


  static void fieldFocus(BuildContext context, FocusNode currentNode, FocusNode nextFocus){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);


  }

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
    backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16,
      toastLength: Toast.LENGTH_LONG
    );
  }
}