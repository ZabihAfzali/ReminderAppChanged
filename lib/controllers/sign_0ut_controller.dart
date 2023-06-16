import 'package:flutter/material.dart';


// class SignOutController{
//
//   Future<bool> signOutUser() async {
//     FirebaseUser user=await firebaseAuth.currentUser();
//
//     if(user.providerData[1].providerId=='google.com'){
//       await googleSignin.dissconnect();
//     }
//     else{
//       await firebaseAuth.signOut;
//     }
//   }
// }