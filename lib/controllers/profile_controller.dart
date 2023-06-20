import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:reminder_app/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../screens/login_screen.dart';


class ProfileController with ChangeNotifier{


  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  ImageProvider? imageProvider;
  final picker = ImagePicker();
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  DatabaseReference dbRef=FirebaseDatabase.instance.ref().child('user');
  User? currentUser = FirebaseAuth.instance.currentUser;

  bool _loading=true;
  bool get loading =>_loading;
  XFile? imageFile;
  XFile? get image=>imageFile;

  setLoading(value){
    _loading=value;
    notifyListeners();
  }


  Future pickImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      notifyListeners();
      uploadImageToFirebase(context);
    }


  }

  pickImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      notifyListeners();
      uploadImageToFirebase(context);
    }

  }

  Future uploadImageToFirebase(BuildContext context) async{

    setLoading(true);
    firebase_storage.Reference storageRef=firebase_storage.FirebaseStorage.instance.ref('/profileimage'+currentUser!.uid);

    firebase_storage.UploadTask uploadTask=storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl=await storageRef.getDownloadURL();

    dbRef.child(currentUser!.uid.toString()).update(
      {
      'profile_image_url':newUrl.toString(),
      }
    ).then((value){
      utils.toastMessage('picture uploaded successfully');
      imageFile=null;
    }).onError((error, stackTrace){
      utils.toastMessage(error.toString());
    });

  }

  void pickImage(BuildContext context){
    showDialog(context: context,
        builder: (
            BuildContext Context) {
          return AlertDialog(
            title: const Text(
              'Choose Option',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context);
                      pickImageFromCamera(context);
                    },
                    splashColor: Colors
                        .teal,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets
                              .all(
                              18.0),
                          child: Icon(
                            Icons
                                .camera,
                            color: Colors
                                .teal,),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w500,
                            color: Colors
                                .teal,
                          )
                          ,)
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors
                        .teal,
                    onTap: () {
                      Navigator.pop(
                          context);
                      pickImageFromGallery(
                          context);
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets
                              .all(
                              18.0),
                          child: Icon(
                            Icons
                                .image,
                            color: Colors
                                .teal,),
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w500,
                            color: Colors
                                .teal,
                          )
                          ,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


    // Get the current user









  Future<void> updateEmail(BuildContext context, String email,)async{


    print('Update email: $email');

    setLoading(true);
    ProgressDialog progressDialog = ProgressDialog(context,
      message: const Text("Updating email"),
      title: const Text("Please wait..."),
    );
    progressDialog.show();

    if (currentUser != null) {
      // Update the email
      try {
        await currentUser!.updateEmail(email).then((value) {
        progressDialog.dismiss();
        }).onError((error, stackTrace) {
          utils.toastMessage(error.toString());
        });
        print('Email updated successfully.');

        print('Password updated successfully.');
      } catch (e) {
        progressDialog.dismiss();
        print('Failed to update email: $e');
      }
    }
  }


  Future<void> updateName(BuildContext context, String username)async{

    ProgressDialog progressDialog = ProgressDialog(context,
      message: const Text("Updating name"),
      title: const Text("Please wait..."),
    );
    progressDialog.show();

    await dbRef.child(currentUser!.uid.toString()).update({
      'name' : username,
    }).then((value){
      progressDialog.dismiss();
      setLoading(false);
      Navigator.pop(context);
    }).onError((error, stackTrace){
      progressDialog.dismiss();
      utils.toastMessage(error.toString());
    });

  }


}
