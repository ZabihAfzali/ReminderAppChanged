import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/utils/utils.dart';


import '../screens/login_screen.dart';


class SignUpController with ChangeNotifier{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  DatabaseReference dbRef=FirebaseDatabase.instance.ref().child('user');

  bool _loading=true;
  bool get loading =>_loading;

  setLoading(value){
    _loading=value;
    notifyListeners();
  }



  Future<void> signUp(BuildContext context,String username, String email, String password)async{

    setLoading(true);


      try{
        firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){
          dbRef.child(value.user!.uid.toString()).set({
            'uid:' : value.user!.uid.toString(),
            'name:' : username,
            'email:':value.user!.email,
            'date:':DateTime.now().toString(),
          }).then((value){
            setLoading(false);
            Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return LoginScreen();
            }));
          });

          utils.toastMessage('User created successfully');
          setLoading(false);
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
