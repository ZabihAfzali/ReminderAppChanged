import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reminder_app/utils/utils.dart';

import '../Homescreens/homescreen.dart';



class SignInController with ChangeNotifier{


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  bool _loading=true;
  bool get loading =>_loading;

  setLoading(value){
    _loading=value;
    notifyListeners();
  }

  void signIn(BuildContext context, String email, String password)async{

    setLoading(true);

    try{
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value){

        utils.toastMessage('User Signed in successfully');
        setLoading(false);
        Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return HomeScreen();
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