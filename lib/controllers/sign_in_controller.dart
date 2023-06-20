import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
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
    ProgressDialog progressDialog = ProgressDialog(context,
      message: const Text("Signing In"),
      title: const Text("Please wait..."),
    );
    progressDialog.show();

    try{
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value){

        utils.toastMessage('User Signed in successfully');
        setLoading(false);
        progressDialog.dismiss();
        Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return HomeScreen();
        }));
      }).onError((error, stackTrace){
        setLoading(false);
        progressDialog.dismiss();
        utils.toastMessage(error.toString());
      }
      );
    }catch(e){
      setLoading(false);
      progressDialog.dismiss();
      utils.toastMessage(e.toString());
    }
  }

}