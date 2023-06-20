

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ndialog/ndialog.dart';
import 'package:reminder_app/utils/utils.dart';
import 'package:flutter/foundation.dart';

import '../Homescreens/homescreen.dart';





class SignInWithGoogle with ChangeNotifier {

  String? strEmail;
  String? strUserName;
  String? strPassword;

  bool _loading=true;
  bool get loading =>_loading;

  setLoading(value){
    _loading=value;
    notifyListeners();
  }

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  DatabaseReference dbRef=FirebaseDatabase.instance.ref().child('user');


  void googleSignUp(BuildContext context) async {

    // ProgressDialog progressDialog = ProgressDialog(context,
    //   message: const Text("Signing Up"),
    //   title: const Text("Please wait..."),
    // );
    // progressDialog.show();

    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth = await googleuser!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    strUserName=userCredential.user!.displayName;
    strEmail=userCredential.user!.email;

    print("..........${userCredential.user!.displayName}");
    if (userCredential.user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx){
        return HomeScreen();
      }));
    }

    if(firebaseAuth.currentUser!=null) {
      try {
        dbRef.child(firebaseAuth.currentUser!.uid.toString()).set({
          'uid': firebaseAuth.currentUser!.uid.toString(),
          'name:': strUserName,
          'email:': strEmail,
          'date': DateTime.now().toString(),
        }).then((value) {
          setLoading(false);
          utils.toastMessage('user database created successfully');
        });
      } catch (e) {
        utils.toastMessage(e.toString());
      }


    }

  }





  }


