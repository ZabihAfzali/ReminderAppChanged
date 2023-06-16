import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/screens/login_screen.dart';
import 'package:reminder_app/utils/utils.dart';



class ForgotPasswordController with ChangeNotifier{


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  bool _loading=true;
  bool get loading =>_loading;

  setLoading(value){
    _loading=value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email)async{

    setLoading(true);

    try{
      firebaseAuth.sendPasswordResetEmail(email: email).then((value){

        utils.toastMessage('email sent successfully');
        setLoading(false);
        Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return LoginScreen();
        }));
      }).onError((error, stackTrace){
        setLoading(false);
        utils.toastMessage(error.toString());
      }
      );
    }catch(e){
      setLoading(false);
      utils.toastMessage(e.toString());
    }
  }

}